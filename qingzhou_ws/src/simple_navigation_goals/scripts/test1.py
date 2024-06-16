#!/usr/bin/env python
# -*- coding:utf-8 -*-
# -*- coding:cp936 -*-
import socket
import os
import time
import threading
import rospy

rospy.init_node("set_update_paramter_p")

rospy.set_param("task",10)


server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(("10.66.193.121", 9997))
server.listen(5)
print('Waiting for connection...')
connection, address = server.accept()
print(connection, address)

class A(threading.Thread):
  def __init__(self):
    threading.Thread.__init__(self)

  def run(self):
    while True:
      recv_str = connection.recv(1024)
      if len(recv_str) > 0:
        recv_str = recv_str.decode('gbk',"ignore")
        print("trans success!!!")
        print(len(recv_str))
        print(recv_str)

        if   (recv_str == 'A'):
          rospy.set_param("/task",1)

        elif (recv_str == 'B'):
          rospy.set_param("/task",2)

        elif (recv_str == 'C'):
          rospy.set_param("/task",3)

        print(rospy.get_param("task"))

e = A()
e.start()

while True:
  dispatch_orders = input("我说:").strip().decode('utf-8').encode('gbk')
  while not(dispatch_orders):
    dispatch_orders = input("我说:").strip()
  connection.send(dispatch_orders)

connection.close()
server.close()


