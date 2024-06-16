#!/usr/bin/env python

# coding:utf-8 
#get the point and ore form rviz to txt
#Type: geometry_msgs/PoseStamped  /move_base_simple/goal
#todo: change the count to the key "finish"
#todo: not the cover the last csv 
import rospy
import math
import sys,select,termios,tty
import tf
import csv
import codecs
from geometry_msgs.msg import PoseStamped
goal_num=0
count = 0
point=[]
def PoseStampedCB(data):
    print("into   callback______________--")
    global count
    gx = data.pose.position.x
    gy = data.pose.position.y
    # gz = data.pose.orientation.z
    # gw = data.pose.orientation.w
    point.append([gx,gy])
    print(str(gx))
 
    


def getKey():
    tty.setraw(sys.stdin.fileno())
    rlist,_,_ = select.select([sys.stdin],[],[],0.1)
    if rlist:
        key = sys.stdin.read(1)
    else:
        key = ''
    termios.tcsetattr(sys.stdin,termios.TCSADRAIN,settings)
    return key
 
def data_write_csv(file_name, datas):
    global goal_num
    file_csv = codecs.open(file_name,'w+','utf-8')
    writer = csv.writer(file_csv, delimiter=',', quoting=csv.QUOTE_MINIMAL)
    for data in datas:
        writer.writerow(data)
        goal_num+=1
        print("----------------------------------------------------------%d"%goal_num)
    print("write succ!!")

if __name__ == '__main__':
    try:
        rospy.init_node("getPoint",anonymous=True)
        # rospy.Subscriber('/goal1',PoseStamped,PoseStampedCB,queue_size=10)
        rospy.Subscriber('/move_base_simple/goal',PoseStamped,PoseStampedCB,queue_size=10)
        
        settings = termios.tcgetattr(sys.stdin)
        while(1):
            Key = getKey()
            # print("after getkey_____________")
            if Key == 'f' or Key == 'F':
                print("after _____________")
                data_write_csv('/home/qingzhou/qingzhou_ws/src/racecar/scripts/test.csv',point)
                print("----------------------------------------------------------abc")
            if Key == '\x03':
                break

        rospy.spin()
    except rospy.ROSInterruptException:
        pass 