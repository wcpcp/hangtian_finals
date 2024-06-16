#include  "app.h"

int main(int argc, char *argv[])
{
  ros::init(argc, argv, "qingzhou_cloud");
  ros::NodeHandle nh;
  app node(nh);
  node.run();
  return 0;
}

