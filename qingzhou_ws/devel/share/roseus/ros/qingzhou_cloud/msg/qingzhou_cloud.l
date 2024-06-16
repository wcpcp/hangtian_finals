;; Auto-generated. Do not edit!


(when (boundp 'qingzhou_cloud::qingzhou_cloud)
  (if (not (find-package "QINGZHOU_CLOUD"))
    (make-package "QINGZHOU_CLOUD"))
  (shadow 'qingzhou_cloud (find-package "QINGZHOU_CLOUD")))
(unless (find-package "QINGZHOU_CLOUD::QINGZHOU_CLOUD")
  (make-package "QINGZHOU_CLOUD::QINGZHOU_CLOUD"))

(in-package "ROS")
;;//! \htmlinclude qingzhou_cloud.msg.html


(defclass qingzhou_cloud::qingzhou_cloud
  :super ros::object
  :slots (_carstatus ))

(defmethod qingzhou_cloud::qingzhou_cloud
  (:init
   (&key
    ((:carstatus __carstatus) 0)
    )
   (send-super :init)
   (setq _carstatus (round __carstatus))
   self)
  (:carstatus
   (&optional __carstatus)
   (if __carstatus (setq _carstatus __carstatus)) _carstatus)
  (:serialization-length
   ()
   (+
    ;; uint8 _carstatus
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _carstatus
       (write-byte _carstatus s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _carstatus
     (setq _carstatus (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get qingzhou_cloud::qingzhou_cloud :md5sum-) "86aae73c5c8dd6974b69f6fa57081747")
(setf (get qingzhou_cloud::qingzhou_cloud :datatype-) "qingzhou_cloud/qingzhou_cloud")
(setf (get qingzhou_cloud::qingzhou_cloud :definition-)
      "uint8 carstatus

")



(provide :qingzhou_cloud/qingzhou_cloud "86aae73c5c8dd6974b69f6fa57081747")


