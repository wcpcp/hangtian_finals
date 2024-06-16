;; Auto-generated. Do not edit!


(when (boundp 'move_base_msgs::hgpathplanner)
  (if (not (find-package "MOVE_BASE_MSGS"))
    (make-package "MOVE_BASE_MSGS"))
  (shadow 'hgpathplanner (find-package "MOVE_BASE_MSGS")))
(unless (find-package "MOVE_BASE_MSGS::HGPATHPLANNER")
  (make-package "MOVE_BASE_MSGS::HGPATHPLANNER"))

(in-package "ROS")
;;//! \htmlinclude hgpathplanner.msg.html


(defclass move_base_msgs::hgpathplanner
  :super ros::object
  :slots (_currentroad _hsize _vsize _cellsize _source _points ))

(defmethod move_base_msgs::hgpathplanner
  (:init
   (&key
    ((:currentroad __currentroad) 0)
    ((:hsize __hsize) 0)
    ((:vsize __vsize) 0)
    ((:cellsize __cellsize) 0.0)
    ((:source __source) 0)
    ((:points __points) (let (r) (dotimes (i 0) (push (instance move_base_msgs::pathpoint :init) r)) r))
    )
   (send-super :init)
   (setq _currentroad (round __currentroad))
   (setq _hsize (round __hsize))
   (setq _vsize (round __vsize))
   (setq _cellsize (float __cellsize))
   (setq _source (round __source))
   (setq _points __points)
   self)
  (:currentroad
   (&optional __currentroad)
   (if __currentroad (setq _currentroad __currentroad)) _currentroad)
  (:hsize
   (&optional __hsize)
   (if __hsize (setq _hsize __hsize)) _hsize)
  (:vsize
   (&optional __vsize)
   (if __vsize (setq _vsize __vsize)) _vsize)
  (:cellsize
   (&optional __cellsize)
   (if __cellsize (setq _cellsize __cellsize)) _cellsize)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:serialization-length
   ()
   (+
    ;; uint8 _currentroad
    1
    ;; uint8 _hsize
    1
    ;; uint8 _vsize
    1
    ;; float32 _cellsize
    4
    ;; uint8 _source
    1
    ;; move_base_msgs/pathpoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _currentroad
       (write-byte _currentroad s)
     ;; uint8 _hsize
       (write-byte _hsize s)
     ;; uint8 _vsize
       (write-byte _vsize s)
     ;; float32 _cellsize
       (sys::poke _cellsize (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _source
       (write-byte _source s)
     ;; move_base_msgs/pathpoint[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _currentroad
     (setq _currentroad (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _hsize
     (setq _hsize (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _vsize
     (setq _vsize (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _cellsize
     (setq _cellsize (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _source
     (setq _source (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; move_base_msgs/pathpoint[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance move_base_msgs::pathpoint :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get move_base_msgs::hgpathplanner :md5sum-) "aac1ecdd9fd50037e6e79455d05d1e5b")
(setf (get move_base_msgs::hgpathplanner :datatype-) "move_base_msgs/hgpathplanner")
(setf (get move_base_msgs::hgpathplanner :definition-)
      "uint8 currentroad
uint8 hsize
uint8 vsize
float32 cellsize
uint8 source
pathpoint[] points

================================================================================
MSG: move_base_msgs/pathpoint
float64 x
float64 y
uint8 value
int8 u
float64 heading


")



(provide :move_base_msgs/hgpathplanner "aac1ecdd9fd50037e6e79455d05d1e5b")


