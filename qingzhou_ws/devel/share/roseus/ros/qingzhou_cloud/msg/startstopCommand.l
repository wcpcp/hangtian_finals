;; Auto-generated. Do not edit!


(when (boundp 'qingzhou_cloud::startstopCommand)
  (if (not (find-package "QINGZHOU_CLOUD"))
    (make-package "QINGZHOU_CLOUD"))
  (shadow 'startstopCommand (find-package "QINGZHOU_CLOUD")))
(unless (find-package "QINGZHOU_CLOUD::STARTSTOPCOMMAND")
  (make-package "QINGZHOU_CLOUD::STARTSTOPCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude startstopCommand.msg.html


(defclass qingzhou_cloud::startstopCommand
  :super ros::object
  :slots (_startstopcommand ))

(defmethod qingzhou_cloud::startstopCommand
  (:init
   (&key
    ((:startstopcommand __startstopcommand) 0)
    )
   (send-super :init)
   (setq _startstopcommand (round __startstopcommand))
   self)
  (:startstopcommand
   (&optional __startstopcommand)
   (if __startstopcommand (setq _startstopcommand __startstopcommand)) _startstopcommand)
  (:serialization-length
   ()
   (+
    ;; uint8 _startstopcommand
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _startstopcommand
       (write-byte _startstopcommand s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _startstopcommand
     (setq _startstopcommand (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get qingzhou_cloud::startstopCommand :md5sum-) "4aaa2a9c02b5667fbf5717c1c2e38c8e")
(setf (get qingzhou_cloud::startstopCommand :datatype-) "qingzhou_cloud/startstopCommand")
(setf (get qingzhou_cloud::startstopCommand :definition-)
      "uint8 startstopcommand

")



(provide :qingzhou_cloud/startstopCommand "4aaa2a9c02b5667fbf5717c1c2e38c8e")


