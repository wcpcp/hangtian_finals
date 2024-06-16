;; Auto-generated. Do not edit!


(when (boundp 'qingzhou_cloud::current_location)
  (if (not (find-package "QINGZHOU_CLOUD"))
    (make-package "QINGZHOU_CLOUD"))
  (shadow 'current_location (find-package "QINGZHOU_CLOUD")))
(unless (find-package "QINGZHOU_CLOUD::CURRENT_LOCATION")
  (make-package "QINGZHOU_CLOUD::CURRENT_LOCATION"))

(in-package "ROS")
;;//! \htmlinclude current_location.msg.html


(defclass qingzhou_cloud::current_location
  :super ros::object
  :slots (_x _y _heading ))

(defmethod qingzhou_cloud::current_location
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:heading __heading) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _heading (float __heading))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:heading
   (&optional __heading)
   (if __heading (setq _heading __heading)) _heading)
  (:serialization-length
   ()
   (+
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _heading
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _heading
       (sys::poke _heading (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _heading
     (setq _heading (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get qingzhou_cloud::current_location :md5sum-) "bc1dd36b5547fef69e6daa06ae2e13ac")
(setf (get qingzhou_cloud::current_location :datatype-) "qingzhou_cloud/current_location")
(setf (get qingzhou_cloud::current_location :definition-)
      "float64 x
float64 y
float64 heading

")



(provide :qingzhou_cloud/current_location "bc1dd36b5547fef69e6daa06ae2e13ac")


