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
# from threading import Thread

lower_green = np.array([35, 43, 46])
upper_green = np.array([80, 255, 255])

class line_follow:
    def __init__(self):    
        #define topic publisher and subscriber
        self.bridge = CvBridge()
        # self.image_sub = rospy.Subscriber("/image_raw/compressed", CompressedImage, self.callback)
        self.odom = rospy.Subscriber("/odom_data", Odometry, self.odom_callback)
        self.bgr_pub = rospy.Publisher("/img_bgr", Image, queue_size=1)
        self.result_pub = rospy.Publisher("/result_image", Image, queue_size=1)
        self.pub_cmd = rospy.Publisher("/cmd_vel", Twist, queue_size=1)

        self.center_point = 0
        self.mylinespeed = 0
        self.view_flag = 0
        self.angle = 0
        self.last_center_point = 0
        self.not_found_count = 0

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
        # img_gray = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2GRAY)
        # img_gray_below = img_gray[320:480, :]
        # mean = np.mean(img_gray_below) * 0.8
        # _, thresh = cv2.threshold(img_gray_below, mean, 255, cv2.THRESH_BINARY_INV)
        # img_blur = cv2.medianBlur(thresh, 5)

        img_below = img_bgr[280:480, :]
        img_hsv = cv2.cvtColor(img_below, cv2.COLOR_BGR2HSV)
        green_mask = cv2.inRange(img_hsv, lower_green, upper_green)
        kernel = np.ones((3,3),np.uint8)
        green_mask_blur = cv2.dilate(green_mask, kernel, iterations = 1)
        green_mask_blur = cv2.medianBlur(green_mask, 5)

        contours, _ = cv2.findContours(green_mask_blur, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        for i in range(len(contours)):
            rec_x, rec_y, rec_w, rec_h = cv2.boundingRect(contours[i])

            if rec_w + rec_x < 200:
                continue

            if cv2.contourArea(contours[i]) < 70 or cv2.contourArea(contours[i]) > 2500:
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
            # convert ROS topic to CV image formart
            # try:
            #     cv_image = self.bridge.compressed_imgmsg_to_cv2(data, "bgr8")
            # except CvBridgeError as e:
            #     print (e)
            # cv_image = image = self.camera.read()
            # print(cv_image)
            # compressedimg = self.bridge.cv2_to_imgmsg(cv_image, encoding="bgr8")
            # compressedimg.header.stamp = rospy.Time.now()
            # self.image_sub.publish(compressedimg)
            # img_bgr = cv2.resize(cv_image, (640, 480))
            self.find_line(img_bgr)
            print(self.center_point)
            if self.center_point:
                self.twist_calculate(img_bgr.shape[1] / 2,self.center_point)
                print ("find out")
            else:
                print ("not found")
                self.not_found_count += 1
                if self.not_found_count >= 10:
                    self.twist = Twist()
                    self.twist.linear.x = 0
                    self.twist.angular.z = 0 
                    self.pub_cmd.publish(self.twist)
                    self.not_found_count = 0
            # self.center_point = 0
            # convert CV image to ROS topic and pub
            
            # try:
            #     img_msg = self.bridge.cv2_to_imgmsg(img_bgr, encoding="bgr8")
            #     img_msg.header.stamp = rospy.Time.now()
            #     self.result_pub.publish(img_msg)
            # except CvBridgeError as e:
            #     print (e)

    def twist_calculate(self,width,center):
        center = float(center)
        angle_max = 0.383973
        linear = 1 #越大越快 default 0.55 
        P = 2.6 #比例 
        self.twist = Twist()
        self.twist.linear.x = linear
        self.twist.linear.y = 0
        self.twist.linear.z = 0
        self.twist.angular.x = 0
        self.twist.angular.y = 0
        self.twist.angular.z = 0
        if self.mylinespeed < 1:
            if self.mylinespeed + 0.005 < 1:
                self.twist.linear.x += 0.005
            else:
                self.twist.linear.x = 1
        if  center / width < 0.05:
            center = 0.05 * width
            self.twist.angular.z = self.twist.linear.x / 0.1 * (math.tan(angle_max))
            #self.twist.linear.x = 1 * linear
        if center / width > 1.95:
            center = 1.95 * width
            self.twist.angular.z = self.twist.linear.x / 0.1 * ( - math.tan(angle_max))

            #self.twist.linear.x = 1 * linear

        # if center / width > 0.9 and center / width < 1.1:  # 在中心位置
        #     self.twist.linear.x = 1 * linear

        if center / width > 0.05 and center / width <= 1:
            K = 1 - center/width
            #elf.twist.linear.x = linear
            self.twist.angular.z = self.twist.linear.x / 0.1 * (math.tan(angle_max * K * P ))  #左
        if center / width > 1 and center / width < 1.95:
            K = center/width - 1
            #self.twist.linear.x = linear
            self.twist.angular.z = self.twist.linear.x / 0.1* (-math.tan(angle_max * K * P * 2))  #右
        #角速度缓慢变化
        
        # self.twist.angular.z = -float(float(center-width) / width) * 1.5  #v=0.8
        # self.twist.angular.z = -float(float(center-width) / width) * 2.4  #v=1.2
        # self.twist.angular.z = -float(float(center-width) / width) * 2.3 
        # self.twist.angular.z = self.angle*0.2+self.twist.angular.z*0.8
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
# #PID控制
#     def twist_calculate(self, width, center):
#         offset_enable = rospy.get_param("/offset_enable")
#         if offset_enable:
#             # PD Controller Parameters
#             Kp = 3.0  # Proportional gain
#             Ki  = 0    #integral gain
#             Kd = -1.5 # Derivative gain

#             center = float(center)
#             linear = 0.5  #越大越快 default 0.55 ypx 0.60

#             # initialize the twist message
#             self.twist = Twist()
#             self.twist.linear.x = linear
#             self.twist.linear.y = 0
#             self.twist.linear.z = 0
#             self.twist.angular.x = 0
#             self.twist.angular.y = 0
#             self.twist.angular.z = 0
#             self.prev_error = 0
#             if self.mylinespeed < 0.5:
#                 if self.mylinespeed + 0.005 < 0.5:
#                     self.twist.linear.x += 0.005
#                 else:
#                     self.twist.linear.x = 0.5
#             # calculate error
#             error = 1 - (center / width)

#             i_error += error 
#             # calculate derivative of error
#             d_error = error - self.prev_error  # assumes that pd_control_calculate is called in a loop
#             self.prev_error = error

#             # calculate the angular velocity
#             self.twist.angular.z = Kp * error +Ki* i_error+Kd * d_error
#             print (self.twist.angular.z)
#             # publish the twist message
#             self.pub_cmd.publish(self.twist)



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
    # cap = CSICamera(width=640, height=480, capture_width=640, capture_height=480, capture_fps=20)
    rospy.init_node('camera_node_line', anonymous=True) #定义节点
    rospy.loginfo("Starting Line Follow node")
    rospy.set_param("/offset_enable",1)

    a = line_follow()
    while not rospy.is_shutdown():    # Ctrl C正常退出，如果异常退出会报错device busy！
        ret , frame = cap.read()
        # print(frame)
        # frame = cap.read()
        # cv2.imshow('frame',frame)
        # print(id(frame))
        a.line_follow(frame)
        # rospy.spin()
    # cv2.destroyAllWindows()
    cap.release()

    print("quit successfully!")