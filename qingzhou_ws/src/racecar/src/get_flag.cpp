#include<ros/ros.h>
bool flag;
int main(int argc, char  *argv[])
{
    ros::init(argc,argv,"haha");
    ros::NodeHandle nh("turtlesim");

    nh.param("path_choose",flag,false);
    ROS_INFO("%d_________",flag);

    ros::param::set("/path_choose",true);
    ros::Duration(5).sleep();
    system("rosnode kill track_publisher");
    // nh.setParam("path_choose",true)
    // nh.param("path_choose",flag,false);
    // ROS_INFO("%d_________",flag);
    return 0;
}
