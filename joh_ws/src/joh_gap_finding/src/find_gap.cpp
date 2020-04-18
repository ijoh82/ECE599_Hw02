#include "ros/ros.h"
#include "sensor_msgs/LaserScan.h"
#include "geometry_msgs/Vector3.h"
#include "joh_gap_finding/gaps.h"


// (angleMin=-2.355, angleMax=2.355, angleIncr=0.004365, numAngle=1080)
float angleMin = -2.355;
float angleMax =  2.355;
int   angleCnt = 1080;
// float angleIncre = 0.04365;
float angleIncr = (angleMax - angleMin) / (float)angleCnt;


// Read speed input signal
int sizeLidarData;
std::vector<float> lidarData;
void getLidarData(const sensor_msgs::LaserScan lidarDataRaw) 
{
  lidarData = lidarDataRaw.ranges;
  sizeLidarData = lidarDataRaw.ranges.size();
}




// Handle smaller data
template<class T>
std::vector<T> shrinkData(std::vector<T> bigData, int sizeSmallData) 
{
    int sizeBigData = bigData.size();
    int iterInc   =  sizeBigData / sizeSmallData;
    int iterStart = (sizeBigData % sizeSmallData) / 2;
    std::vector<T> smallData(sizeSmallData, 0);
    for (int i=0; i<sizeSmallData; i++) 
    {
        smallData[i] = bigData[i*iterInc + iterStart];
    }
    return smallData;
}




// Convert iterator data from Lidar data
std::vector<int> LdToIter(std::vector<float> LdData) 
{
    int sizeData = LdData.size();
    std::vector<int> iterData (sizeData, 0);
    for (int i=0; i<sizeData; i++) 
    {
        iterData[i] = i;
    }
    return iterData;
}




// Convert Lidar iterator into angle rad
std::vector<float> iterToAngle(std::vector<int> iterData) 
{
    int sizeData = iterData.size();
    std::vector<float> angleData(sizeData, 0);
    for (int i=0; i<sizeData; i++) 
    {
        angleData[i] = angleMin +  (float)(iterData[i]) * angleIncr;
    }
    return angleData;
}




// Convert distData and angleData into x-coord
std::vector<float> distNAngleToCoordX(std::vector<float> distData, 
                                      std::vector<float> anglData) 
{
    if (distData.size() != anglData.size()) 
    {
        printf("Warning: size not matching in making x-Coord data.\n");
    }
    int sizeData = distData.size();
    std::vector<float> coordXData(sizeData, 0);
    for (int i=0; i<sizeData; i++) 
    {
        coordXData[i] = distData[i] * cos(anglData[i]);
    }
    return coordXData;
}




// Convert distData and angleData into y-coord
std::vector<float> distNAngleToCoordY(std::vector<float> distData,
                                      std::vector<float> anglData) 
{
    if (distData.size() != anglData.size()) 
    {
        printf("Warning: size not matching in making y-Coord data.\n");
    }
    int sizeData = distData.size();
    std::vector<float> coordYData(sizeData, 0);
    for (int i=0; i<sizeData; i++) 
    {
        coordYData[i] = distData[i] * sin(anglData[i]);
    }
    return coordYData;
}






// Perform K-mean clustering
std::vector<int> kMeanCluster(std::vector<float> data0, std::vector<float> data1,
                             int numClst, float weight) 
{
    if (data0.size() != data1.size()) 
    {
        printf("Warning: size of two data not matching in clustering.\n");
    }
    int sizeData = data0.size();

    // get minimum and maximum (for normalize)
    float data0Max = data0[0];
    float data0Min = data0[0];
    float data1Max = data1[0];
    float data1Min = data1[0];
    for (int i=1; i<sizeData; i++) //(i=1)
    {
        if (data0[i] > data0Max) 
        {
            data0Max = data0[i];
        }
        if (data0[i] < data0Min) 
        {
            data0Min = data0[i];
        }
        if (data1[i] > data1Max) 
        {
            data1Max = data1[i];
        }
        if (data1[i] < data1Min) 
        {
            data1Min = data1[i];
        }
    }
    float data0Range = data0Max - data0Min;
    float data1Range = data1Max - data1Min;

    std::vector<float> data0Norm(sizeData, 0);
    std::vector<float> data1Norm(sizeData, 0);
    for (int i=0; i<sizeData; i++)
    {
        data0Norm[i] = (data0[i] - data0Min) / data0Range;
        data1Norm[i] = (data1[i] - data1Min) / data1Range;
    }
    // Assign initial cluster in random way
    std::vector<int> whichClst(sizeData, -1);
    int sizeInitClust = sizeData / numClst;
    for (int k=0; k<numClst; k++) 
    {
        for (int i=k*sizeInitClust; i<(k+1)*sizeInitClust; i++)
        {
            whichClst[i] = k;
        }
    }
    for (int i=numClst*sizeInitClust; i<sizeData; i++)
    {
        whichClst[i] = numClst - 1;
    }
    // to check
    for (int i=0; i<sizeData; i++) 
    {
        if (whichClst[i] == -1)
        {
            printf("Warning: error in initial cluster assigning\n");
        }
    }
    // repeat until cluster group don't move any more
    bool isClstChanged = true;
    while (isClstChanged) 
    {
        isClstChanged = false;
        // get centroid (average) of each cluster
        std::vector<float> ave0EachClst(numClst, 0);
        std::vector<float> ave1EachClst(numClst, 0);
        std::vector<int>   sizeEachClst(numClst, 0);
        for (int i=0; i<sizeData; i++)
        {
            sizeEachClst[whichClst[i]] ++;
            ave0EachClst[whichClst[i]] = ave0EachClst[whichClst[i]] + data0Norm[i];
            ave1EachClst[whichClst[i]] = ave1EachClst[whichClst[i]] + data1Norm[i];
        }
        for (int k=0; k<numClst; k++) 
        {
            ave0EachClst[k] = ave0EachClst[k] / (float)(sizeEachClst[k]);
            ave1EachClst[k] = ave1EachClst[k] / (float)(sizeEachClst[k]);
        }
        // compute WEIGHTED metric distance between a datapoint and a cluster average
        // (clusted in ellips shape, with data0 being the long axis)
        std::vector<float> metric(sizeData, 0);
        for (int i=0; i<sizeData; i++) 
        {
            int k = whichClst[i];
            metric[i] = sqrt(
              (data0Norm[i]-ave0EachClst[k]) * (data0Norm[i]-ave0EachClst[k])
            + (data1Norm[i]-ave1EachClst[k]) * (data1Norm[i]-ave1EachClst[k])
               * weight * weight
            );
        } 
        // change cluster if there is smaller WEIGHTED metric distance
        for (int i=0; i<sizeData; i++) 
        {
            int metricMin    = metric[i];
            for (int k=0; k<numClst; k++) 
            {
                if (k==whichClst[i])  continue;
                int metricTry = sqrt(
                      (data0Norm[i]-ave0EachClst[k]) * (data0Norm[i]-ave0EachClst[k])
                    + (data1Norm[i]-ave1EachClst[k]) * (data1Norm[i]-ave1EachClst[k])
                       * weight * weight
                    );
                if (metricTry < metricMin) 
                {
                    whichClst[i] = k;
                    isClstChanged = true;
                }
            } // end for k
        } // end for i
    } // end while
    return whichClst;
}







// get the count of valid gap and the best gap
std::vector<int> getCountAndBestGap(std::vector<float> distData ,std::vector<int> whichClst, int numClst)
{
    if (distData.size() != whichClst.size())
    {
        printf("Warning: size of whichClusterData doesn't match at countValidGap function\n");
    }    
    int sizeData = distData.size();
 
    // find average of distance values 
    std::vector<float> aveDistEachClst(numClst, 0.0);
    std::vector<int> cntEachClst(numClst, 0);
    for (int i=0; i<sizeData; i++)
    {
        cntEachClst[whichClst[i]] ++;
        int k = whichClst[i];
        aveDistEachClst[k] = aveDistEachClst[k] + distData[i];
    }
    for (int k=0; k<numClst; k++)
    {
        aveDistEachClst[k] = aveDistEachClst[k] / cntEachClst[k];
    }
    // find the largest of average distance
    float aveDistMax = aveDistEachClst[0];
    int bestGap = 0;
    for (int k=1; k<numClst; k++)  // (k=1)
    {
        if (aveDistEachClst[k] > aveDistMax)
        {
            aveDistMax = aveDistEachClst[k];
            bestGap = k;
        }
    }
    // count the valid gap by the the depth
    int cntValidGap = 0;
    for (int k=0; k<numClst; k++) 
    {
        if (aveDistEachClst[k] > 0.5*aveDistMax)
        {
            cntValidGap ++;
        }
    }
    std::vector<int> cntAndBest(2,0);
    cntAndBest[0] = cntValidGap;
    cntAndBest[1] = bestGap;
    return cntAndBest;
}




// get the center of gap
geometry_msgs::Vector3  getCenterOfGap(std::vector<float> coordXData, 
        std::vector<float> coordYData, std::vector<int> whichClst,
        int gapClst)
{
    if (coordXData.size() != whichClst.size())
    {
        printf("Warning: size of whichClusterData doesn't match at getCenterOfGap function\n");
    }
    int sizeData = coordXData.size();
    geometry_msgs::Vector3 centroid;
    centroid.x = 0.0;
    centroid.y = 0.0;
    centroid.z = 0.0;
    int count = 0;
    for (int i=0; i<sizeData; i++)
    {
        if (whichClst[i] == gapClst)
        {
            centroid.x = centroid.x + coordXData[i];
            centroid.y = centroid.y + coordYData[i];
            count ++;
        }
    }
    centroid.x = centroid.x / (double)count;
    centroid.y = centroid.y / (double)count;
    return centroid;
}
    




int main(int argc, char **argv) {
    // Activate the program by the node name
    ros::init(argc, argv, "find_gap");
    ros::NodeHandle n;

    // call subscriber by specifying the topic to receive
    ros::Subscriber sub = n.subscribe("/scan", 1000, getLidarData);

    // Call publisher by specifying the topic to send
    ros::Publisher pub1 = n.advertise<joh_gap_finding::gaps>("lidar_gaps", 1000);
    ros::Publisher pub2 = n.advertise<geometry_msgs::Vector3>("gap_center", 1000);

    // Set frequency of publisher loop
    int freq = 5;                // In [Hz]
    ros::Rate loop_rate(freq);

    // set variables for publisher loop
    int count = 0;               // loop counter (to apply controlled delay)
    int countDelay = 10;         // intentional delay (to prevent starting error)
    int countLimit = 1000;       // upper limit of counting (to prevent overflow)
    bool goodToRun = false;

 /*
    int numCluster = 4;          // num of Cluster
    int sizeImplement = 32;      // num of iteration in Lidar data
    float weightCluster = 10.0;  // weight used for k-Mean clustering 
    int kClusterOutput = 0;
*/

    while (ros::ok()) {
        if (count > countDelay) {
            goodToRun = true;
        }
        if (goodToRun) {
            // Initialize publisher topics
            joh_gap_finding::gaps myLdGap;
            myLdGap.numOfGaps = 2;
            geometry_msgs::Vector3 myGapCtr;
 
            // get subset of data (+ get distance data)
            int sizeLidarDataSm = 64;
            std::vector<int> iterData   = LdToIter(lidarData);
            std::vector<float> distData = shrinkData(lidarData, sizeLidarDataSm);
            std::vector<int> iterDataSm = shrinkData(iterData , sizeLidarDataSm);

            // get angle data
            std::vector<float> anglData = iterToAngle(iterDataSm);
            
            // get xyz data
            std::vector<float> coordXData = distNAngleToCoordX(distData, anglData); 
            std::vector<float> coordYData = distNAngleToCoordY(distData, anglData);

            // Perform K-Mean Clustering
            int numCluster = 3;
            float weight = 3.0;
            std::vector<int> whichClusterData = kMeanCluster(distData, anglData, numCluster, weight);

            // count valid gap and find the best gap
            std::vector<int> countAndBest = getCountAndBestGap(distData , whichClusterData, numCluster);
            int numOfGaps = countAndBest[0];
            int bestGap   = countAndBest[1];

            joh_gap_finding::gaps gapSummary;
            gapSummary.numOfGaps = numOfGaps;

            // get the center of gap
            int gapCluster = 1;
            geometry_msgs::Vector3 centroid = getCenterOfGap(coordXData, coordYData, whichClusterData, gapCluster);
 
            //ROS_INFO_STREAM("num=" << myLdGap.numOfGaps);

            // publish the message to send
            pub1.publish(myLdGap);
            pub2.publish(centroid);

        } // if goodToRun

        ros::spinOnce();
        loop_rate.sleep();
        count = (count+1) % countLimit;
    } // end while
    ros::spin(); 
    return 0;
}
