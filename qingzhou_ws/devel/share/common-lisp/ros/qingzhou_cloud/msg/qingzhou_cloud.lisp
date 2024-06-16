; Auto-generated. Do not edit!


(cl:in-package qingzhou_cloud-msg)


;//! \htmlinclude qingzhou_cloud.msg.html

(cl:defclass <qingzhou_cloud> (roslisp-msg-protocol:ros-message)
  ((carstatus
    :reader carstatus
    :initarg :carstatus
    :type cl:fixnum
    :initform 0))
)

(cl:defclass qingzhou_cloud (<qingzhou_cloud>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <qingzhou_cloud>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'qingzhou_cloud)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name qingzhou_cloud-msg:<qingzhou_cloud> is deprecated: use qingzhou_cloud-msg:qingzhou_cloud instead.")))

(cl:ensure-generic-function 'carstatus-val :lambda-list '(m))
(cl:defmethod carstatus-val ((m <qingzhou_cloud>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:carstatus-val is deprecated.  Use qingzhou_cloud-msg:carstatus instead.")
  (carstatus m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <qingzhou_cloud>) ostream)
  "Serializes a message object of type '<qingzhou_cloud>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'carstatus)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <qingzhou_cloud>) istream)
  "Deserializes a message object of type '<qingzhou_cloud>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'carstatus)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<qingzhou_cloud>)))
  "Returns string type for a message object of type '<qingzhou_cloud>"
  "qingzhou_cloud/qingzhou_cloud")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'qingzhou_cloud)))
  "Returns string type for a message object of type 'qingzhou_cloud"
  "qingzhou_cloud/qingzhou_cloud")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<qingzhou_cloud>)))
  "Returns md5sum for a message object of type '<qingzhou_cloud>"
  "86aae73c5c8dd6974b69f6fa57081747")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'qingzhou_cloud)))
  "Returns md5sum for a message object of type 'qingzhou_cloud"
  "86aae73c5c8dd6974b69f6fa57081747")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<qingzhou_cloud>)))
  "Returns full string definition for message of type '<qingzhou_cloud>"
  (cl:format cl:nil "uint8 carstatus~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'qingzhou_cloud)))
  "Returns full string definition for message of type 'qingzhou_cloud"
  (cl:format cl:nil "uint8 carstatus~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <qingzhou_cloud>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <qingzhou_cloud>))
  "Converts a ROS message object to a list"
  (cl:list 'qingzhou_cloud
    (cl:cons ':carstatus (carstatus msg))
))
