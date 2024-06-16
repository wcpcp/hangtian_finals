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

if __name__ == '__main__':
    # try:
    # init ROS node 
    # camera = cv2.VideoCapture(0)

    sock1 = socket_init()
    gst_str =  ('nvarguscamerasrc ! '
                'video/x-raw(memory:NVMM), '
                'width=(int)640, height=(int)480, '
                'format=(string)NV12, framerate=(fraction)20/1 ! '
                'nvvidconv ! '
                'video/x-raw, width=(int){}, height=(int){}, '
                'format=(string)BGRx ! '
                'videoconvert ! appsink').format(640, 480)
    
    cap = cv2.VideoCapture(gst_str, cv2.CAP_GSTREAMER)

    rospy.init_node('sock_node', anonymous=True) #定义节点
    rospy.loginfo("Starting sock connect node")

    k = 0
    while not rospy.is_shutdown():    # Ctrl C正常退出，如果异常退出会报错device busy！
        ret , frame = cap.read()
        # print(id(frame))
        if (k>=3):
            frame = cv2.resize(frame,(320, 240))
            encode_param=[int(cv2.IMWRITE_JPEG_QUALITY),20] #设置编码参数
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
            # image_pub.publish(bridge.cv2_to_imgmsg(frame, "bgr8")) # 发布消息（只需要一次转换即可！）
            # rate = rospy.Rate(25) # 10hz 
            # print('success')
            # print(frame)
            # frame = cv2.resize(frame, (640, 480))
        # else:
        #     print('failed')
        # a.line_follow(frame)
    cap.release()

    print("quit successfully!")