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
  :slots (_numOfGaps _width ))

(defmethod joh_gap_finding::gaps
  (:init
   (&key
    ((:numOfGaps __numOfGaps) 0)
    ((:width __width) 0.0)
    )
   (send-super :init)
   (setq _numOfGaps (round __numOfGaps))
   (setq _width (float __width))
   self)
  (:numOfGaps
   (&optional __numOfGaps)
   (if __numOfGaps (setq _numOfGaps __numOfGaps)) _numOfGaps)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:serialization-length
   ()
   (+
    ;; int32 _numOfGaps
    4
    ;; float32 _width
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _numOfGaps
       (write-long _numOfGaps s)
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _numOfGaps
     (setq _numOfGaps (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get joh_gap_finding::gaps :md5sum-) "7907d1a64f5c611284b7ec1a5e86c172")
(setf (get joh_gap_finding::gaps :datatype-) "joh_gap_finding/gaps")
(setf (get joh_gap_finding::gaps :definition-)
      "int32 numOfGaps
float32 width

")



(provide :joh_gap_finding/gaps "7907d1a64f5c611284b7ec1a5e86c172")


