; Auto-generated. Do not edit!


(cl:in-package joh_gap_finding-msg)


;//! \htmlinclude gaps.msg.html

(cl:defclass <gaps> (roslisp-msg-protocol:ros-message)
  ((numOfGaps
    :reader numOfGaps
    :initarg :numOfGaps
    :type cl:integer
    :initform 0))
)

(cl:defclass gaps (<gaps>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gaps>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gaps)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name joh_gap_finding-msg:<gaps> is deprecated: use joh_gap_finding-msg:gaps instead.")))

(cl:ensure-generic-function 'numOfGaps-val :lambda-list '(m))
(cl:defmethod numOfGaps-val ((m <gaps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joh_gap_finding-msg:numOfGaps-val is deprecated.  Use joh_gap_finding-msg:numOfGaps instead.")
  (numOfGaps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gaps>) ostream)
  "Serializes a message object of type '<gaps>"
  (cl:let* ((signed (cl:slot-value msg 'numOfGaps)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gaps>) istream)
  "Deserializes a message object of type '<gaps>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'numOfGaps) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gaps>)))
  "Returns string type for a message object of type '<gaps>"
  "joh_gap_finding/gaps")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gaps)))
  "Returns string type for a message object of type 'gaps"
  "joh_gap_finding/gaps")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gaps>)))
  "Returns md5sum for a message object of type '<gaps>"
  "80967cdca74685dc952c88f8276188b1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gaps)))
  "Returns md5sum for a message object of type 'gaps"
  "80967cdca74685dc952c88f8276188b1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gaps>)))
  "Returns full string definition for message of type '<gaps>"
  (cl:format cl:nil "int32 numOfGaps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gaps)))
  "Returns full string definition for message of type 'gaps"
  (cl:format cl:nil "int32 numOfGaps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gaps>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gaps>))
  "Converts a ROS message object to a list"
  (cl:list 'gaps
    (cl:cons ':numOfGaps (numOfGaps msg))
))
