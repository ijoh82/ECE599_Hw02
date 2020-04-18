#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Float32.h"
#include "sensor_msgs/LaserScan.h"
#include "geometry_msgs/Vector3.h"
#include "joh_gap_finding/gaps.h"

/*
// set data type "gaps"
class gaps{
  public:
    int numOfGap;
    std::list<float> width;
    std::list<float> depth;
};
*/


// Read speed input signal
// (angleMin=-2.355, angleMax=2.355, angleIncr=0.004365, numAngle=1080)
int sizeLidarData;
std::vector<float> lidarData;
void getLidarData(const sensor_msgs::LaserScan lidarDataRaw) {
  lidarData = lidarDataRaw.ranges;
  sizeLidarData = lidarDataRaw.ranges.size();
}




// Perform K-mean clustering
void kMeanCluster(int numCluster, std::vector<float> data, int sizeData, int sizeImplement, 
                 float weightClusterDist, gaps myGap) {
  float distMax;
  int   anglMax;
  float metricTry;
  float metricSettle;
  int   whichClusterSettle;
  int   assignCluster;
  bool  isClusterChanged;
  int   iterSkip  =  sizeData / sizeImplement;
  int   iterStart = (sizeData % sizeImplement) / 2;

  int   dataWhichCluster[sizeData];
  float dataAnglNorm    [sizeData];
  float dataDistNorm    [sizeData];
  float dataMetric      [sizeData];

  int   sizeEachCluster   [numCluster];
  float aveAnglEachCluster[numCluster];
  float aveDistEachCluster[numCluster];

  // normalize data
  distMax = 0;
  for (int i=iterStart; i<sizeData; i=i+iterSkip) {
    if (data[i] > distMax) {
      distMax = data[i];
    }
  }
  anglMax = iterStart + iterSkip*(sizeImplement-2);
  for (int i=iterStart; i<sizeData; i=i+iterSkip) {
    dataAnglNorm[i] = (float)i / (float)(anglMax);
    dataDistNorm[i] = data[i]  / distMax;
  }

  // Assign cluster numbers in random way
  assignCluster = 0;
  for (int i=iterStart; i<sizeData; i=i+iterSkip) {
    if (i >= (assignCluster+1)*sizeData/numCluster) {
      assignCluster ++;
    }
    dataWhichCluster[i] = assignCluster;
  }
  isClusterChanged = true;

  while (isClusterChanged) {
    isClusterChanged = false;
    // get centroid (average) of each cluster
    for (int k=0; k<numCluster; k++) {
      sizeEachCluster[k] = 0;
      aveAnglEachCluster[k] = 0.0;
      aveDistEachCluster[k] = 0.0;
    }
    for (int i=iterStart; i<sizeData; i=i+iterSkip) {
      sizeEachCluster   [dataWhichCluster[i]] = sizeEachCluster   [dataWhichCluster[i]] + 1;
      aveAnglEachCluster[dataWhichCluster[i]] = aveAnglEachCluster[dataWhichCluster[i]] 
                                                + dataAnglNorm[i];
      aveDistEachCluster[dataWhichCluster[i]] = aveDistEachCluster[dataWhichCluster[i]] 
                                                + dataDistNorm[i];
    }
    for (int k=0; k<numCluster; k++) {
      aveAnglEachCluster[k] = aveAnglEachCluster[k] / sizeEachCluster[k];
      aveDistEachCluster[k] = aveDistEachCluster[k] / sizeEachCluster[k];
    }


    // compute WEIGHTED metric distance between a datapoint and a cluster average
    for (int i=iterStart; i<sizeData; i=i+iterSkip) {
        int k = dataWhichCluster[i];
        dataMetric[i] = sqrt(
            (dataAnglNorm[i]-aveAnglEachCluster[k]) * (dataAnglNorm[i]-aveAnglEachCluster[k])
          + (dataDistNorm[i]-aveDistEachCluster[k]) * (dataDistNorm[i]-aveDistEachCluster[k])
            * weightClusterDist * weightClusterDist);
    } // end for

    // compute minimal WEIGHTED metric distance and change cluster
    for (int i=iterStart; i<sizeData; i=i+iterSkip) {
      metricSettle       = dataMetric[i];
      whichClusterSettle = dataWhichCluster[i];
      for (int k=0; k<numCluster; k++) {
        metricTry = sqrt(
            (dataAnglNorm[i]-aveAnglEachCluster[k]) * (dataAnglNorm[i]-aveAnglEachCluster[k])
          + (dataDistNorm[i]-aveDistEachCluster[k]) * (dataDistNorm[i]-aveDistEachCluster[k])
            * weightClusterDist * weightClusterDist);
        if (metricTry < metricSettle) {
            metricSettle       = metricTry;
            whichClusterSettle = k;
        } // end if
      } // end for k
      if (whichClusterSettle != dataWhichCluster[i]) {
        dataMetric[i]       = metricSettle;
        dataWhichCluster[i] = whichClusterSettle;
        isClusterChanged = true;
      } // end if
    } // end for i
  } // end while


  // judge by distance
  int whichClusterHasMinDist = 0;
  int whichClusterHasMaxDist = 0;
  float distJudge;
  bool isGapEachCluster[numCluster];
  for (int k=1; k<numCluster; k++) { // k=1
    if (aveDistEachCluster[k] > whichClusterHasMaxDist) {
      whichClusterHasMaxDist = k;
    }
    if (aveDistEachCluster[k] < whichClusterHasMinDist) {
      whichClusterHasMinDist = k;
    }
  }
  distJudge 
    = (aveDistEachCluster[whichClusterHasMaxDist] 
     + aveDistEachCluster[whichClusterHasMinDist]) / 2;
  for (int k=0; k<numCluster; k++) {
    if (aveDistEachCluster[k] > distJudge) {
      isGapEachCluster[k] = true;
    } else {
      isGapEachCluster[k] = false;
    }
  }

  // finding number of gaps and width
  myGap.numOfGap = 0;
  for (int k=0; k<numCluster; k++) {
    if (isGapEachCluster[k]) {
      myGap.numOfGap ++;
    }
  }
} // end kMeanCluster








int main(int argc, char **argv) {
  // Activate the program by the node name
  ros::init(argc, argv, "find_gap");
  ros::NodeHandle n;

  // call subscriber by specifying the topic to receive
  ros::Subscriber sub = n.subscribe("/scan", 1000, getLidarData);

  // Call publisher by specifying the topic to send
//  ros::Publisher pub = n.advertise<std_msgs::String>("lidar_gaps", 1000);
  ros::Publisher pub = n.advertise<joh_gap_finding::gaps>("lidar_gaps", 1000);

  // Set frequency of publisher 
  int freq = 5;                // In [Hz]
  ros::Rate loop_rate(freq);

  // variables in algorithm
  int count = 0;               // loop counter (to apply controlled delay)
  int countDelay = 10;         // intentional delay (to prevent starting error)
  int countLimit = 1000;       // upper limit of counting (to prevent overflow)

  int numCluster = 4;          // num of Cluster
  int sizeImplement = 32;      // num of iteration in Lidar data
  float weightCluster = 10.0;  // weight used for k-Mean clustering 
  int kClusterOutput = 0;

  while (ros::ok()) {

    //variables
    joh_gap_finding::gaps myGap;
    myGap.numOfGaps = 2;
    
    // Perform K-Mean Clustering
    kMeanCluster(numCluster, lidarData, sizeLidarData, sizeImplement, 
                                  weightCluster, myGap);

    // set the message to send
//    std_msgs::String msg;
//    std::stringstream ss;
    

    // set the variable to send
//    ss << myGap;
//    msg.data = ss.str();
//    ROS_INFO("%s", msg.data.c_str());    
    ROS_INFO_STREAM("num=" << myGap.numOfGap);

    // publish the message to send
//    pub.publish(msg);
    pub.publish(myGap);

    // Calll back background threads
    ros::spinOnce();
    
    // Control frequency of loop
    loop_rate.sleep();


    count = (count+1) % countLimit;
  }
  // call back background threads
  ros::spin(); 
  return 0;
}
