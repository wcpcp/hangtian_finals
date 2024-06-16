#include "PurePursuit.h"

int main(int argc, char **argv)
{
   ros::init(argc, argv, "pure_pursuit_node");

   ROS_INFO("[%s] Node initialization.", ros::this_node::getName().data());

   if (!ros::master::check())
   {
      ROS_ERROR("[%s] Roscore is not running.", ros::this_node::getName().data());
      return EXIT_FAILURE;
   }

   ros::NodeHandle n("~");
   PPControl controller(n);
   controller.spin();

   ROS_INFO("[%s] Node finished.", ros::this_node::getName().data());

   return EXIT_SUCCESS;
}