#!/usr/bin/env python 
# -*- coding: utf-8 -*-
 
import roslib;
import rospy  
import actionlib  
from actionlib_msgs.msg import *  
from geometry_msgs.msg import Pose, PoseWithCovarianceStamped, Point, Quaternion, Twist  
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal  


# 节点初始化 
rospy.init_node('move_test', anonymous=True)  


# 订阅move_base服务器的消息  
move_base = actionlib.SimpleActionClient("move_base", MoveBaseAction)  

rospy.loginfo("Waiting for move_base action server...")  


# 等待连接服务器，5s等待时间限制 
while move_base.wait_for_server(rospy.Duration(5.0)) == 0:
    rospy.loginfo("Connected to move base server")  


task01_flag = False
task02_flag = False
task03_flag = False

''' 自定义函数 设置目标点并发送 '''
def my_send_goal(target):
     # 设定目标点
    goal = MoveBaseGoal()
    goal.target_pose.pose = target
    goal.target_pose.header.frame_id = 'map'
    goal.target_pose.header.stamp = rospy.Time.now()

    rospy.loginfo("Going to: " + str(target))

    # 向目标进发
    move_base.send_goal(goal)

    # 五分钟时间限制
    finished_within_time = move_base.wait_for_result(rospy.Duration(300))

    # 查看是否成功到达
    if not finished_within_time:
        move_base.cancel_goal()
        rospy.loginfo("Timed out achieving goal")
    else:
        state = move_base.get_state()
        if state == GoalStatus.SUCCEEDED:
            rospy.loginfo("Goal succeeded!")
        else:
            rospy.loginfo("Goal failed！ ")

# /////////////////////////////////////

# 默认值
rospy.set_param("/task", 0)


target01 = Pose(Point(1.1, -3.46, 0.000),
                Quaternion(0.000, 0.000, -0.9, 0.42))

target02 = Pose(Point(1.71, -11.5, 0.000),
                Quaternion(0.000, 0.000, -0.04, 1.00))

target03 = Pose(Point(5.96, -15.83, 0.000),
                Quaternion(0.000, 0.000, 0.59, 0.81))


# ////////////////////////////////////
while True:
    ai_car_task = rospy.get_param("/task")
    if ai_car_task == 0:
        pass
	#print("0")
    # 任务01
    elif ai_car_task == 1:
#	print("1")
        if task01_flag == False:
            my_send_goal(target01)
            task01_flag = True
            task02_flag = False
            task03_flag = False
        else:
            pass
    # 任务02
    elif ai_car_task == 2:
#	print("2")
        if task02_flag == False:
            my_send_goal(target02)
            task02_flag = True
            task01_flag = False
            task03_flag = False
        else:
            pass
    # 任务03
    elif ai_car_task == 3:
#	print("3")
        if task03_flag == False:
            my_send_goal(target03)
            task03_flag = True
            task02_flag = False
            task01_flag = False
        else:
            pass
