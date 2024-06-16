;; Auto-generated. Do not edit!


(when (boundp 'qingzhou_cloud::trafficlight)
  (if (not (find-package "QINGZHOU_CLOUD"))
    (make-package "QINGZHOU_CLOUD"))
  (shadow 'trafficlight (find-package "QINGZHOU_CLOUD")))
(unless (find-package "QINGZHOU_CLOUD::TRAFFICLIGHT")
  (make-package "QINGZHOU_CLOUD::TRAFFICLIGHT"))

(in-package "ROS")
;;//! \htmlinclude trafficlight.msg.html


(defclass qingzhou_cloud::trafficlight
  :super ros::object
  :slots (_X _Y _trafficstatus ))

(defmethod qingzhou_cloud::trafficlight
  (:init
   (&key
    ((:X __X) 0.0)
    ((:Y __Y) 0.0)
    ((:trafficstatus __trafficstatus) 0)
    )
   (send-super :init)
   (setq _X (float __X))
   (setq _Y (float __Y))
   (setq _trafficstatus (round __trafficstatus))
   self)
  (:X
   (&optional __X)
   (if __X (setq _X __X)) _X)
  (:Y
   (&optional __Y)
   (if __Y (setq _Y __Y)) _Y)
  (:trafficstatus
   (&optional __trafficstatus)
   (if __trafficstatus (setq _trafficstatus __trafficstatus)) _trafficstatus)
  (:serialization-length
   ()
   (+
    ;; float32 _X
    4
    ;; float32 _Y
    4
    ;; int16 _trafficstatus
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _X
       (sys::poke _X (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Y
       (sys::poke _Y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int16 _trafficstatus
       (write-word _trafficstatus s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _X
     (setq _X (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Y
     (setq _Y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int16 _trafficstatus
     (setq _trafficstatus (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get qingzhou_cloud::trafficlight :md5sum-) "dd7662647ab120aa81de827b8ac271ca")
(setf (get qingzhou_cloud::trafficlight :datatype-) "qingzhou_cloud/trafficlight")
(setf (get qingzhou_cloud::trafficlight :definition-)
      "float32 X
float32 Y
int16 trafficstatus

")



(provide :qingzhou_cloud/trafficlight "dd7662647ab120aa81de827b8ac271ca")


