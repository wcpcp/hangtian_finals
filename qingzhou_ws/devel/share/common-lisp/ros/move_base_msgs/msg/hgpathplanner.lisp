; Auto-generated. Do not edit!


(cl:in-package move_base_msgs-msg)


;//! \htmlinclude hgpathplanner.msg.html

(cl:defclass <hgpathplanner> (roslisp-msg-protocol:ros-message)
  ((currentroad
    :reader currentroad
    :initarg :currentroad
    :type cl:fixnum
    :initform 0)
   (hsize
    :reader hsize
    :initarg :hsize
    :type cl:fixnum
    :initform 0)
   (vsize
    :reader vsize
    :initarg :vsize
    :type cl:fixnum
    :initform 0)
   (cellsize
    :reader cellsize
    :initarg :cellsize
    :type cl:float
    :initform 0.0)
   (source
    :reader source
    :initarg :source
    :type cl:fixnum
    :initform 0)
   (points
    :reader points
    :initarg :points
    :type (cl:vector move_base_msgs-msg:pathpoint)
   :initform (cl:make-array 0 :element-type 'move_base_msgs-msg:pathpoint :initial-element (cl:make-instance 'move_base_msgs-msg:pathpoint))))
)

(cl:defclass hgpathplanner (<hgpathplanner>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <hgpathplanner>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'hgpathplanner)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name move_base_msgs-msg:<hgpathplanner> is deprecated: use move_base_msgs-msg:hgpathplanner instead.")))

(cl:ensure-generic-function 'currentroad-val :lambda-list '(m))
(cl:defmethod currentroad-val ((m <hgpathplanner>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:currentroad-val is deprecated.  Use move_base_msgs-msg:currentroad instead.")
  (currentroad m))

(cl:ensure-generic-function 'hsize-val :lambda-list '(m))
(cl:defmethod hsize-val ((m <hgpathplanner>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:hsize-val is deprecated.  Use move_base_msgs-msg:hsize instead.")
  (hsize m))

(cl:ensure-generic-function 'vsize-val :lambda-list '(m))
(cl:defmethod vsize-val ((m <hgpathplanner>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:vsize-val is deprecated.  Use move_base_msgs-msg:vsize instead.")
  (vsize m))

(cl:ensure-generic-function 'cellsize-val :lambda-list '(m))
(cl:defmethod cellsize-val ((m <hgpathplanner>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:cellsize-val is deprecated.  Use move_base_msgs-msg:cellsize instead.")
  (cellsize m))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <hgpathplanner>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:source-val is deprecated.  Use move_base_msgs-msg:source instead.")
  (source m))

(cl:ensure-generic-function 'points-val :lambda-list '(m))
(cl:defmethod points-val ((m <hgpathplanner>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_base_msgs-msg:points-val is deprecated.  Use move_base_msgs-msg:points instead.")
  (points m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <hgpathplanner>) ostream)
  "Serializes a message object of type '<hgpathplanner>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'currentroad)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'hsize)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'vsize)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'cellsize))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <hgpathplanner>) istream)
  "Deserializes a message object of type '<hgpathplanner>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'currentroad)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'hsize)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'vsize)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'cellsize) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'move_base_msgs-msg:pathpoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<hgpathplanner>)))
  "Returns string type for a message object of type '<hgpathplanner>"
  "move_base_msgs/hgpathplanner")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'hgpathplanner)))
  "Returns string type for a message object of type 'hgpathplanner"
  "move_base_msgs/hgpathplanner")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<hgpathplanner>)))
  "Returns md5sum for a message object of type '<hgpathplanner>"
  "aac1ecdd9fd50037e6e79455d05d1e5b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'hgpathplanner)))
  "Returns md5sum for a message object of type 'hgpathplanner"
  "aac1ecdd9fd50037e6e79455d05d1e5b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<hgpathplanner>)))
  "Returns full string definition for message of type '<hgpathplanner>"
  (cl:format cl:nil "uint8 currentroad~%uint8 hsize~%uint8 vsize~%float32 cellsize~%uint8 source~%pathpoint[] points~%~%================================================================================~%MSG: move_base_msgs/pathpoint~%float64 x~%float64 y~%uint8 value~%int8 u~%float64 heading~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'hgpathplanner)))
  "Returns full string definition for message of type 'hgpathplanner"
  (cl:format cl:nil "uint8 currentroad~%uint8 hsize~%uint8 vsize~%float32 cellsize~%uint8 source~%pathpoint[] points~%~%================================================================================~%MSG: move_base_msgs/pathpoint~%float64 x~%float64 y~%uint8 value~%int8 u~%float64 heading~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <hgpathplanner>))
  (cl:+ 0
     1
     1
     1
     4
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <hgpathplanner>))
  "Converts a ROS message object to a list"
  (cl:list 'hgpathplanner
    (cl:cons ':currentroad (currentroad msg))
    (cl:cons ':hsize (hsize msg))
    (cl:cons ':vsize (vsize msg))
    (cl:cons ':cellsize (cellsize msg))
    (cl:cons ':source (source msg))
    (cl:cons ':points (points msg))
))
