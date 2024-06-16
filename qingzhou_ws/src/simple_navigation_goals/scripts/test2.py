#!/usr/bin/env python
# -*- coding:utf-8-*-

import time
import sys

import socket            # 导入 socket 模块
import pickle
import struct
import thread

import numpy as np

import rospy
from std_msgs.msg import String
from geometry_msgs.msg import PoseWithCovarianceStamped,PoseStamped

import cv2

serverIp = '10.66.193.100'
udpserverip = '10.66.193.103'
tcpPort = 8888
udpPort = 8888
#global param 

#param = struct.pack('ifffffii', 1, 0.1, 0.1, 0.1, 0.1, 0.1, 4, 2)



'''
struct Info {
    int carID;
    float x, y;                 // X,Y坐标
    float theta;// 角度
    float angleSpeed;
    float linerSpeed;       
    int navstaus;
    int status;
};
'''

class Info:
    carID = 1
    x = 0.1
    y = 0.1
    theta = 0.1
    angleSpeed = 0.1
    linerSpeed = 0.1
    navstaus = 4
    status = 2

def thread_job():
    rospy.spin()

def PoseCallBack(msg):
	#data=""
	global param
	info = Info()
	
	info.x = msg.pose.pose.position.x
	info.y = msg.pose.pose.position.y

	orien_z = msg.pose.pose.orientation.z
	orien_w = msg.pose.pose.orientation.w
	
	info.theta = 0.1
	info.angleSpeed = 0.1
	info.linerSpeed = 0.1
	info.carID = 1
	info.navstaus = 4
	info.status = 2
	#data = str(x) + "," + str(y)+ "," + str(orien_z)+ "," + str(orien_w)
	#rospy.loginfo(data)
	param = struct.pack('ifffffii', 
	info.carID, 
	info.x, 
	info.y, 
	info.theta, 
	info.angleSpeed, 
	info.linerSpeed, 
	info.navstaus, 
	info.status)

	print (info.x)

def socket_send_Info_test(threadName, delay, sock):
    print (threadName)
    rospy.init_node('pose_sub',anonymous=False)
    rospy.sleep(2)
    #监控话题，并在回调函数中处理
    data = rospy.wait_for_message("/amcl_pose", PoseWithCovarianceStamped, timeout=None)
    #add_thread = threading.Thread(target = thread_job)
    #add_thread.start()
    #rospy.Subscriber('/amcl_pose',PoseWithCovarianceStamped,PoseCallBack)
    info = Info()

    info.x = data.pose.pose.position.x
    info.y = data.pose.pose.position.y

    orien_z = data.pose.pose.orientation.z
    orien_w = data.pose.pose.orientation.w

    info.theta = 0.1
    info.angleSpeed = 0.1
    info.linerSpeed = 0.1
    info.carID = 1
    info.navstaus = 4
    info.status = 2
    #data = str(x) + "," + str(y)+ "," + str(orien_z)+ "," + str(orien_w)
    #rospy.loginfo(data)
    param = struct.pack('ifffffii', 
    info.carID, 
    info.x, 
    info.y, 
    info.theta, 
    info.angleSpeed, 
    info.linerSpeed, 
    info.navstaus, 
    info.status)
    socket_send(sock, param)

def camera_init():
    #0号摄像头，也可以1、2，lsusb查看
    print("camera init")
     #生成读取摄像头对象
    cap = cv2.VideoCapture(0)

    #设置分辨率
    cap.set(3, 352)
    cap.set(4, 288)
    time.sleep(2) #必须要此步骤，否则失败
    cap.set(15, -8.0)

    #只能是如下选择分辨率.
    #160.0 x 120.0
    #176.0 x 144.0
    #320.0 x 240.0
    #352.0 x 288.0
    #640.0 x 480.0
    #1024.0 x 768.0
    #1280.0 x 1024.0

    #获取视频的帧率
    #fps = cap.get(cv2.CAP_PROP_FPS)
    #获取视频的宽度&高度
    size = (int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)),
        int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)))
    #使用XVID编码器
    fourcc = cv2.VideoWriter_fourcc(*'CVID')

    if (cap.isOpened()):
        print("OK")
    else:
       print("Camera init ERROR")
    return cap

def camera_show(cap):
    while (cap.isOpened()):
        #读取摄像头画面
        ret, frame = cap.read()
        if ret == True:
            frame = cv2.flip(frame, 1)
            #显示画面
            cv2.imshow('camera', frame)
            #gray = cv2.cvtColor(frame,  cv2.COLOR_BGR2GRAY)
            #cv2.imshow('camera', gray)

            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
        else:
            break

def camera_show_color(cap, color):
    while (cap.isOpened()):
        ret, frame = cap.read()
        if ret == True:
            frame = cv2.flip(frame, 1)
            col_frame = cv2.cvtColor(frame, color)
            cv2.imshow('camera', col_frame)

            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
        else:
            break

def camera_send(sock, cap):
    while (cap.isOpened()):
        frame = cap.read()
        # data = pickle.dumps(frame)
        #sock.sendall(struct.pack("H", len(data)) + data)
        print("here")
        print(sys.getsizeof(frame))
        sock.send(pickle.dumps(frame))

def camera_send_yhh(sock, cap):#在ubunt下可以发送
    print("tcp_video_transing")
    ret, frame = cap.read()
    if ret == True:
        frame = cv2.flip(frame,180)#视频反转
    else:
        print("ret error")
    encode_param=[int(cv2.IMWRITE_JPEG_QUALITY),90] #设置编码参数

    while ret: 
        # 首先对图片进行编码，因为socket不支持直接发送图片
        result, imgencode = cv2.imencode('.jpg', frame)
        data = np.array(imgencode)
        stringData = data.tostring()
        # 首先发送图片编码后的长度
        #ljust() 方法返回一个原字符串左对齐,并使用空格填充至指定长度的新字符串
        sock.send(str(len(stringData)).ljust(16))
        # print("string")
        # print(len(stringData))
        # sock.send("123")
        # 然后一个字节一个字节发送编码的内容
        # 如果是python对python那么可以一次性发送，如果发给c++的server则必须分开发因为编码里面有字符串结束标志位，c++会截断
        for i in range (0,len(stringData)):
            sock.send(stringData[i])
        # sock.send("456")
        ret, frame = cap.read()
        if ret == True:
            frame = cv2.flip(frame,180)#视频反转
        else:
            print("ret error")
        cv2.imshow('camera',frame)
        if cv2.waitKey(10) == 27:
             break

def udp_send_img_yhh(sock, port, cap):
    print ('udp_send_img')
    # while (cap.isOpened()):
    #     ret, frame = cap.read()
    #     data = pickle.dumps(frame)
    #     print (sys.getsizeof(frame))
    #     print(frame.size)
    #     #imgencode = cv2.imencode('.jpg', frame, [cv2.IMWRITE_JPEG_QUALITY, 50])
    #     img_encode = cv2.imencode('.jpg', frame)[1]
    #     encode_arr = np.array(img_encode)
    #     encode_str = encode_arr.tostring()
    #     sock.sendto(encode_str,                                                                                                                                             
    #         (serverIp, port))
    ret, frame = cap.read()
    if ret == True:
        frame = cv2.flip(frame,180)#视频反转
    else:
        print("ret error")
    encode_param=[int(cv2.IMWRITE_JPEG_QUALITY),90] #设置编码参数

    while ret: 
        # 首先对图片进行编码，因为socket不支持直接发送图片
        result, imgencode = cv2.imencode('.jpg', frame)
        data = np.array(imgencode)
        stringData = data.tostring()
        # 首先发送图片编码后的长度
        # sock.send(str(len(stringData)).ljust(16))
        sock.sendto(str(len(stringData)).ljust(16),(serverIp, port))
        # print("string")
        # print(len(stringData))
        # sock.send("123")
        # 然后一个字节一个字节发送编码的内容
        # 如果是python对python那么可以一次性发送，如果发给c++的server则必须分开发因为编码里面有字符串结束标志位，c++会截断
        for i in range (0,len(stringData)):
            sock.sendto(stringData[i],(serverIp, port))
        # sock.send("456")
        ret, frame = cap.read()
        if ret == True:
            frame = cv2.flip(frame,180)#视频反转
        else:
            print("ret error")
        cv2.imshow('camera',frame)
        if cv2.waitKey(10) == 27:
             break

def pic_to_array(pic):
    stram = BytesIO()
    pic.save(stram, format="JPEG")
    array_pic = np.array(Image.open(stram))
    stram.close()
    return array_pic

def array_pic_to_stream(pic):
    stream = BytesIO()
    pic = Image.fromarray(pic)
    pic.save(stream, format="JPEG")
    jepg = stream.getvalue()
    stream.close()
    return jepg 

def udp_send_img(sock, port, cap):
    print ('udp_send_img')
    while (cap.isOpened()):
        ret, frame = cap.read()
        data = pickle.dumps(frame)
        print (sys.getsizeof(frame))
        print(frame.size)
        #imgencode = cv2.imencode('.jpg', frame, [cv2.IMWRITE_JPEG_QUALITY, 50])
        img_encode = cv2.imencode('.jpg', frame)[1]
        encode_arr = np.array(img_encode)
        encode_str = encode_arr.tostring()
        sock.sendto(encode_str,                                                                                                                                             
            (serverIp, port))

def camera_close(cap):
    cap.release()
    cv2.destroyAllWindows()

def socket_init():
	sock = socket.socket()      # 创建 socket 对象
	host = socket.gethostname() # 获取本地主机名

	sock.connect((serverIp, tcpPort))
	print ("connect ok")

	return sock

def udp_init():
    print( 'udp_init_ok')
    return socket.socket(socket.AF_INET,
        socket.SOCK_DGRAM)

def udp_send(threadName,sock):
    print(threadName)
    while(1):
        msg = str(rospy.get_param('/task'))
        sock.sendto(msg,(udpserverip,udpPort)) #将msg内容发送给指定接收方
        msg = str(rospy.get_param("/carID"))
        sock.sendto(msg,(udpserverip,udpPort)) #将msg内容发送给指定接收方
        msg = str(rospy.get_param("/x"))
        sock.sendto(msg,(udpserverip,udpPort)) #将msg内容发送给指定接收方
        msg = str(rospy.get_param("/y"))
        sock.sendto(msg,(udpserverip,udpPort)) #将msg内容发送给指定接收方
        msg = str(rospy.get_param("/theta"))
        sock.sendto(msg,(udpserverip,udpPort)) #将msg内容发送给指定接收方
        msg = str(rospy.get_param("/angleSpeed"))
        sock.sendto(msg,(udpserverip,udpPort)) #将msg内容发送给指定接收方
        msg = str(rospy.get_param("/linerSpeed"))
        sock.sendto(msg,(udpserverip,udpPort)) #将msg内容发送给指定接收方
        msg = str(rospy.get_param("/navstaus"))
        sock.sendto(msg,(udpserverip,udpPort)) #将msg内容发送给指定接收方
        msg = str(rospy.get_param("/status"))
        sock.sendto(msg,(udpserverip,udpPort)) #将msg内容发送给指定接收方
        
def socket_send(sock, data):
    print('tcp_send_ok')
    sock.send(data)

def socket_recv(threadName, delay, sock):
    print (threadName)
    while True:
        data = sock.recv(1024)
        if(len(data) >= 23):
            socket_recv_parse(data)
        else:
            print( data)

#ros_param参数服务器设定任务
def socket_recv_param(threadName, delay, sock):
    print(threadName)
    while True:
        data = sock.recv(2)
        if(data[0] =='1'):
            print("task 1")
            rospy.set_param("task",1)
        elif(data[0] =='2'):
            print("task 2")
            rospy.set_param("task",2)
        elif(data[0] =='3'):
            print("task 3")
            rospy.set_param("task",3)
        elif(data[0] =='4'):
            print("task 4")
            rospy.set_param("task",4)
        elif(data[0] =='5'):
            print("task 5")
            rospy.set_param("task",0)
        else:
            print(data)
            print("rec dome")
    
def socket_recv_parse(data):#还没看懂干啥
    #print data[8]
    if(data[8] == '0'):
        socket_recv_wait(data)
    elif(data[8] == '@'):
        socket_recv_receipt(data)
    elif(data[8] == 'P'):
        socket_recv_unload(data)
        
def socket_recv_wait(data):#还没看懂干啥
    print (bytesToFloat(data[12], 
            data[11], 
            data[10], 
            data[9]))
    print (bytesToFloat(data[16], 
            data[15], 
            data[14], 
            data[13]))

def socket_recv_receipt(data):#还没看懂干啥
    print (bytesToFloat(data[12], 
            data[11], 
            data[10], 
            data[9]))
    print( bytesToFloat(data[16], 
            data[15], 
            data[14], 
            data[13]))

def socket_recv_unload(data):#还没看懂干啥
    print (bytesToFloat(data[12], 
            data[11], 
            data[10], 
            data[9]))
    print (bytesToFloat(data[16], 
            data[15], 
            data[14], 
            data[13]))

def socket_close(sock):
    sock.close()

def bytesToFloat(h1, h2, h3, h4):
    ba = bytearray()
    ba.append(h1)
    ba.append(h2)
    ba.append(h3)
    ba.append(h4)
    return struct.unpack("!f",ba)[0]

if __name__ == '__main__':
    #sock = socket_init()
    # udp = udp_init()
    # while True:
    #     socket_send(sock, 'helurong')
    cap = camera_init()
    #rospy.init_node('test', anonymous=True)
    #rospy.set_param("/task", 255);
    #rospy.set_param("/carID",1);
    #rospy.set_param("/x",0.1)
    #rospy.set_param("/y",0.1)
    #rospy.set_param("/theta",0.1)
    #rospy.set_param("/angleSpeed",0.1)
    #rospy.set_param("/linerSpeed",0.1)
    #rospy.set_param("/navstaus",4)
    #rospy.set_param("/status",2)
 
    #try:
    #    thread.start_new_thread(socket_recv_param, ("socket_recv", 2, sock))
        # thread.start_new_thread(camera_send_yhh(sock, cap))
   #     thread.start_new_thread(udp_send,("udp_send_ok",udp))
   # except:
     #   print ("Error: unable to start thread")

   # while True:
      #  camera_send_yhh(sock, cap)
        # udp_send("udp_send_ok",udp)
    #     socket_send_Info_test("socket_send", 0, sock)

    #自己视频发送（实现）
    # camera_send_yhh(sock, cap)
    #学姐视频发送（没实现）
    # camera_send(sock, cap)
    #ubuntu显示画面(彩色)
    camera_show(cap)
    #ubuntu显示画面(灰色)
    # camera_show_color(cap, cv2.COLOR_BGR2GRAY)

    # udp_send_img_yhh(udp, udpPort, cap)    
    #camera_close(cap)
    #socket_close(sock)
