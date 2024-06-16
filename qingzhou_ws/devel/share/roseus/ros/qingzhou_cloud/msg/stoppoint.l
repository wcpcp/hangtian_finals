;; Auto-generated. Do not edit!


(when (boundp 'qingzhou_cloud::stoppoint)
  (if (not (find-package "QINGZHOU_CLOUD"))
    (make-package "QINGZHOU_CLOUD"))
  (shadow 'stoppoint (find-package "QINGZHOU_CLOUD")))
(unless (find-package "QINGZHOU_CLOUD::STOPPOINT")
  (make-package "QINGZHOU_CLOUD::STOPPOINT"))

(in-package "ROS")
;;//! \htmlinclude stoppoint.msg.html


(defclass qingzhou_cloud::stoppoint
  :super ros::object
  :slots (_X _Y _updownstatus _startCommand ))

(defmethod qingzhou_cloud::stoppoint
  (:init
   (&key
    ((:X __X) 0.0)
    ((:Y __Y) 0.0)
    ((:updownstatus __updownstatus) 0)
    ((:startCommand __startCommand) 0)
    )
   (send-super :init)
   (setq _X (float __X))
   (setq _Y (float __Y))
   (setq _updownstatus (round __updownstatus))
   (setq _startCommand (round __startCommand))
   self)
  (:X
   (&optional __X)
   (if __X (setq _X __X)) _X)
  (:Y
   (&optional __Y)
   (if __Y (setq _Y __Y)) _Y)
  (:updownstatus
   (&optional __updownstatus)
   (if __updownstatus (setq _updownstatus __updownstatus)) _updownstatus)
  (:startCommand
   (&optional __startCommand)
   (if __startCommand (setq _startCommand __startCommand)) _startCommand)
  (:serialization-length
   ()
   (+
    ;; float32 _X
    4
    ;; float32 _Y
    4
    ;; uint8 _updownstatus
    1
    ;; uint8 _startCommand
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _X
       (sys::poke _X (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Y
       (sys::poke _Y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _updownstatus
       (write-byte _updownstatus s)
     ;; uint8 _startCommand
       (write-byte _startCommand s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _X
     (setq _X (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Y
     (setq _Y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _updownstatus
     (setq _updownstatus (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _startCommand
     (setq _startCommand (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get qingzhou_cloud::stoppoint :md5sum-) "66100b3bfca7763e0a4f3b7884b40cac")
(setf (get qingzhou_cloud::stoppoint :datatype-) "qingzhou_cloud/stoppoint")
(setf (get qingzhou_cloud::stoppoint :definition-)
      "float32 X
float32 Y
uint8 updownstatus
uint8 startCommand

")



(provide :qingzhou_cloud/stoppoint "66100b3bfca7763e0a4f3b7884b40cac")


