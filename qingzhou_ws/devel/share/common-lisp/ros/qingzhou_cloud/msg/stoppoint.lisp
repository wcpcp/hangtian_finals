; Auto-generated. Do not edit!


(cl:in-package qingzhou_cloud-msg)


;//! \htmlinclude stoppoint.msg.html

(cl:defclass <stoppoint> (roslisp-msg-protocol:ros-message)
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
   (updownstatus
    :reader updownstatus
    :initarg :updownstatus
    :type cl:fixnum
    :initform 0)
   (startCommand
    :reader startCommand
    :initarg :startCommand
    :type cl:fixnum
    :initform 0))
)

(cl:defclass stoppoint (<stoppoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <stoppoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'stoppoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name qingzhou_cloud-msg:<stoppoint> is deprecated: use qingzhou_cloud-msg:stoppoint instead.")))

(cl:ensure-generic-function 'X-val :lambda-list '(m))
(cl:defmethod X-val ((m <stoppoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:X-val is deprecated.  Use qingzhou_cloud-msg:X instead.")
  (X m))

(cl:ensure-generic-function 'Y-val :lambda-list '(m))
(cl:defmethod Y-val ((m <stoppoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:Y-val is deprecated.  Use qingzhou_cloud-msg:Y instead.")
  (Y m))

(cl:ensure-generic-function 'updownstatus-val :lambda-list '(m))
(cl:defmethod updownstatus-val ((m <stoppoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:updownstatus-val is deprecated.  Use qingzhou_cloud-msg:updownstatus instead.")
  (updownstatus m))

(cl:ensure-generic-function 'startCommand-val :lambda-list '(m))
(cl:defmethod startCommand-val ((m <stoppoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:startCommand-val is deprecated.  Use qingzhou_cloud-msg:startCommand instead.")
  (startCommand m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <stoppoint>) ostream)
  "Serializes a message object of type '<stoppoint>"
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
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'updownstatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'startCommand)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <stoppoint>) istream)
  "Deserializes a message object of type '<stoppoint>"
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
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'updownstatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'startCommand)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<stoppoint>)))
  "Returns string type for a message object of type '<stoppoint>"
  "qingzhou_cloud/stoppoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'stoppoint)))
  "Returns string type for a message object of type 'stoppoint"
  "qingzhou_cloud/stoppoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<stoppoint>)))
  "Returns md5sum for a message object of type '<stoppoint>"
  "66100b3bfca7763e0a4f3b7884b40cac")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'stoppoint)))
  "Returns md5sum for a message object of type 'stoppoint"
  "66100b3bfca7763e0a4f3b7884b40cac")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<stoppoint>)))
  "Returns full string definition for message of type '<stoppoint>"
  (cl:format cl:nil "float32 X~%float32 Y~%uint8 updownstatus~%uint8 startCommand~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'stoppoint)))
  "Returns full string definition for message of type 'stoppoint"
  (cl:format cl:nil "float32 X~%float32 Y~%uint8 updownstatus~%uint8 startCommand~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <stoppoint>))
  (cl:+ 0
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <stoppoint>))
  "Converts a ROS message object to a list"
  (cl:list 'stoppoint
    (cl:cons ':X (X msg))
    (cl:cons ':Y (Y msg))
    (cl:cons ':updownstatus (updownstatus msg))
    (cl:cons ':startCommand (startCommand msg))
))
