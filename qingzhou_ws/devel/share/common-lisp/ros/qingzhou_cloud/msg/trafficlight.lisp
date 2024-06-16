; Auto-generated. Do not edit!


(cl:in-package qingzhou_cloud-msg)


;//! \htmlinclude trafficlight.msg.html

(cl:defclass <trafficlight> (roslisp-msg-protocol:ros-message)
  ((X
    :reader X
    :initarg :X
    :type cl:float
    :initform 0.0)
   (Y
    :reader Y
    :initarg :Y
    :type cl:float
    :initform 0.0)
   (trafficstatus
    :reader trafficstatus
    :initarg :trafficstatus
    :type cl:fixnum
    :initform 0))
)

(cl:defclass trafficlight (<trafficlight>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <trafficlight>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'trafficlight)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name qingzhou_cloud-msg:<trafficlight> is deprecated: use qingzhou_cloud-msg:trafficlight instead.")))

(cl:ensure-generic-function 'X-val :lambda-list '(m))
(cl:defmethod X-val ((m <trafficlight>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:X-val is deprecated.  Use qingzhou_cloud-msg:X instead.")
  (X m))

(cl:ensure-generic-function 'Y-val :lambda-list '(m))
(cl:defmethod Y-val ((m <trafficlight>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:Y-val is deprecated.  Use qingzhou_cloud-msg:Y instead.")
  (Y m))

(cl:ensure-generic-function 'trafficstatus-val :lambda-list '(m))
(cl:defmethod trafficstatus-val ((m <trafficlight>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:trafficstatus-val is deprecated.  Use qingzhou_cloud-msg:trafficstatus instead.")
  (trafficstatus m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <trafficlight>) ostream)
  "Serializes a message object of type '<trafficlight>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'X))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'trafficstatus)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <trafficlight>) istream)
  "Deserializes a message object of type '<trafficlight>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'X) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'trafficstatus) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<trafficlight>)))
  "Returns string type for a message object of type '<trafficlight>"
  "qingzhou_cloud/trafficlight")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'trafficlight)))
  "Returns string type for a message object of type 'trafficlight"
  "qingzhou_cloud/trafficlight")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<trafficlight>)))
  "Returns md5sum for a message object of type '<trafficlight>"
  "dd7662647ab120aa81de827b8ac271ca")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'trafficlight)))
  "Returns md5sum for a message object of type 'trafficlight"
  "dd7662647ab120aa81de827b8ac271ca")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<trafficlight>)))
  "Returns full string definition for message of type '<trafficlight>"
  (cl:format cl:nil "float32 X~%float32 Y~%int16 trafficstatus~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'trafficlight)))
  "Returns full string definition for message of type 'trafficlight"
  (cl:format cl:nil "float32 X~%float32 Y~%int16 trafficstatus~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <trafficlight>))
  (cl:+ 0
     4
     4
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <trafficlight>))
  "Converts a ROS message object to a list"
  (cl:list 'trafficlight
    (cl:cons ':X (X msg))
    (cl:cons ':Y (Y msg))
    (cl:cons ':trafficstatus (trafficstatus msg))
))
