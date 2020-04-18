; Auto-generated. Do not edit!


(cl:in-package joh_gap_finding-msg)


;//! \htmlinclude gap.msg.html

(cl:defclass <gap> (roslisp-msg-protocol:ros-message)
  ((num
    :reader num
    :initarg :num
    :type cl:integer
    :initform 0))
)

(cl:defclass gap (<gap>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gap>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gap)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name joh_gap_finding-msg:<gap> is deprecated: use joh_gap_finding-msg:gap instead.")))

(cl:ensure-generic-function 'num-val :lambda-list '(m))
(cl:defmethod num-val ((m <gap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joh_gap_finding-msg:num-val is deprecated.  Use joh_gap_finding-msg:num instead.")
  (num m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gap>) ostream)
  "Serializes a message object of type '<gap>"
  (cl:let* ((signed (cl:slot-value msg 'num)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gap>) istream)
  "Deserializes a message object of type '<gap>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gap>)))
  "Returns string type for a message object of type '<gap>"
  "joh_gap_finding/gap")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gap)))
  "Returns string type for a message object of type 'gap"
  "joh_gap_finding/gap")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gap>)))
  "Returns md5sum for a message object of type '<gap>"
  "57d3c40ec3ac3754af76a83e6e73127a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gap)))
  "Returns md5sum for a message object of type 'gap"
  "57d3c40ec3ac3754af76a83e6e73127a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gap>)))
  "Returns full string definition for message of type '<gap>"
  (cl:format cl:nil "int64 num~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gap)))
  "Returns full string definition for message of type 'gap"
  (cl:format cl:nil "int64 num~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gap>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gap>))
  "Converts a ROS message object to a list"
  (cl:list 'gap
    (cl:cons ':num (num msg))
))
