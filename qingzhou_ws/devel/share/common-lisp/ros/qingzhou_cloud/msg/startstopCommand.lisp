; Auto-generated. Do not edit!


(cl:in-package qingzhou_cloud-msg)


;//! \htmlinclude startstopCommand.msg.html

(cl:defclass <startstopCommand> (roslisp-msg-protocol:ros-message)
  ((startstopcommand
    :reader startstopcommand
    :initarg :startstopcommand
    :type cl:fixnum
    :initform 0))
)

(cl:defclass startstopCommand (<startstopCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <startstopCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'startstopCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name qingzhou_cloud-msg:<startstopCommand> is deprecated: use qingzhou_cloud-msg:startstopCommand instead.")))

(cl:ensure-generic-function 'startstopcommand-val :lambda-list '(m))
(cl:defmethod startstopcommand-val ((m <startstopCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:startstopcommand-val is deprecated.  Use qingzhou_cloud-msg:startstopcommand instead.")
  (startstopcommand m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <startstopCommand>) ostream)
  "Serializes a message object of type '<startstopCommand>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'startstopcommand)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <startstopCommand>) istream)
  "Deserializes a message object of type '<startstopCommand>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'startstopcommand)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<startstopCommand>)))
  "Returns string type for a message object of type '<startstopCommand>"
  "qingzhou_cloud/startstopCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'startstopCommand)))
  "Returns string type for a message object of type 'startstopCommand"
  "qingzhou_cloud/startstopCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<startstopCommand>)))
  "Returns md5sum for a message object of type '<startstopCommand>"
  "4aaa2a9c02b5667fbf5717c1c2e38c8e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'startstopCommand)))
  "Returns md5sum for a message object of type 'startstopCommand"
  "4aaa2a9c02b5667fbf5717c1c2e38c8e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<startstopCommand>)))
  "Returns full string definition for message of type '<startstopCommand>"
  (cl:format cl:nil "uint8 startstopcommand~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'startstopCommand)))
  "Returns full string definition for message of type 'startstopCommand"
  (cl:format cl:nil "uint8 startstopcommand~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <startstopCommand>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <startstopCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'startstopCommand
    (cl:cons ':startstopcommand (startstopcommand msg))
))
