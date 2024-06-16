#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy
import cv2
# import sys
# sys.path.append("/home/qingzhou/.local/lib/python3.8/site-packages")
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
from geometry_msgs.msg import PoseWithCovarianceStamped,PoseStamped
# import ddddocr
from model import OcrHandle
# from ocr_handle import OcrHandle
import socket 
from threading import Thread


serverIp = '10.66.193.108'
tcpPort = 8050

def socket_init():
	sock = socket.socket()      # 创建 socket 对象
	host = socket.gethostname() # 获取本地主机名

	sock.connect((serverIp, tcpPort))
	print ("connect ok")

	return sock

# found_A = False
lower_red1 = np.array([0, 80, 130])  
upper_red1 = np.array([5, 255, 255])  

lower_red2 = np.array([160, 80, 130])  
upper_red2 = np.array([180, 255, 255])  

down_green = np.array([60, 70, 100])  
up_green = np.array([80, 255, 255]) 

lower_green = np.array([35, 43, 46])
upper_green = np.array([80, 255, 255])

color_flags = [0] * 5

def traffic(img):
    global color_flags
    print(img.shape) 
    print(img.dtype) 
    b, g, r = cv2.split(img)
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
    balance_img = cv2.merge([b, g, r])

    image_hsv = cv2.cvtColor(balance_img,cv2.COLOR_BGR2HSV)
    kernel = np.ones((5,5),np.uint8)
    hsv_open = cv2.morphologyEx(image_hsv, cv2.MORPH_OPEN, kernel)
    roi = cv2.resize(hsv_open,(320, 240))
    roi = roi[50:200, 0:200]

    mask_green = cv2.inRange(hsv_open, down_green, up_green)
	# mask_yellow = cv2.inRange(roi, down_yellow, up_yellow)
    mask_red1 = cv2.inRange(hsv_open, lower_red1, upper_red1)
    mask_red2 = cv2.inRange(hsv_open, lower_red2, upper_red2)
    mask_red = mask_red1 + mask_red2

    masks = [mask_red, mask_green]
    colors = [(0, 0, 255), (0, 255, 0)]  # 对应红绿
    # M = cv2.moments(mask)
    # print(M['m00'])
    color_flag = 0  # 初始化颜色标志位,0代表都没有检测到，1代表检测到红色，2代表检测到绿色
    max_area = 0
    selected_mask_index = -1
    for i , (mask, color) in enumerate(zip(masks, colors)):
        _, bin_mask = cv2.threshold(mask, 220, 255, cv2.THRESH_BINARY)
        M = cv2.moments(bin_mask)
        print(M['m00'])
        if M['m00'] > max_area:
            max_area = M['m00']
            selected_mask_index = i
    
        if max_area > 6000:
            print(max_area)
            cx = int(M['m10'] / max_area)
            cy = int(M['m01'] / max_area)
            cv2.circle(img, (cx, cy), 5, color, -1)
            color_flag = selected_mask_index + 1


    return color_flag

def trafficlight(img):
    color_flag = traffic(img)
    print(color_flag)
    if color_flag == 2 or color_flag == 0:
        rospy.set_param("/red_traffic",False)#绿色
        rospy.set_param("/trafficlight_enable",0)
    elif color_flag == 1:
        rospy.set_param("/red_traffic",True)#不是绿色

def traffic_solve(cv_img):
    task=rospy.get_param("/task")
    if task == 1:
        trafficlight_enable = rospy.get_param("/trafficlight_enable")
        if  trafficlight_enable:
            # cv_img = cv2.cvtColor(cv_img, cv2.COLOR_RGB2BGR)
            # img = cv2.resize(cv_img,(640,480))
            trafficlight(cv_img)

def PoseCallBack(msg):
    x = msg.pose.pose.position.x
    y = msg.pose.pose.position.y

    if  y <= -4.9 :
        rospy.set_param("/trafficlight_enable", 1)
    else:
        rospy.set_param("/trafficlight_enable", 0)

class line_follow:
    def __init__(self):    
        #define topic publisher and subscriber
        self.bridge = CvBridge()
        # self.image_sub = rospy.Subscriber("/image_raw/compressed", CompressedImage, self.callback)
        self.odom = rospy.Subscriber("/odom_data", Odometry, self.odom_callback)
        self.bgr_pub = rospy.Publisher("/img_bgr", Image, queue_size=1)
        self.result_pub = rospy.Publisher("/result_image", Image, queue_size=1)
        self.pub_cmd = rospy.Publisher("/cmd_vel_line", Twist, queue_size=1)

        self.center_point = 0
        self.mylinespeed = 0
        self.view_flag = 0
        self.angle = 0
        self.last_center_point = 0

    def odom_callback(self,data):
        self.mylinespeed= data.twist.twist.linear.x
        # print self.mylinespeed

    def cal(self, x, y):
        for i in range(len(y) - 1):
            for j in range(len(y) - i - 1):
                if y[j] < y[j + 1]:
                    temp = y[j]
                    y[j] = y[j + 1]
                    y[j + 1] = temp
                    temp = x[j]
                    x[j] = x[j + 1]
                    x[j + 1] = temp
        if len(x) == 0:
            center = 0
        elif len(x) == 1:
            center = x[0]
        elif len(x) == 2:
            center = 0.8 * x[0] + 0.2 * x[1]
        elif len(x) == 3:
            center = 0.7 * x[0] + 0.2 * x[1] + 0.1 * x[2]
        else:
            center = 0.6 * x[0] + 0.2 * x[1] + 0.15 * x[2] + 0.05 * x[3]

        return center


    
    def find_line(self, img_bgr):
        x = []
        y = []

        img_below = img_bgr[280:480, :]
        img_hsv = cv2.cvtColor(img_below, cv2.COLOR_BGR2HSV)
        green_mask = cv2.inRange(img_hsv, lower_green, upper_green)
        kernel = np.ones((5,5),np.uint8)
        green_mask_blur = cv2.dilate(green_mask, kernel, iterations = 1)
        green_mask_blur = cv2.medianBlur(green_mask, 5)

        contours, _ = cv2.findContours(green_mask_blur, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        for i in range(len(contours)):
            rec_x, rec_y, rec_w, rec_h = cv2.boundingRect(contours[i])

            if rec_w + rec_x < 200:
                continue

            if cv2.contourArea(contours[i]) < 50 or cv2.contourArea(contours[i]) > 2500:
                continue

            if rec_w / rec_h > 2 or rec_w / rec_h < 0.4:
                continue

            if cv2.contourArea(contours[i]) / (rec_w * rec_h) < 0.4 or cv2.contourArea(contours[i]) / (rec_w * rec_h) > 0.8:
                continue

            cv2.rectangle(img_bgr, (rec_x, rec_y + 280), (rec_x + rec_w, rec_y + rec_h + 280), (0, 0, 255), 2)

            x.append(rec_x + rec_w / 2)
            y.append(rec_y + rec_h / 2 + 280)

        if len(x) != 0:
            self.center_point = self.cal(x, y)


    def line_follow(self,img_bgr):
        offset_enable = rospy.get_param("/offset_enable")
        # ret, cv_image = self.camera.read()
        if  offset_enable:
            self.find_line(img_bgr)
            print(self.center_point)
            if self.center_point is not None:
                self.twist_calculate(img_bgr.shape[1] / 2,self.center_point)
                print ("find out")
            else:
                print ("not found")
                if self.not_found_count >= 10:
                    self.twist = Twist()
                    self.twist.linear.x = 0
                    self.twist.angular.z = 0 
                    self.pub_cmd.publish(self.twist)
                    self.not_found_count = 0

    def twist_calculate(self,width,center):
        offset_enable = rospy.get_param("/offset_enable")
        if  offset_enable:
            center = float(center)
            # angle_max = 0.383973
            linear = 0.8 #越大越快 default 0.55 
            # P = 1.16 # 比例 
            self.twist = Twist()
            self.twist.linear.x = linear
            self.twist.linear.y = 0
            self.twist.linear.z = 0
            self.twist.angular.x = 0
            self.twist.angular.y = 0
            self.twist.angular.z = 0
            if self.mylinespeed < 0.8:
                if self.mylinespeed + 0.005 < 0.8:
                    self.twist.linear.x += 0.005
                else:
                    self.twist.linear.x = 0.8
            # if  center / width < 0.05:
            #     center = 0.05 * width
            #     self.twist.angular.z = self.twist.linear.x / 0.14 * (math.tan(angle_max))
            #     #self.twist.linear.x = 1 * linear
            # if center / width > 1.95:
            #     center = 1.95 * width
            #     self.twist.angular.z = self.twist.linear.x / 0.14 * ( - math.tan(angle_max))

            #     #self.twist.linear.x = 1 * linear

            # # if center / width > 0.9 and center / width < 1.1:  # 在中心位置
            # #     self.twist.linear.x = 1 * linear

            # if center / width > 0.05 and center / width <= 1:
            #     K = 1 - center/width
            #     #elf.twist.linear.x = linear
            #     self.twist.angular.z = self.twist.linear.x / 0.125 * (math.tan(angle_max * K * P ))  #左
            # if center / width > 1 and center / width < 1.95:
            #     K = center/width - 1
            #     #self.twist.linear.x = linear
            #     self.twist.angular.z = self.twist.linear.x / 0.125* (-math.tan(angle_max * K * P * 1.1))  #右
            #角速度缓慢变化
            
            self.twist.angular.z = -float(float(center-width) / width) * 1.5  #v=0.8
            # self.twist.angular.z = -float(float(center-width) / width) * 2.4  #v=1.2
            # self.twist.angular.z = -float(float(center-width) / width) * 2.3 
            # self.twist.angular.z = self.angle*0.25+self.twist.angular.z*0.75
            print (center)
            print (width)
            print (self.twist.angular.z)
            print ("  ")
            self.pub_cmd.publish(self.twist)
            self.angle = self.twist.angular.z
#PD控制
    # def twist_calculate(self, width, center):
    #     offset_enable = rospy.get_param("/offset_enable")
    #     if offset_enable:
    #         # PD Controller Parameters
    #         Kp = 4.0  # Proportional gain
    #         Kd = -1.2 # Derivative gain

    #         center = float(center)
    #         linear = 0.8  #越大越快 default 0.55 ypx 0.60

    #         # initialize the twist message
    #         self.twist = Twist()
    #         self.twist.linear.x = linear
    #         self.twist.linear.y = 0
    #         self.twist.linear.z = 0
    #         self.twist.angular.x = 0
    #         self.twist.angular.y = 0
    #         self.twist.angular.z = 0
    #         self.prev_error = 0
    #         if self.mylinespeed < 0.8:
    #             if self.mylinespeed + 0.005 < 0.8:
    #                 self.twist.linear.x += 0.005
    #             else:
    #                 self.twist.linear.x = 0.8
    #         # calculate error
    #         error = 1 - (center / width)
    #         # calculate derivative of error
    #         d_error = error - self.prev_error  # assumes that pd_control_calculate is called in a loop
    #         self.prev_error = error

    #         # calculate the angular velocity
    #         self.twist.angular.z = Kp * error + Kd * d_error
    #         print (self.twist.angular.z)
    #         # publish the twist message
    #         self.pub_cmd.publish(self.twist)

# def find_word(image, templates):
#     # 预处理
#     gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)  # 灰度处理
#     gray = cv2.GaussianBlur(gray, (5, 5), 0)  # 高斯滤波
#     _, binary = cv2.threshold(gray, 135, 255, cv2.THRESH_BINARY_INV)  # 二值化
#     kernel = np.ones((7,7),np.uint8)
#     dilated = cv2.dilate(binary, kernel, iterations = 1)
#     contours, _ = cv2.findContours(dilated, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)  # 轮廓查找
    
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
#         max_val = 0
#         max_idx = -1
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
# def find_word(image, templates):
#     # 预处理
#     print('find_word called')  
#     gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)  # 灰度处理
#     gray = cv2.GaussianBlur(gray, (5, 5), 0)  # 高斯滤波
#     _, binary = cv2.threshold(gray, 135, 255, cv2.THRESH_BINARY_INV)  # 二值化
#     kernel = np.ones((7,7),np.uint8)
#     dilated = cv2.dilate(binary, kernel, iterations = 1)
#     contours, _ = cv2.findContours(dilated, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)  # 轮廓查找
    
#     found_text_image = False  # 初始化标记
#     max_val = -np.inf
#     max_idx = -1
#     for i in range(len(contours)):
#         x, y, w, h = cv2.boundingRect(contours[i])  # 获取文字区域
#         # cv2.rectangle(image, (x, y), (x+w, y+h), (0, 0, 255), 2)
#         if cv2.contourArea(contours[i]) < 1000 or cv2.contourArea(contours[i]) > 7000:
#             continue
#         if w / h > 3 or w / h < 1.2:
#             continue
#         text_image = gray[y:y+h, x:x+w]  # 截取文字区域
#         found_text_image = True  # 设置标记为True
#         # cv2.rectangle(image, (x, y), (x+w, y+h), (0, 0, 255), 2)  # 绘制矩形
#         max_vals = []
#         for template in templates:
#             # 将模板调整为和文字区域一样的大小
#             resized_template = cv2.resize(template, (w, h))
#             edges_text_image = cv2.Canny(text_image, 50, 150)
#             edges_template = cv2.Canny(resized_template, 50, 150)
#             # 模板匹配
#             res = cv2.matchTemplate(edge_text_image, edges_template, cv2.TM_CCOEFF_NORMED)
#             print(res)
#             _, current_max_val, _, _ = cv2.minMaxLoc(res)
#             max_vals.append(current_max_val)
#         max_val = max(max_vals)
#         max_idx = max_vals.index(max_val)
#         print('find_word finished, max_val:', max_val, ', max_idx:', max_idx)
#             # if current_max_val > max_val: 
#             #     max_val = current_max_val
#             #     max_idx = templates.index(template)
#     return max_val , max_idx , found_text_image

# def is_find_word(image , temp):
#     max_val , max_idx , found_text_image= find_word(image , temp)
#     # print("zhaodao")
#     if max_val > 20.0:
#         current_recognition = rospy.get_param("/word_recognition")
#         print("zhaodao")
#         if max_idx + 1 in [1, 2]:
#             print("停车位A")
#             if current_recognition != 1:
#                 rospy.set_param("/word_recognition", 1)    #停车位A
#         elif max_idx + 1 in [3, 4]:
#             print("停车位B")
#             if current_recognition != 0:
#                 rospy.set_param("/word_recognition", 0)    #停车位B
            
#         # cv2.rectangle(image, (x, y), (x+w, y+h), (0, 255, 0), 2)  # 绘制矩形






# det = ddddocr.DdddOcr()
# text = ""
# def is_find_word(image):
#     # 预处理
#     global text
#     gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)  # 灰度处理
#     gray = cv2.GaussianBlur(gray, (5, 5), 0)  # 高斯滤波
#     _, binary = cv2.threshold(gray, 125, 255, cv2.THRESH_BINARY_INV)  # 二值化
#     kernel = np.ones((13,13),np.uint8)
#     dilated = cv2.dilate(binary, kernel, iterations = 1)
#     contours, _ = cv2.findContours(dilated, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)  # 轮廓查找
    
#     found_text_image = False  # 初始化标记
#     for i in range(len(contours)):
#         x, y, w, h = cv2.boundingRect(contours[i])  # 获取文字区域
#         # if w + x < 200 or w + x > 500:
#         #     continue
#         if cv2.contourArea(contours[i]) < 1500 or cv2.contourArea(contours[i]) > 20000:
#             continue
#         if w / h > 4 or w / h < 0.8:
#             continue
#         if cv2.contourArea(contours[i]) / (w * h) < 0.4:
#             continue
#         text_image = gray[y:y+h, x:x+w]  # 截取文字区域
#         cv2.rectangle(image, (x, y), (x+w, y+h), (0, 255, 0), 2)
#         _, buf = cv2.imencode(".png", text_image)
#         text_image_bytes = buf.tobytes()
#         text = det.classification(text_image_bytes)

#         found_text_image = True  # 设置标记为True
#         if any(word in text for word in ["三院", "院", "二院","航天","现大","现人","现天","二"]):
#             print("B")
#             rospy.set_param("/word_recognition", 0)
#             # rospy.set_param("/word_enable",0)
#         elif any(word in text for word in ["星航", "机电", "电","机","北电"]):
#             print("A")
#             rospy.set_param("/word_recognition", 1)
#             # rospy.set_param("/word_enable",0)

#         print(text)
#         # max_vals = []
#         # for template in templates:
#         #     # 将模板调整为和文字区域一样的大小
#         #     resized_template = cv2.resize(template, (w, h))

#         #     # 模板匹配
#         #     res = cv2.matchTemplate(text_image, resized_template, cv2.TM_CCOEFF_NORMED)
#         #     _, max_val, _, _ = cv2.minMaxLoc(res)
#         #     max_vals.append(max_val)

#         # # 获取最大匹配值及其对应的模板
#         # max_val = max(max_vals)
#         # max_idx = max_vals.index(max_val)
#         # print(max_val)
#         # if max_val > 0.20:
#         #     if max_idx + 1 in [1, 2]:
#         #         print('A')
#         #         rospy.set_param("/word_recognition", 1)
#         #     elif max_idx + 1 in [3, 4]:
#         #         print('B')
#         #         rospy.set_param("/word_recognition", 0)
#         # cv2.rectangle(image, (x, y), (x+w, y+h), (0, 255, 0), 2) 
#             #  绘制矩形
        
#     return image , dilated
        
#     # return image , dilated

text = ""
ocr_handle = OcrHandle()
frame_counter = 0

def is_find_word(image):
    global ocr_handle
    results = ocr_handle.text_predict(frame, short_size=800)
    for result in results:
        box, text, score = result
        print(f"Detected text: {text}, at position: {box}, with confidence: {score}") 

        if any(word in text for word in ["三院", "院", "二院","航天","天","三","完","大","简天"]):
            print("B")
            rospy.set_param("/word_recognition", 0)
            rospy.set_param("/judge_word",1)
            # rospy.set_param("/word_enable",0)
        elif any(word in text for word in ["星航", "机电", "电","机","星","里","皇","是","里航","星饭"]):
            print("A")
            rospy.set_param("/word_recognition", 1)
            rospy.set_param("/judge_word",1)
            # rospy.set_param("/word_enable",0)
        
    return image


def word_solve(img):
    global text
    word_enable = rospy.get_param("/word_enable")
    if  word_enable:
        # cv_img = cv2.cvtColor(cv_img, cv2.COLOR_RGB2BGR)
        # img = cv2.resize(cv_img,(640,480))
        print("success")
        is_find_word(img)
    else:
        text = ""




if __name__ == '__main__':


    sock1 = socket_init()

    gst_str =  ('nvarguscamerasrc ! '
                'video/x-raw(memory:NVMM), '
                'width=(int)640, height=(int)480, '
                'format=(string)NV12, framerate=(fraction)30/1 ! '
                'nvvidconv ! '
                'video/x-raw, width=(int){}, height=(int){}, '
                'format=(string)BGRx ! '
                'videoconvert ! appsink').format(640, 480)
    
    cap = cv2.VideoCapture(gst_str, cv2.CAP_GSTREAMER)

    rospy.init_node('camera_node', anonymous=True) #定义节点
    rospy.loginfo("Starting vision and sock node")
    rospy.set_param("/trafficlight_enable",0) #红绿灯使能
    rospy.set_param("/offset_enable",0) #巡线使能
    rospy.set_param("/word_enable",0) #标志使能
    rospy.set_param("/red_traffic",False)
    rospy.set_param("/word_recognition", 0)

    rospy.Subscriber('/amcl_pose',PoseWithCovarianceStamped,PoseCallBack)
    # templates = []
    # for i in range(4):
    #     template_path = os.path.join('/home/qingzhou/catkin_ws/src/vision/data', "z{}.png".format(i))
    #     template = cv2.imread(template_path, 0)
    #     if template is None:
    #         print('Failed to load word{i}.png')
    #     else:
    #         templates.append(template)


    a = line_follow()
    k = 0
    while not rospy.is_shutdown():
        ret , frame = cap.read()  # 捕获图像
        traffic_solve(frame)
        a.line_follow(frame)
        frame_counter += 1
        if frame_counter % 30 == 0: 
            word_solve(frame)
        if (k>=3):
            frame = cv2.resize(frame,(320, 240))
            encode_param=[int(cv2.IMWRITE_JPEG_QUALITY),30] #设置编码参数
            result, imgencode = cv2.imencode('.jpg', frame,encode_param)
            data = np.array(imgencode)
            stringData = data.tostring()
            # 首先发送图片编码后的长度  
            #ljust() 方法返回一个原字符串左对齐,并使用空格填充至指定长度的新字符串
            sock1.send(str(len(stringData)).encode('utf-8').ljust(16))
            #print(len(stringData))
            # 然后一个字节一个字节发送编码的内容
            # 如果是python对python那么可以一次性发送，如果发给c++的server则必须分开发因为编码里面有字符串结束标志位，c++会截断
            sock1.sendall(stringData)
            #print(stringData)
            # for i in range(0,len(stringData)):
            #     #print(stringData[i])
            #     sock1.send(str(stringData[i]))
            
            k = 0
        k += 1
        # print(frame)
        # # print(frame.shape)
        # if ret: # 如果有画面再执行
        #     image_pub.publish(bridge.cv2_to_imgmsg(frame, "bgr8")) # 发布消息（只需要一次转换即可！）
        #     rate = rospy.Rate(25) # 10hz 
        #     print('success')
        #     print(frame)
        #     frame = cv2.resize(frame, (640, 480))
        # else:
        #     print('failed')
        # a.line_follow(frame)
    cap.release()
    print("quit successfully!")