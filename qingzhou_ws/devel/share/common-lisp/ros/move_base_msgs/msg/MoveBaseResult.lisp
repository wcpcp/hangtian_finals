; Auto-generated. Do not edit!


(cl:in-package move_base_msgs-msg)


;//! \htmlinclude MoveBaseResult.msg.html

(cl:defclass <MoveBaseResult> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass MoveBaseResult (<MoveBaseResult>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveBaseResult>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveBaseResult)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name move_base_msgs-msg:<MoveBaseResult> is deprecated: use move_base_msgs-msg:MoveBaseResult instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveBaseResult>) ostream)
  "Serializes a message object of type '<MoveBaseResult>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveBaseResult>) istream)
  "Deserializes a message object of type '<MoveBaseResult>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveBaseResult>)))
  "Returns string type for a message object of type '<MoveBaseResult>"
  "move_base_msgs/MoveBaseResult")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveBaseResult)))
  "Returns string type for a message object of type 'MoveBaseResult"
  "move_base_msgs/MoveBaseResult")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveBaseResult>)))
  "Returns md5sum for a message object of type '<MoveBaseResult>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveBaseResult)))
  "Returns md5sum for a message object of type 'MoveBaseResult"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveBaseResult>)))
  "Returns full string definition for message of type '<MoveBaseResult>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveBaseResult)))
  "Returns full string definition for message of type 'MoveBaseResult"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveBaseResult>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveBaseResult>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveBaseResult
))
