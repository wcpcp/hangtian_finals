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
import os
# from threading import Thread

# def find_word(image, templates):
#     # 预处理
#     gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)  # 灰度处理
#     gray = cv2.GaussianBlur(gray, (5, 5), 0)  # 高斯滤波
#     _, binary = cv2.threshold(gray, 135, 255, cv2.THRESH_BINARY_INV)  # 二值化
#     kernel = np.ones((7,7),np.uint8)
#     dilated = cv2.dilate(binary, kernel, iterations = 1)
#     contours, _ = cv2.findContours(dilated, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)  # 轮廓查找
    
#     max_val = 0
#     max_ids = -1
#     found_text_image = False  # 初始化标记

#     for i in range(len(contours)):
#         x, y, w, h = cv2.boundingRect(contours[i])  # 获取文字区域
#         # cv2.rectangle(image, (x, y), (x+w, y+h), (0, 0, 255), 2)
#         if cv2.contourArea(contours[i]) < 1500 or cv2.contourArea(contours[i]) > 7000:
#             continue
#         if w / h > 3 or w / h < 1.2:
#             continue
#         text_image = gray[y:y+h, x:x+w]  # 截取文字区域
#         found_text_image = True  # 设置标记为True
#         cv2.rectangle(image, (x, y), (x+w, y+h), (0, 0, 255), 2)  # 绘制矩形
        
#         max_vals = []
#         for template in templates:
#             # 将模板调整为和文字区域一样的大小
#             resized_template = cv2.resize(template, (w, h))

#             # 模板匹配
#             res = cv2.matchTemplate(text_image, resized_template, cv2.TM_CCOEFF_NORMED)
#             _, max_val, _, _ = cv2.minMaxLoc(res)
#             max_vals.append(max_val)

#         max_val = max(max_vals)
#         print(max_val)
#         max_idx = max_vals.index(max_val)

#     return max_val , max_idx , found_text_image
def find_word(image, templates):
    # 预处理
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)  # 灰度处理
    gray = cv2.GaussianBlur(gray, (5, 5), 0)  # 高斯滤波
    _, binary = cv2.threshold(gray, 135, 255, cv2.THRESH_BINARY_INV)  # 二值化
    kernel = np.ones((7,7),np.uint8)
    dilated = cv2.dilate(binary, kernel, iterations = 1)
    contours, _ = cv2.findContours(dilated, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)  # 轮廓查找
    
    max_val = 0
    max_ids = -1
    found_text_image = False  # 初始化标记

    for i in range(len(contours)):
        x, y, w, h = cv2.boundingRect(contours[i])  # 获取文字区域
        # cv2.rectangle(image, (x, y), (x+w, y+h), (0, 0, 255), 2)
        if cv2.contourArea(contours[i]) < 1500 or cv2.contourArea(contours[i]) > 7000:
            continue
        if w / h > 3 or w / h < 1.2:
            continue
        text_image = gray[y:y+h, x:x+w]  # 截取文字区域
        found_text_image = True  # 设置标记为True
        cv2.rectangle(image, (x, y), (x+w, y+h), (0, 0, 255), 2)  # 绘制矩形
        
        max_vals = []
        for template in templates:
            # 将模板调整为和文字区域一样的大小
            resized_template = cv2.resize(template, (w, h))

            # 模板匹配
            res = cv2.matchTemplate(text_image, resized_template, cv2.TM_CCOEFF_NORMED)
            _, current_max_val, _, _ = cv2.minMaxLoc(res)
            
            if current_max_val > max_val: 
                max_val = current_max_val
                max_idx = templates.index(template)

    return max_val , max_idx , found_text_image

def is_find_word(image , temp):
    max_val , max_idx , found_text_image= find_word(image , temp)
    if max_val > 0.35:
        if max_idx + 1 in [1, 3]:
            rospy.set_param("/word_recognition", True)    #停车位A
        else:
            rospy.set_param("/word_recognition", False)    #停车位B
    else:
        rospy.set_param("/word_recognition", False) 

    if not found_text_image: 
        rospy.set_param("/word_recognition", False)

def word_solve(img , temp):
    word_enable = rospy.get_param("/word_enable")
    if  word_enable:
        # cv_img = cv2.cvtColor(cv_img, cv2.COLOR_RGB2BGR)
        # img = cv2.resize(cv_img,(640,480))
        is_find_word(img , temp)


if __name__ == "__main__":

    gst_str =  ('nvarguscamerasrc ! '
                'video/x-raw(memory:NVMM), '
                'width=(int)640, height=(int)480, '
                'format=(string)NV12, framerate=(fraction)20/1 ! '
                'nvvidconv ! '
                'video/x-raw, width=(int){}, height=(int){}, '
                'format=(string)BGRx ! '
                'videoconvert ! appsink').format(640, 480)

    cap = cv2.VideoCapture(gst_str, cv2.CAP_GSTREAMER)

    rospy.init_node('camera_node_word', anonymous=True)
    rospy.loginfo("Starting word recognize node")
    rospy.set_param("/word_enable",0)


    templates = []
    for i in range(4):
        template_path = os.path.join('/home/qingzhou/qingzhou_ws/src/vision/data', "word{}.png".format(i))
        template = cv2.imread(template_path, 0)
        if template is None:
            print('Failed to load word{i}.png')
        else:
            templates.append(template)

    while not rospy.is_shutdown():
        ret , frame = cap.read() 
        word_solve(frame, templates)
    
    
    cap.release()

    print("quit successfully!")