;; Auto-generated. Do not edit!


(when (boundp 'move_base_msgs::pathpoint)
  (if (not (find-package "MOVE_BASE_MSGS"))
    (make-package "MOVE_BASE_MSGS"))
  (shadow 'pathpoint (find-package "MOVE_BASE_MSGS")))
(unless (find-package "MOVE_BASE_MSGS::PATHPOINT")
  (make-package "MOVE_BASE_MSGS::PATHPOINT"))

(in-package "ROS")
;;//! \htmlinclude pathpoint.msg.html


(defclass move_base_msgs::pathpoint
  :super ros::object
  :slots (_x _y _value _u _heading ))

(defmethod move_base_msgs::pathpoint
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:value __value) 0)
    ((:u __u) 0)
    ((:heading __heading) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _value (round __value))
   (setq _u (round __u))
   (setq _heading (float __heading))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:u
   (&optional __u)
   (if __u (setq _u __u)) _u)
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
    ;; uint8 _value
    1
    ;; int8 _u
    1
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
     ;; uint8 _value
       (write-byte _value s)
     ;; int8 _u
       (write-byte _u s)
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
   ;; uint8 _value
     (setq _value (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int8 _u
     (setq _u (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _u 127) (setq _u (- _u 256)))
   ;; float64 _heading
     (setq _heading (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get move_base_msgs::pathpoint :md5sum-) "090a11519c8d40a61bee3c07ef8a1b5c")
(setf (get move_base_msgs::pathpoint :datatype-) "move_base_msgs/pathpoint")
(setf (get move_base_msgs::pathpoint :definition-)
      "float64 x
float64 y
uint8 value
int8 u
float64 heading


")



(provide :move_base_msgs/pathpoint "090a11519c8d40a61bee3c07ef8a1b5c")


