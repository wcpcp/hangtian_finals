; Auto-generated. Do not edit!


(cl:in-package qingzhou_cloud-msg)


;//! \htmlinclude roadLine.msg.html

(cl:defclass <roadLine> (roslisp-msg-protocol:ros-message)
  ((lineX
    :reader lineX
    :initarg :lineX
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (lineY
    :reader lineY
    :initarg :lineY
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (lineStatus
    :reader lineStatus
    :initarg :lineStatus
    :type cl:fixnum
    :initform 0))
)

(cl:defclass roadLine (<roadLine>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <roadLine>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'roadLine)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name qingzhou_cloud-msg:<roadLine> is deprecated: use qingzhou_cloud-msg:roadLine instead.")))

(cl:ensure-generic-function 'lineX-val :lambda-list '(m))
(cl:defmethod lineX-val ((m <roadLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:lineX-val is deprecated.  Use qingzhou_cloud-msg:lineX instead.")
  (lineX m))

(cl:ensure-generic-function 'lineY-val :lambda-list '(m))
(cl:defmethod lineY-val ((m <roadLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:lineY-val is deprecated.  Use qingzhou_cloud-msg:lineY instead.")
  (lineY m))

(cl:ensure-generic-function 'lineStatus-val :lambda-list '(m))
(cl:defmethod lineStatus-val ((m <roadLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader qingzhou_cloud-msg:lineStatus-val is deprecated.  Use qingzhou_cloud-msg:lineStatus instead.")
  (lineStatus m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <roadLine>) ostream)
  "Serializes a message object of type '<roadLine>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lineX))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'lineX))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lineY))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'lineY))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'lineStatus)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <roadLine>) istream)
  "Deserializes a message object of type '<roadLine>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lineX) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lineX)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lineY) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lineY)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'lineStatus)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<roadLine>)))
  "Returns string type for a message object of type '<roadLine>"
  "qingzhou_cloud/roadLine")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'roadLine)))
  "Returns string type for a message object of type 'roadLine"
  "qingzhou_cloud/roadLine")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<roadLine>)))
  "Returns md5sum for a message object of type '<roadLine>"
  "979b1a9d0eae9e69bcac1c5b8eb2ff08")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'roadLine)))
  "Returns md5sum for a message object of type 'roadLine"
  "979b1a9d0eae9e69bcac1c5b8eb2ff08")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<roadLine>)))
  "Returns full string definition for message of type '<roadLine>"
  (cl:format cl:nil "float32[] lineX~%float32[] lineY~%uint8 lineStatus~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'roadLine)))
  "Returns full string definition for message of type 'roadLine"
  (cl:format cl:nil "float32[] lineX~%float32[] lineY~%uint8 lineStatus~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <roadLine>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lineX) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lineY) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <roadLine>))
  "Converts a ROS message object to a list"
  (cl:list 'roadLine
    (cl:cons ':lineX (lineX msg))
    (cl:cons ':lineY (lineY msg))
    (cl:cons ':lineStatus (lineStatus msg))
))
