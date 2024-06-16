#!/usr/bin/env python
# -*- coding: utf-8 -*-
import rospy
import cv2
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image
from sensor_msgs.msg import CompressedImage
import numpy as np
from dynamic_reconfigure.server import Server
# import cv2.aruco as aruco
import math
from nav_msgs.msg import Odometry
# #########################################################
# 直接读取摄像头
# from jetcam.csi_camera import CSICamera
# from csi_camera import CSICamera
# from robot_vision.cfg
from geometry_msgs.msg import Twist

lower_red1 = np.array([0, 46, 80])  
upper_red1 = np.array([5, 255, 255])  

lower_red2 = np.array([160, 46, 80])  
upper_red2 = np.array([180, 255, 255])  

# down_yellow = np.array([5, 70, 120]) 
# up_yellow = np.array([30, 220, 250]) 

down_green = np.array([50, 100, 110])  
up_green = np.array([80, 255, 255]) 

color_flags = [0] * 5

def traffic(img):
	global color_flags
	# image = cv2.resize(img,(320,240),interpolation=cv2.INTER_AREA)
	image = img

	b, g, r = cv2.split(image)
	r_avg = cv2.mean(r)[0]
	g_avg = cv2.mean(g)[0]
	b_avg = cv2.mean(b)[0]
	
	# 求各个通道所占增益
	k = (r_avg + g_avg + b_avg) / 3
	kr = k / r_avg
	kg = k / g_avg
	kb = k / b_avg
	
	r = cv2.addWeighted(src1=r, alpha=kr, src2=0, beta=0, gamma=0)
	g = cv2.addWeighted(src1=g, alpha=kg, src2=0, beta=0, gamma=0)
	b = cv2.addWeighted(src1=b, alpha=kb, src2=0, beta=0, gamma=0)
	
	# balance_img = cv2.merge([b, g, r])
	image_hsv = cv2.cvtColor(image,cv2.COLOR_BGR2HSV)
	kernel = np.ones((5,5),np.uint8)
	hsv_open = cv2.morphologyEx(image_hsv, cv2.MORPH_OPEN, kernel)
	roi = cv2.resize(hsv_open,(320, 240))
	roi = roi[0:150, 0:200]

	mask_green = cv2.inRange(roi, down_green, up_green)
	# mask_yellow = cv2.inRange(roi, down_yellow, up_yellow)
	mask_red1 = cv2.inRange(roi, lower_red1, upper_red1)
	mask_red2 = cv2.inRange(roi, lower_red2, upper_red2)
	mask_red = mask_red1 + mask_red2
	# masks = [mask_red, mask_yellow, mask_green]
	# colors = [(0, 0, 255), (0, 255, 255), (0, 255, 0)]  # 对应红黄绿
	masks = [mask_red, mask_green]
	colors = [(0, 0, 255),(0, 255 , 0)]  # 对应红绿

	color_flag = 0  # 初始化颜色标志位,0代表都没有检测到，1代表检测到红色，2代表检测到绿色
	max_area = 0
	selected_mask_index = -1
	for i , (mask, color) in enumerate(zip(masks, colors)):
		_, bin_mask = cv2.threshold(mask, 210, 255, cv2.THRESH_BINARY)

		# M = cv2.moments(mask)
		# if M['m00'] > 5000 :
		# 	print(M['m00'])
		# 	cx = int(M['m10'] / M['m00'])
		# 	cy = int(M['m01'] / M['m00'])
		# 	cv2.circle(image, (cx, cy), 5, color, -1)
		# 	color_flag = i + 1
		contours, _ = cv2.findContours(bin_mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
		for contour in contours:
			area = cv2.contourArea(contour)
			if area > max_area:
				M = cv2.moments(contour)
				cx = int(M['m10'] / M['m00'])
				cy = int(M['m01'] / M['m00'])
				max_area = area
				selected_mask_index = i
			# print(max_area)
			if max_area > 50:
				print(max_area)
				cv2.circle(image, (cx, cy), 5, color, -1)
				color_flag = selected_mask_index + 1
				# color_flags.append(color_flag)  # 将最新的color_flag添加到列表的末尾
				# if len(color_flags) > 5:  # 如果列表的长度超过5，删除最早的元素
				# 	color_flags.pop(0)
		        # # 如果color_flags的所有元素都为1，并且最新的color_flag不为2，则将color_flag设置为1
				# if all(flag == 1 for flag in color_flags) and color_flag != 2:
				# 	color_flag = 1

	return color_flag , mask_red ,mask_green
# def traffic(img):
#     global color_flags
#     print(img.shape) 
#     print(img.dtype) 
#     b, g, r = cv2.split(img)
#     r_avg = cv2.mean(r)[0]
#     g_avg = cv2.mean(g)[0]
#     b_avg = cv2.mean(b)[0]
	
#     # 求各个通道所占增益
#     k = (r_avg + g_avg + b_avg) / 3
#     kr = k / r_avg
#     kg = k / g_avg
#     kb = k / b_avg
	
#     r = cv2.addWeighted(src1=r, alpha=kr, src2=0, beta=0, gamma=0)
#     g = cv2.addWeighted(src1=g, alpha=kg, src2=0, beta=0, gamma=0)
#     b = cv2.addWeighted(src1=b, alpha=kb, src2=0, beta=0, gamma=0)
#     balance_img = cv2.merge([b, g, r])

#     image_hsv = cv2.cvtColor(balance_img,cv2.COLOR_BGR2HSV)
#     kernel = np.ones((5,5),np.uint8)
#     hsv_open = cv2.morphologyEx(image_hsv, cv2.MORPH_OPEN, kernel)
#     roi = cv2.resize(hsv_open,(320, 240))
#     roi = roi[50:200, 0:200]

#     mask_green = cv2.inRange(hsv_open, down_green, up_green)
# 	# mask_yellow = cv2.inRange(roi, down_yellow, up_yellow)
#     mask_red1 = cv2.inRange(hsv_open, lower_red1, upper_red1)
#     mask_red2 = cv2.inRange(hsv_open, lower_red2, upper_red2)
#     mask_red = mask_red1 + mask_red2

#     masks = [mask_red, mask_green]
#     colors = [(0, 0, 255), (0, 255, 0)]  # 对应红绿
#     # M = cv2.moments(mask)
#     # print(M['m00'])
#     color_flag = 0  # 初始化颜色标志位,0代表都没有检测到，1代表检测到红色，2代表检测到绿色
#     max_area = 0
#     selected_mask_index = -1
#     for i , (mask, color) in enumerate(zip(masks, colors)):
#         _, bin_mask = cv2.threshold(mask, 220, 255, cv2.THRESH_BINARY)
#         M = cv2.moments(bin_mask)
#         print(M['m00'])
#         if M['m00'] > max_area:
#             max_area = M['m00']
#             selected_mask_index = i
    
#         if max_area > 6000 and max_area < 12000: 
#             print(max_area)
#             cx = int(M['m10'] / max_area)
#             cy = int(M['m01'] / max_area)
#             cv2.circle(img, (cx, cy), 5, color, -1)
#             color_flag = selected_mask_index + 1

#     return color_flag



# def trafficlight(img):
#     color_flag = traffic(img)
#     print(color_flag)
#     if color_flag == 2 or color_flag == 0:
#         rospy.set_param("/red_traffic",False)#绿色
#         rospy.set_param("/trafficlight_enable",0)
#     elif color_flag == 1:
#         rospy.set_param("/red_traffic",True)#不是绿色

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

	# rospy.init_node('camera_node', anonymous=True) #定义节点
	# rospy.loginfo("Starting trafficlight node")
	# rospy.set_param("/trafficlight_enable",1)#红绿灯使能



	while not rospy.is_shutdown():
		ret , frame = cap.read()  # 捕获图像
		if ret:
			color_flag ,mask_red ,mask_green=traffic(frame)
			# cv2.imshow('roi',roi)
			cv2.imshow('red', mask_red)
			cv2.imshow("green", mask_green)
			print(color_flag)
		if cv2.waitKey(1) & 0xFF == ord('q'):  # 按下 'q' 键退出循环
			break
		# cv2.waitKey(1)
	cap.release()
	print("quit successfully!")
