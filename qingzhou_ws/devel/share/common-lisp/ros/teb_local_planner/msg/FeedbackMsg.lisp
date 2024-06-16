; Auto-generated. Do not edit!


(cl:in-package teb_local_planner-msg)


;//! \htmlinclude FeedbackMsg.msg.html

(cl:defclass <FeedbackMsg> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (trajectories
    :reader trajectories
    :initarg :trajectories
    :type (cl:vector teb_local_planner-msg:TrajectoryMsg)
   :initform (cl:make-array 0 :element-type 'teb_local_planner-msg:TrajectoryMsg :initial-element (cl:make-instance 'teb_local_planner-msg:TrajectoryMsg)))
   (selected_trajectory_idx
    :reader selected_trajectory_idx
    :initarg :selected_trajectory_idx
    :type cl:fixnum
    :initform 0)
   (obstacles_msg
    :reader obstacles_msg
    :initarg :obstacles_msg
    :type costmap_converter-msg:ObstacleArrayMsg
    :initform (cl:make-instance 'costmap_converter-msg:ObstacleArrayMsg)))
)

(cl:defclass FeedbackMsg (<FeedbackMsg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FeedbackMsg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FeedbackMsg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name teb_local_planner-msg:<FeedbackMsg> is deprecated: use teb_local_planner-msg:FeedbackMsg instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <FeedbackMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teb_local_planner-msg:header-val is deprecated.  Use teb_local_planner-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'trajectories-val :lambda-list '(m))
(cl:defmethod trajectories-val ((m <FeedbackMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teb_local_planner-msg:trajectories-val is deprecated.  Use teb_local_planner-msg:trajectories instead.")
  (trajectories m))

(cl:ensure-generic-function 'selected_trajectory_idx-val :lambda-list '(m))
(cl:defmethod selected_trajectory_idx-val ((m <FeedbackMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teb_local_planner-msg:selected_trajectory_idx-val is deprecated.  Use teb_local_planner-msg:selected_trajectory_idx instead.")
  (selected_trajectory_idx m))

(cl:ensure-generic-function 'obstacles_msg-val :lambda-list '(m))
(cl:defmethod obstacles_msg-val ((m <FeedbackMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teb_local_planner-msg:obstacles_msg-val is deprecated.  Use teb_local_planner-msg:obstacles_msg instead.")
  (obstacles_msg m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FeedbackMsg>) ostream)
  "Serializes a message object of type '<FeedbackMsg>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'trajectories))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'trajectories))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'selected_trajectory_idx)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'selected_trajectory_idx)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'obstacles_msg) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FeedbackMsg>) istream)
  "Deserializes a message object of type '<FeedbackMsg>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'trajectories) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'trajectories)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'teb_local_planner-msg:TrajectoryMsg))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'selected_trajectory_idx)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'selected_trajectory_idx)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'obstacles_msg) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FeedbackMsg>)))
  "Returns string type for a message object of type '<FeedbackMsg>"
  "teb_local_planner/FeedbackMsg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FeedbackMsg)))
  "Returns string type for a message object of type 'FeedbackMsg"
  "teb_local_planner/FeedbackMsg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FeedbackMsg>)))
  "Returns md5sum for a message object of type '<FeedbackMsg>"
  "e8086148d3a39de24ca2cc423f1e94e6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FeedbackMsg)))
  "Returns md5sum for a message object of type 'FeedbackMsg"
  "e8086148d3a39de24ca2cc423f1e94e6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FeedbackMsg>)))
  "Returns full string definition for message of type '<FeedbackMsg>"
  (cl:format cl:nil "# Message that contains intermediate results 
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FeedbackMsg)))
  "Returns full string definition for message of type 'FeedbackMsg"
  (cl:format cl:nil "# Message that contains intermediate results 
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FeedbackMsg>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'trajectories) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     2
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'obstacles_msg))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FeedbackMsg>))
  "Converts a ROS message object to a list"
  (cl:list 'FeedbackMsg
    (cl:cons ':header (header msg))
    (cl:cons ':trajectories (trajectories msg))
    (cl:cons ':selected_trajectory_idx (selected_trajectory_idx msg))
    (cl:cons ':obstacles_msg (obstacles_msg msg))
))