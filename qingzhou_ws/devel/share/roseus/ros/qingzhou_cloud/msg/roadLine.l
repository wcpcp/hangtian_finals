;; Auto-generated. Do not edit!


(when (boundp 'qingzhou_cloud::roadLine)
  (if (not (find-package "QINGZHOU_CLOUD"))
    (make-package "QINGZHOU_CLOUD"))
  (shadow 'roadLine (find-package "QINGZHOU_CLOUD")))
(unless (find-package "QINGZHOU_CLOUD::ROADLINE")
  (make-package "QINGZHOU_CLOUD::ROADLINE"))

(in-package "ROS")
;;//! \htmlinclude roadLine.msg.html


(defclass qingzhou_cloud::roadLine
  :super ros::object
  :slots (_lineX _lineY _lineStatus ))

(defmethod qingzhou_cloud::roadLine
  (:init
   (&key
    ((:lineX __lineX) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:lineY __lineY) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:lineStatus __lineStatus) 0)
    )
   (send-super :init)
   (setq _lineX __lineX)
   (setq _lineY __lineY)
   (setq _lineStatus (round __lineStatus))
   self)
  (:lineX
   (&optional __lineX)
   (if __lineX (setq _lineX __lineX)) _lineX)
  (:lineY
   (&optional __lineY)
   (if __lineY (setq _lineY __lineY)) _lineY)
  (:lineStatus
   (&optional __lineStatus)
   (if __lineStatus (setq _lineStatus __lineStatus)) _lineStatus)
  (:serialization-length
   ()
   (+
    ;; float32[] _lineX
    (* 4    (length _lineX)) 4
    ;; float32[] _lineY
    (* 4    (length _lineY)) 4
    ;; uint8 _lineStatus
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[] _lineX
     (write-long (length _lineX) s)
     (dotimes (i (length _lineX))
       (sys::poke (elt _lineX i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _lineY
     (write-long (length _lineY) s)
     (dotimes (i (length _lineY))
       (sys::poke (elt _lineY i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; uint8 _lineStatus
       (write-byte _lineStatus s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[] _lineX
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lineX (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _lineX i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _lineY
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lineY (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _lineY i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; uint8 _lineStatus
     (setq _lineStatus (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get qingzhou_cloud::roadLine :md5sum-) "979b1a9d0eae9e69bcac1c5b8eb2ff08")
(setf (get qingzhou_cloud::roadLine :datatype-) "qingzhou_cloud/roadLine")
(setf (get qingzhou_cloud::roadLine :definition-)
      "float32[] lineX
float32[] lineY
uint8 lineStatus

")



(provide :qingzhou_cloud/roadLine "979b1a9d0eae9e69bcac1c5b8eb2ff08")


