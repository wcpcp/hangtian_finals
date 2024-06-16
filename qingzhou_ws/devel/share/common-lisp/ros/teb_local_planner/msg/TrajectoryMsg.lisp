; Auto-generated. Do not edit!


(cl:in-package teb_local_planner-msg)


;//! \htmlinclude TrajectoryMsg.msg.html

(cl:defclass <TrajectoryMsg> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (trajectory
    :reader trajectory
    :initarg :trajectory
    :type (cl:vector teb_local_planner-msg:TrajectoryPointMsg)
   :initform (cl:make-array 0 :element-type 'teb_local_planner-msg:TrajectoryPointMsg :initial-element (cl:make-instance 'teb_local_planner-msg:TrajectoryPointMsg))))
)

(cl:defclass TrajectoryMsg (<TrajectoryMsg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrajectoryMsg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrajectoryMsg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name teb_local_planner-msg:<TrajectoryMsg> is deprecated: use teb_local_planner-msg:TrajectoryMsg instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TrajectoryMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teb_local_planner-msg:header-val is deprecated.  Use teb_local_planner-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'trajectory-val :lambda-list '(m))
(cl:defmethod trajectory-val ((m <TrajectoryMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teb_local_planner-msg:trajectory-val is deprecated.  Use teb_local_planner-msg:trajectory instead.")
  (trajectory m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrajectoryMsg>) ostream)
  "Serializes a message object of type '<TrajectoryMsg>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'trajectory))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'trajectory))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrajectoryMsg>) istream)
  "Deserializes a message object of type '<TrajectoryMsg>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'trajectory) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'trajectory)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'teb_local_planner-msg:TrajectoryPointMsg))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrajectoryMsg>)))
  "Returns string type for a message object of type '<TrajectoryMsg>"
  "teb_local_planner/TrajectoryMsg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrajectoryMsg)))
  "Returns string type for a message object of type 'TrajectoryMsg"
  "teb_local_planner/TrajectoryMsg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrajectoryMsg>)))
  "Returns md5sum for a message object of type '<TrajectoryMsg>"
  "9dfdc1e62b3eb03a32af2423c5b7a0dd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrajectoryMsg)))
  "Returns md5sum for a message object of type 'TrajectoryMsg"
  "9dfdc1e62b3eb03a32af2423c5b7a0dd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrajectoryMsg>)))
  "Returns full string definition for message of type '<TrajectoryMsg>"
  (cl:format cl:nil "# Message that contains a trajectory for mobile robot navigation
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrajectoryMsg)))
  "Returns full string definition for message of type 'TrajectoryMsg"
  (cl:format cl:nil "# Message that contains a trajectory for mobile robot navigation
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrajectoryMsg>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'trajectory) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrajectoryMsg>))
  "Converts a ROS message object to a list"
  (cl:list 'TrajectoryMsg
    (cl:cons ':header (header msg))
    (cl:cons ':trajectory (trajectory msg))
))