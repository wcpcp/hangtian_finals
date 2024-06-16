;; Auto-generated. Do not edit!


(when (boundp 'move_base_msgs::hglocation)
  (if (not (find-package "MOVE_BASE_MSGS"))
    (make-package "MOVE_BASE_MSGS"))
  (shadow 'hglocation (find-package "MOVE_BASE_MSGS")))
(unless (find-package "MOVE_BASE_MSGS::HGLOCATION")
  (make-package "MOVE_BASE_MSGS::HGLOCATION"))

(in-package "ROS")
;;//! \htmlinclude hglocation.msg.html


(defclass move_base_msgs::hglocation
  :super ros::object
  :slots (_x _y _heading ))

(defmethod move_base_msgs::hglocation
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

(setf (get move_base_msgs::hglocation :md5sum-) "bc1dd36b5547fef69e6daa06ae2e13ac")
(setf (get move_base_msgs::hglocation :datatype-) "move_base_msgs/hglocation")
(setf (get move_base_msgs::hglocation :definition-)
      "float64 x
float64 y
float64 heading

")



(provide :move_base_msgs/hglocation "bc1dd36b5547fef69e6daa06ae2e13ac")

