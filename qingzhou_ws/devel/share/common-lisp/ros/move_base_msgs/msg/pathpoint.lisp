; Auto-generated. Do not edit!


(cl:in-package move_base_msgs-msg)


;//! \htmlinclude pathpoint.msg.html

(cl:defclass <pathpoint> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (value
    :reader value
    :initarg :value
    :type cl:fixnum
    :initform 0)
   (u
    :reader u
    :initarg :u
    :type cl:fixnum
    :initform 0)
   (heading
    :reader heading
    :initarg :heading
    :type cl:float
    :initform 0.0))
)

(cl:defclass pathpoint (<pathpoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pathpoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pathpoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name move_base_msgs-msg:<pathpoint> is deprecated: use move_base_msgs-msg:pathpoint instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <pathpoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:x-val is deprecated.  Use move_base_msgs-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <pathpoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:y-val is deprecated.  Use move_base_msgs-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <pathpoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:value-val is deprecated.  Use move_base_msgs-msg:value instead.")
  (value m))

(cl:ensure-generic-function 'u-val :lambda-list '(m))
(cl:defmethod u-val ((m <pathpoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:u-val is deprecated.  Use move_base_msgs-msg:u instead.")
  (u m))

(cl:ensure-generic-function 'heading-val :lambda-list '(m))
(cl:defmethod heading-val ((m <pathpoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:heading-val is deprecated.  Use move_base_msgs-msg:heading instead.")
  (heading m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pathpoint>) ostream)
  "Serializes a message object of type '<pathpoint>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'u)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'heading))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pathpoint>) istream)
  "Deserializes a message object of type '<pathpoint>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'u) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'heading) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pathpoint>)))
  "Returns string type for a message object of type '<pathpoint>"
  "move_base_msgs/pathpoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pathpoint)))
  "Returns string type for a message object of type 'pathpoint"
  "move_base_msgs/pathpoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pathpoint>)))
  "Returns md5sum for a message object of type '<pathpoint>"
  "090a11519c8d40a61bee3c07ef8a1b5c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pathpoint)))
  "Returns md5sum for a message object of type 'pathpoint"
  "090a11519c8d40a61bee3c07ef8a1b5c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pathpoint>)))
  "Returns full string definition for message of type '<pathpoint>"
  (cl:format cl:nil "float64 x~%float64 y~%uint8 value~%int8 u~%float64 heading~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pathpoint)))
  "Returns full string definition for message of type 'pathpoint"
  (cl:format cl:nil "float64 x~%float64 y~%uint8 value~%int8 u~%float64 heading~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pathpoint>))
  (cl:+ 0
     8
     8
     1
     1
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pathpoint>))
  "Converts a ROS message object to a list"
  (cl:list 'pathpoint
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':value (value msg))
    (cl:cons ':u (u msg))
    (cl:cons ':heading (heading msg))
))
