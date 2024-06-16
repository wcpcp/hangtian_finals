;; Auto-generated. Do not edit!


(when (boundp 'servicebot::commandService)
  (if (not (find-package "SERVICEBOT"))
    (make-package "SERVICEBOT"))
  (shadow 'commandService (find-package "SERVICEBOT")))
(unless (find-package "SERVICEBOT::COMMANDSERVICE")
  (make-package "SERVICEBOT::COMMANDSERVICE"))
(unless (find-package "SERVICEBOT::COMMANDSERVICEREQUEST")
  (make-package "SERVICEBOT::COMMANDSERVICEREQUEST"))
(unless (find-package "SERVICEBOT::COMMANDSERVICERESPONSE")
  (make-package "SERVICEBOT::COMMANDSERVICERESPONSE"))

(in-package "ROS")





(defclass servicebot::commandServiceRequest
  :super ros::object
  :slots (_command _args ))

(defmethod servicebot::commandServiceRequest
  (:init
   (&key
    ((:command __command) "")
    ((:args __args) "")
    )
   (send-super :init)
   (setq _command (string __command))
   (setq _args (string __args))
   self)
  (:command
   (&optional __command)
   (if __command (setq _command __command)) _command)
  (:args
   (&optional __args)
   (if __args (setq _args __args)) _args)
  (:serialization-length
   ()
   (+
    ;; string _command
    4 (length _command)
    ;; string _args
    4 (length _args)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _command
       (write-long (length _command) s) (princ _command s)
     ;; string _args
       (write-long (length _args) s) (princ _args s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _command
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _command (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _args
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _args (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass servicebot::commandServiceResponse
  :super ros::object
  :slots (_resp ))

(defmethod servicebot::commandServiceResponse
  (:init
   (&key
    ((:resp __resp) "")
    )
   (send-super :init)
   (setq _resp (string __resp))
   self)
  (:resp
   (&optional __resp)
   (if __resp (setq _resp __resp)) _resp)
  (:serialization-length
   ()
   (+
    ;; string _resp
    4 (length _resp)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _resp
       (write-long (length _resp) s) (princ _resp s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _resp
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _resp (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass servicebot::commandService
  :super ros::object
  :slots ())

(setf (get servicebot::commandService :md5sum-) "9f111e1e5c42601b7c25567189ab6cbd")
(setf (get servicebot::commandService :datatype-) "servicebot/commandService")
(setf (get servicebot::commandService :request) servicebot::commandServiceRequest)
(setf (get servicebot::commandService :response) servicebot::commandServiceResponse)

(defmethod servicebot::commandServiceRequest
  (:response () (instance servicebot::commandServiceResponse :init)))

(setf (get servicebot::commandServiceRequest :md5sum-) "9f111e1e5c42601b7c25567189ab6cbd")
(setf (get servicebot::commandServiceRequest :datatype-) "servicebot/commandServiceRequest")
(setf (get servicebot::commandServiceRequest :definition-)
      "string command
string args
---
string resp

")

(setf (get servicebot::commandServiceResponse :md5sum-) "9f111e1e5c42601b7c25567189ab6cbd")
(setf (get servicebot::commandServiceResponse :datatype-) "servicebot/commandServiceResponse")
(setf (get servicebot::commandServiceResponse :definition-)
      "string command
string args
---
string resp

")



(provide :servicebot/commandService "9f111e1e5c42601b7c25567189ab6cbd")


