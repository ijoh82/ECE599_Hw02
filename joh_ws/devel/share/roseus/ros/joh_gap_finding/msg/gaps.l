;; Auto-generated. Do not edit!


(when (boundp 'joh_gap_finding::gaps)
  (if (not (find-package "JOH_GAP_FINDING"))
    (make-package "JOH_GAP_FINDING"))
  (shadow 'gaps (find-package "JOH_GAP_FINDING")))
(unless (find-package "JOH_GAP_FINDING::GAPS")
  (make-package "JOH_GAP_FINDING::GAPS"))

(in-package "ROS")
;;//! \htmlinclude gaps.msg.html


(defclass joh_gap_finding::gaps
  :super ros::object
  :slots (_numOfGaps ))

(defmethod joh_gap_finding::gaps
  (:init
   (&key
    ((:numOfGaps __numOfGaps) 0)
    )
   (send-super :init)
   (setq _numOfGaps (round __numOfGaps))
   self)
  (:numOfGaps
   (&optional __numOfGaps)
   (if __numOfGaps (setq _numOfGaps __numOfGaps)) _numOfGaps)
  (:serialization-length
   ()
   (+
    ;; int32 _numOfGaps
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _numOfGaps
       (write-long _numOfGaps s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _numOfGaps
     (setq _numOfGaps (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get joh_gap_finding::gaps :md5sum-) "80967cdca74685dc952c88f8276188b1")
(setf (get joh_gap_finding::gaps :datatype-) "joh_gap_finding/gaps")
(setf (get joh_gap_finding::gaps :definition-)
      "int32 numOfGaps

")



(provide :joh_gap_finding/gaps "80967cdca74685dc952c88f8276188b1")


