; Auto-generated. Do not edit!


(cl:in-package servicebot-srv)


;//! \htmlinclude commandService-request.msg.html

(cl:defclass <commandService-request> (roslisp-msg-protocol:ros-message)
  ((command
    :reader command
    :initarg :command
    :type cl:string
    :initform "")
   (args
    :reader args
    :initarg :args
    :type cl:string
    :initform ""))
)

(cl:defclass commandService-request (<commandService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <commandService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'commandService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name servicebot-srv:<commandService-request> is deprecated: use servicebot-srv:commandService-request instead.")))

(cl:ensure-generic-function 'command-val :lambda-list '(m))
(cl:defmethod command-val ((m <commandService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader servicebot-srv:command-val is deprecated.  Use servicebot-srv:command instead.")
  (command m))

(cl:ensure-generic-function 'args-val :lambda-list '(m))
(cl:defmethod args-val ((m <commandService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader servicebot-srv:args-val is deprecated.  Use servicebot-srv:args instead.")
  (args m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <commandService-request>) ostream)
  "Serializes a message object of type '<commandService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'command))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'command))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'args))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'args))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <commandService-request>) istream)
  "Deserializes a message object of type '<commandService-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'command) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'command) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'args) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'args) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<commandService-request>)))
  "Returns string type for a service object of type '<commandService-request>"
  "servicebot/commandServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'commandService-request)))
  "Returns string type for a service object of type 'commandService-request"
  "servicebot/commandServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<commandService-request>)))
  "Returns md5sum for a message object of type '<commandService-request>"
  "9f111e1e5c42601b7c25567189ab6cbd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'commandService-request)))
  "Returns md5sum for a message object of type 'commandService-request"
  "9f111e1e5c42601b7c25567189ab6cbd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<commandService-request>)))
  "Returns full string definition for message of type '<commandService-request>"
  (cl:format cl:nil "string command~%string args~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'commandService-request)))
  "Returns full string definition for message of type 'commandService-request"
  (cl:format cl:nil "string command~%string args~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <commandService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'command))
     4 (cl:length (cl:slot-value msg 'args))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <commandService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'commandService-request
    (cl:cons ':command (command msg))
    (cl:cons ':args (args msg))
))
;//! \htmlinclude commandService-response.msg.html

(cl:defclass <commandService-response> (roslisp-msg-protocol:ros-message)
  ((resp
    :reader resp
    :initarg :resp
    :type cl:string
    :initform ""))
)

(cl:defclass commandService-response (<commandService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <commandService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'commandService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name servicebot-srv:<commandService-response> is deprecated: use servicebot-srv:commandService-response instead.")))

(cl:ensure-generic-function 'resp-val :lambda-list '(m))
(cl:defmethod resp-val ((m <commandService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader servicebot-srv:resp-val is deprecated.  Use servicebot-srv:resp instead.")
  (resp m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <commandService-response>) ostream)
  "Serializes a message object of type '<commandService-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'resp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'resp))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <commandService-response>) istream)
  "Deserializes a message object of type '<commandService-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'resp) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'resp) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<commandService-response>)))
  "Returns string type for a service object of type '<commandService-response>"
  "servicebot/commandServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'commandService-response)))
  "Returns string type for a service object of type 'commandService-response"
  "servicebot/commandServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<commandService-response>)))
  "Returns md5sum for a message object of type '<commandService-response>"
  "9f111e1e5c42601b7c25567189ab6cbd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'commandService-response)))
  "Returns md5sum for a message object of type 'commandService-response"
  "9f111e1e5c42601b7c25567189ab6cbd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<commandService-response>)))
  "Returns full string definition for message of type '<commandService-response>"
  (cl:format cl:nil "string resp~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'commandService-response)))
  "Returns full string definition for message of type 'commandService-response"
  (cl:format cl:nil "string resp~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <commandService-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'resp))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <commandService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'commandService-response
    (cl:cons ':resp (resp msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'commandService)))
  'commandService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'commandService)))
  'commandService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'commandService)))
  "Returns string type for a service object of type '<commandService>"
  "servicebot/commandService")