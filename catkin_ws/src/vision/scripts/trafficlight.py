#!/usr/bin/env python
# -*- coding: utf-8 -*-
import rospy
import cv2
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image
from sensor_msgs.msg import CompressedImage
import numpy as np
# from dynamic_reconfigure.server import Server
# import cv2.aruco as aruco
import math
from nav_msgs.msg import Odometry
# #########################################################
# 直接读取摄像头
# from jetcam.csi_camera import CSICamera
# from csi_camera import CSICamera
# from robot_vision.cfg
from geometry_msgs.msg import Twist

lower_red1 = np.array([0, 80, 150])  
upper_red1 = np.array([5, 200, 255])  

lower_red2 = np.array([172, 80, 150])  
upper_red2 = np.array([180, 200, 255])  

# down_yellow = np.array([5, 70, 120]) 
# up_yellow = np.array([30, 220, 250]) 

down_green = np.array([60, 70, 110])  
up_green = np.array([80, 255, 255]) 

def traffic(img):
	# image = cv2.resize(img,(320,240),interpolation=cv2.INTER_AREA)
	image = img
	image_hsv = cv2.cvtColor(image,cv2.COLOR_BGR2HSV)
	kernel = np.ones((5,5),np.uint8)
	hsv_open = cv2.morphologyEx(image_hsv, cv2.MORPH_OPEN, kernel)
	roi = hsv_open[80:400, 80:350]

	mask_green = cv2.inRange(roi, down_green, up_green)
	# mask_yellow = cv2.inRange(roi, down_yellow, up_yellow)
	mask_red1 = cv2.inRange(roi, lower_red1, upper_red1)
	mask_red2 = cv2.inRange(roi, lower_red2, upper_red2)
	mask_red = mask_red1 + mask_red2
	
	# masks = [mask_red, mask_yellow, mask_green]
	# colors = [(0, 0, 255), (0, 255, 255), (0, 255, 0)]  # 对应红黄绿
	masks = [mask_red, mask_green]
	colors = [(0, 0, 255), (0, 255, 0)]  # 对应红绿

	color_flag = 0  # 初始化颜色标志位,0代表都没有检测到，1代表检测到红色，2代表检测到绿色

	for i , (mask, color) in enumerate(zip(masks, colors)):
		M = cv2.moments(mask)
		if M['m00'] > 20000 :
			cx = int(M['m10'] / M['m00'])
			cy = int(M['m01'] / M['m00'])
			cv2.circle(image, (cx+80, cy+80), 5, color, -1)
			color_flag = i + 1
			break 
		# contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
		# for contour in contours:
		# 	area = cv2.contourArea(contour)
		# 	if area > max_area:
		# 		M = cv2.moments(contour)
		# 		cx = int(M['m10'] / M['m00'])
		# 		cy = int(M['m01'] / M['m00'])
		# 		max_area = area
	# if max_area > 20:
	# 	cv2.circle(image, (cx+80, cy+80), 5, color, -1)

	return color_flag

def trafficlight(img):
	color_flag = traffic(img)
	if color_flag == 2:
		# rospy.set_param("/dingtrafficlight",0)#绿色
		print("0")
	elif color_flag == 1:
		print("1")
		# rospy.set_param("/dingtrafficlight",1)#不是绿色
	else:
		print("None")

# def traffic_solve(cv_img):
#     trafficlight_enable = rospy.get_param("/trafficlight_enable")
#     if  trafficlight_enable:
#         # cv_img = cv2.cvtColor(cv_img, cv2.COLOR_RGB2BGR)
#         # img = cv2.resize(cv_img,(640,480))
#         trafficlight(cv_img)

if __name__ == '__main__':

	gst_str =  ('nvarguscamerasrc ! '
                'video/x-raw(memory:NVMM), '
                'width=(int)640, height=(int)480, '
                'format=(string)NV12, framerate=(fraction)20/1 ! '
                'nvvidconv ! '
                'video/x-raw, width=(int){}, height=(int){}, '
                'format=(string)BGRx ! '
                'videoconvert ! appsink').format(640, 480)
    
	cap = cv2.VideoCapture(gst_str, cv2.CAP_GSTREAMER)

	# rospy.init_node('camera_node_trafficlight', anonymous=True) #定义节点
	# rospy.loginfo("Starting trafficlight node")
	# rospy.set_param("/trafficlight_enable",0)#红绿灯使能



	while not rospy.is_shutdown():
		ret , frame = cap.read()  # 捕获图像
		if ret:
			trafficlight(frame)
			# cv2.imshow('roi',roi)
			cv2.imshow('image', frame)
			# print(color_flag)
		if cv2.waitKey(1) & 0xFF == ord('q'):  # 按下 'q' 键退出循环
			break
		cv2.waitKey(1)
	cap.release()
	print("quit successfully!")