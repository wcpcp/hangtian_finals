#include "ros/ros.h"
#include <nav_msgs/Path.h>
#include <tf/tf.h>
#include <tf/transform_listener.h>
#include <tf/transform_datatypes.h>
#include<ecl/geometry.hpp>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>




using ecl::CubicSpline;

int path_choose=1;

std::vector<geometry_msgs::Point> gWaypoints[9];
nav_msgs::Path gPath[9];

double end_point_x[9];
double end_point_y[9];

geometry_msgs::PoseStamped path_point[9];

void interpolatePathCubic(const std::vector<geometry_msgs::Point> &waypoints, double density, nav_msgs::Path *path,geometry_msgs::PoseStamped &path_point);


void loadWaypoints(std::string filename, double scale, std::vector<geometry_msgs::Point> *waypoints) {
    FILE *file = fopen(filename.c_str(), "rt");

    double x, y;
    while(fscanf(file, "%lf,%lf", &x, &y) != EOF) {
        geometry_msgs::Point point;

        point.x = scale * x;
        point.y = scale * y;
        point.z = 0;

        waypoints->push_back(point);
    }

    fclose(file);
}

void interpolatePathNaive(const std::vector<geometry_msgs::Point> &waypoints, nav_msgs::Path *path) {
    path->header.frame_id = "map";

    path->poses.clear();
    for(int i = 0; i < waypoints.size(); i++) {
        geometry_msgs::PoseStamped pose;

        pose.header.stamp = ros::Time(0);
        //pose.header.frame_id = "base_link";

        pose.pose.position = waypoints[i];

        pose.pose.orientation.w = 1;
        pose.pose.orientation.x = 0;
        pose.pose.orientation.y = 0;
        pose.pose.orientation.z = 0;

        path->poses.push_back(pose);
    }
}


int main(int argc, char **argv) {
    ros::init(argc, argv, "track_publisher");

    ros::NodeHandle nh;
    ros::NodeHandle npriv("~");

    ros::Publisher path_pub = nh.advertise<nav_msgs::Path>("/path1", 1);  //发布轨迹   不是路径哦
    

    std::string param_waypoints_filename[9];
    double param_scale;
    double param_density;


    tf::TransformListener tf_listener;

    npriv.param<std::string>("waypoints_file0", param_waypoints_filename[0], "");
    npriv.param<std::string>("waypoints_file1", param_waypoints_filename[1], "");
    npriv.param<std::string>("waypoints_file2", param_waypoints_filename[2], "");
    npriv.param<std::string>("waypoints_file3", param_waypoints_filename[3], "");
    npriv.param<std::string>("waypoints_file4", param_waypoints_filename[4], "");
    npriv.param<std::string>("waypoints_file5", param_waypoints_filename[5], "");
    npriv.param<std::string>("waypoints_file6", param_waypoints_filename[6], "");
    npriv.param<std::string>("waypoints_file7", param_waypoints_filename[7], "");
    npriv.param<std::string>("waypoints_file8", param_waypoints_filename[8], "");


    npriv.param<double>("scale", param_scale, 0.001);                                                                                    //scale是轨迹点的真实放大缩小系数
    npriv.param<double>("density", param_density, 0.2);

    for(int i=0;i<9;i++){
        loadWaypoints(param_waypoints_filename[i], param_scale,&gWaypoints[i]);                                  //将轨迹点文件中的点记录到gWaypoints数组中
        interpolatePathCubic(gWaypoints[i], param_density, &gPath[i],path_point[i]);                                                       //得到gPath路径    具体的不是很懂，再看看
        // ROS_INFO("end_point_x = %.2f ",path_point[i].pose.position.x);
    }

    ros::Duration(1.0).sleep();
    try
    {
        geometry_msgs::PoseStamped odom_path_pose;
        for(int i=0;i<9;i++){
            // tf_listener.transformPose("odom", ros::Time(0), path_point[i], "map",odom_path_pose);
            // end_point_x[i] = odom_path_pose.pose.position.x;
            // end_point_y[i] = odom_path_pose.pose.position.y;
            end_point_x[i] = path_point[i].pose.position.x;
            end_point_y[i] = path_point[i].pose.position.y;
            // ROS_INFO("end_point_x = %.2f   end_point_y = %.2f",end_point_x[i],end_point_y[i]);
        }
        // printf("%.2f",end_point_x);
    }
    catch (tf::TransformException &ex)
    {
        ROS_ERROR("%s", ex.what());
        ros::Duration(1.0).sleep();
    }

    int pub_goal_mode;
    ros::Rate loop_rate(20.0);     


    ros::param::set("end_point_x0",end_point_x[0]);
    ros::param::set("end_point_y0",end_point_y[0]);

    ros::param::set("end_point_x1",end_point_x[1]);
    ros::param::set("end_point_y1",end_point_y[1]);

    ros::param::set("end_point_x2",end_point_x[2]);
    ros::param::set("end_point_y2",end_point_y[2]);

    ros::param::set("end_point_x3",end_point_x[3]);
    ros::param::set("end_point_y3",end_point_y[3]);

    ros::param::set("end_point_x4",end_point_x[4]);
    ros::param::set("end_point_y4",end_point_y[4]);

    ros::param::set("end_point_x5",end_point_x[5]);
    ros::param::set("end_point_y5",end_point_y[5]);

    ros::param::set("end_point_x6",end_point_x[6]);
    ros::param::set("end_point_y6",end_point_y[6]);

    ros::param::set("end_point_x7",end_point_x[7]);
    ros::param::set("end_point_y7",end_point_y[7]);

    ros::param::set("end_point_x8",end_point_x[8]);
    ros::param::set("end_point_y8",end_point_y[8]);


    while (ros::ok()) {
        ros::param::get("/task", path_choose);
        ROS_INFO("path_choose = %d",path_choose);

        ros::param::set("end_point_x",end_point_x[path_choose]);
        ros::param::set("end_point_y",end_point_y[path_choose]);
        // ROS_INFO("end_point_x = %.2f   end_point_y = %.2f",end_point_x[path_choose],end_point_y[path_choose]);
        path_pub.publish(gPath[path_choose]);
        
        loop_rate.sleep();
        ros::spinOnce();
    }

    return 0;
}



void interpolatePathCubic(const std::vector<geometry_msgs::Point> &waypoints, double density, nav_msgs::Path *path,geometry_msgs::PoseStamped &path_point) {
    int size=0;
    int num_waypoints = waypoints.size();

    //create x and y splines
    static ecl::Array<double> x_list, y_list, t_list;
    x_list.resize(num_waypoints);
    y_list.resize(num_waypoints);
    t_list.resize(num_waypoints);

    double t = 0;
    for(int i = 0; i < num_waypoints; i++) {
        x_list[i] = waypoints[i].x;
        y_list[i] = waypoints[i].y;
        t_list[i] = t;

        t += 1;
    }

    CubicSpline spline_x = CubicSpline::Natural(t_list, x_list);
    CubicSpline spline_y = CubicSpline::Natural(t_list, y_list);

    //generate path
    path->header.stamp = ros::Time(0);
    path->header.frame_id = "map";

    path->poses.clear();

    //for every segment of spline
    ecl::Array<ecl::CubicPolynomial> segments_x = spline_x.polynomials();
    ecl::Array<ecl::CubicPolynomial> segments_y = spline_y.polynomials();

    double gauss_quadrature_coeff[5][2] = {
        {  0.0,                0.5688888888888889 },
        { -0.5384693101056831, 0.47862867049936647 },
        {  0.5384693101056831, 0.47862867049936647 },
        { -0.906179845938664,  0.23692688505618908 },
        {  0.906179845938664,  0.23692688505618908 }
    };

    double last_remain_len = 0.0;
    for(int i = 0; i < segments_x.size(); i++) {
        //intergrate arc length using gauss quadraute
        double arc_len = 0;
        for(int k = 0; k < 5; k++) {
            double x = i + ((gauss_quadrature_coeff[k][0] + 1) / 2);
            double A_x = segments_x[i].coefficients()[1] + 2 * segments_x[i].coefficients()[2] * x + 3 * segments_x[i].coefficients()[3] * x * x;
            double B_x = segments_y[i].coefficients()[1] + 2 * segments_y[i].coefficients()[2] * x + 3 * segments_y[i].coefficients()[3] * x * x;
            double F_x = std::sqrt( A_x * A_x + B_x * B_x
             );

            arc_len += gauss_quadrature_coeff[k][1] * F_x;
        }
        arc_len /= 2;

        /*printf("x: %lf ", segments_x[i](0 + i));
        printf("y: %lf ", segments_x[i](0 + i));
        printf("len: %lf\n", arc_len);*/

        //calculate points on segment
        double delta = density / arc_len;
        double v_t;
        for(v_t = (density - last_remain_len) / arc_len; v_t < 1; v_t += delta) {
            geometry_msgs::PoseStamped pose;

            pose.header.stamp = ros::Time(0);
            pose.header.frame_id = "map";

            pose.pose.position.x = segments_x[i](i + v_t);
            pose.pose.position.y = segments_y[i](i + v_t);
            pose.pose.position.z = 0;

            tf::Quaternion q;
            q.setRPY(0, 0, atan2(segments_y[i].derivative(i + v_t), segments_x[i].derivative(i + v_t)));
            tf::quaternionTFToMsg(q, pose.pose.orientation);

            path->poses.push_back(pose);
            size++;
        }

        v_t -= delta;
        last_remain_len = (1 - v_t) * arc_len;
    }

    path_point = path->poses[size-1];
}








// #include "ros/ros.h"
// #include <nav_msgs/Path.h>
// #include <tf/tf.h>
// #include <tf/transform_listener.h>
// #include <tf/transform_datatypes.h>
// #include<ecl/geometry.hpp>
// #include <stdio.h>
// #include <stdlib.h>
// #include <iostream>




// using ecl::CubicSpline;

// int path_choose=1;

// std::vector<geometry_msgs::Point> gWaypoints[9];
// nav_msgs::Path gPath[9];

// double end_point_x[9];
// double end_point_y[9];

// geometry_msgs::PoseStamped path_point[9];

// void interpolatePathCubic(const std::vector<geometry_msgs::Point> &waypoints, double density, nav_msgs::Path *path,geometry_msgs::PoseStamped &path_point);


// void loadWaypoints(std::string filename, double scale, std::vector<geometry_msgs::Point> *waypoints) {
//     FILE *file = fopen(filename.c_str(), "rt");

//     double x, y;
//     while(fscanf(file, "%lf,%lf", &x, &y) != EOF) {
//         geometry_msgs::Point point;

//         point.x = scale * x;
//         point.y = scale * y;
//         point.z = 0;

//         waypoints->push_back(point);
//     }

//     fclose(file);
// }

// void interpolatePathNaive(const std::vector<geometry_msgs::Point> &waypoints, nav_msgs::Path *path) {
//     path->header.frame_id = "map";

//     path->poses.clear();
//     for(int i = 0; i < waypoints.size(); i++) {
//         geometry_msgs::PoseStamped pose;

//         pose.header.stamp = ros::Time(0);
//         //pose.header.frame_id = "base_link";

//         pose.pose.position = waypoints[i];

//         pose.pose.orientation.w = 1;
//         pose.pose.orientation.x = 0;
//         pose.pose.orientation.y = 0;
//         pose.pose.orientation.z = 0;

//         path->poses.push_back(pose);
//     }
// }


// int main(int argc, char **argv) {
//     ros::init(argc, argv, "track_publisher");

//     ros::NodeHandle nh;
//     ros::NodeHandle npriv("~");

//     // ros::Publisher path_pub = nh.advertise<nav_msgs::Path>("/move_base/GlobalPlanner/plan", 1);  //发布轨迹   不是路径哦
//     ros::Publisher path_pub = nh.advertise<nav_msgs::Path>("/path1", 1);  //发布轨迹   不是路径哦
//     // ros::Publisher goal_pub = nh.advertise<geometry_msgs::PoseStamped>("/move_base_simple/goal", 1);  //发布轨迹   不是路径哦
    

//     std::string param_waypoints_filename[9];
//     double param_scale;
//     double param_density;


//     tf::TransformListener tf_listener;

//     npriv.param<std::string>("waypoints_file0", param_waypoints_filename[0], "");
//     npriv.param<std::string>("waypoints_file1", param_waypoints_filename[1], "");
//     npriv.param<std::string>("waypoints_file2", param_waypoints_filename[2], "");
//     npriv.param<std::string>("waypoints_file3", param_waypoints_filename[3], "");
//     npriv.param<std::string>("waypoints_file4", param_waypoints_filename[4], "");
//     npriv.param<std::string>("waypoints_file5", param_waypoints_filename[5], "");
//     npriv.param<std::string>("waypoints_file6", param_waypoints_filename[6], "");
//     npriv.param<std::string>("waypoints_file7", param_waypoints_filename[7], "");
//     npriv.param<std::string>("waypoints_file8", param_waypoints_filename[8], "");


//     npriv.param<double>("scale", param_scale, 0.001);                                                                                    //scale是轨迹点的真实放大缩小系数
//     npriv.param<double>("density", param_density, 0.2);

//     for(int i=0;i<9;i++){
//         loadWaypoints(param_waypoints_filename[i], param_scale,&gWaypoints[i]);                                  //将轨迹点文件中的点记录到gWaypoints数组中
//         interpolatePathCubic(gWaypoints[i], param_density, &gPath[i],path_point[i]);                                                       //得到gPath路径    具体的不是很懂，再看看
//         // ROS_INFO("end_point_x = %.2f ",path_point[i].pose.position.x);
//     }

//     ros::Duration(1.0).sleep();
//     try
//     {
//         geometry_msgs::PoseStamped odom_path_pose;
//         for(int i=0;i<9;i++){
//             // tf_listener.transformPose("odom", ros::Time(0), path_point[i], "map",odom_path_pose);
//             // end_point_x[i] = odom_path_pose.pose.position.x;
//             // end_point_y[i] = odom_path_pose.pose.position.y;
//             end_point_x[i] = path_point[i].pose.position.x;
//             end_point_y[i] = path_point[i].pose.position.y;
//             ROS_INFO("end_point_x = %.2f   end_point_y = %.2f",end_point_x[i],end_point_y[i]);
//         }
//         // printf("%.2f",end_point_x);
//     }
//     catch (tf::TransformException &ex)
//     {
//         ROS_ERROR("%s", ex.what());
//         ros::Duration(1.0).sleep();
//     }

//     int pub_goal_mode;
//     ros::Rate loop_rate(20.0);     


//     while (ros::ok()) {
//         ros::param::get("/task", path_choose);
//         ROS_INFO("path_choose = %d",path_choose);

//         ros::param::set("end_point_x",end_point_x[path_choose]);
//         ros::param::set("end_point_y",end_point_y[path_choose]);
//         ROS_INFO("end_point_x = %.2f   end_point_y = %.2f",end_point_x[path_choose],end_point_y[path_choose]);
//         path_pub.publish(gPath[path_choose]);
        
//         loop_rate.sleep();
//         ros::spinOnce();
//     }

//     return 0;
// }



// void interpolatePathCubic(const std::vector<geometry_msgs::Point> &waypoints, double density, nav_msgs::Path *path,geometry_msgs::PoseStamped &path_point) {
//     int size=0;
//     int num_waypoints = waypoints.size();

//     //create x and y splines
//     static ecl::Array<double> x_list, y_list, t_list;
//     x_list.resize(num_waypoints);
//     y_list.resize(num_waypoints);
//     t_list.resize(num_waypoints);

//     double t = 0;
//     for(int i = 0; i < num_waypoints; i++) {
//         x_list[i] = waypoints[i].x;
//         y_list[i] = waypoints[i].y;
//         t_list[i] = t;

//         t += 1;
//     }

//     CubicSpline spline_x = CubicSpline::Natural(t_list, x_list);
//     CubicSpline spline_y = CubicSpline::Natural(t_list, y_list);

//     //generate path
//     path->header.stamp = ros::Time(0);
//     path->header.frame_id = "map";

//     path->poses.clear();

//     //for every segment of spline
//     ecl::Array<ecl::CubicPolynomial> segments_x = spline_x.polynomials();
//     ecl::Array<ecl::CubicPolynomial> segments_y = spline_y.polynomials();

//     double gauss_quadrature_coeff[5][2] = {
//         {  0.0,                0.5688888888888889 },
//         { -0.5384693101056831, 0.47862867049936647 },
//         {  0.5384693101056831, 0.47862867049936647 },
//         { -0.906179845938664,  0.23692688505618908 },
//         {  0.906179845938664,  0.23692688505618908 }
//     };

//     double last_remain_len = 0.0;
//     for(int i = 0; i < segments_x.size(); i++) {
//         //intergrate arc length using gauss quadraute
//         double arc_len = 0;
//         for(int k = 0; k < 5; k++) {
//             double x = i + ((gauss_quadrature_coeff[k][0] + 1) / 2);
//             double A_x = segments_x[i].coefficients()[1] + 2 * segments_x[i].coefficients()[2] * x + 3 * segments_x[i].coefficients()[3] * x * x;
//             double B_x = segments_y[i].coefficients()[1] + 2 * segments_y[i].coefficients()[2] * x + 3 * segments_y[i].coefficients()[3] * x * x;
//             double F_x = std::sqrt( A_x * A_x + B_x * B_x
//              );

//             arc_len += gauss_quadrature_coeff[k][1] * F_x;
//         }
//         arc_len /= 2;

//         /*printf("x: %lf ", segments_x[i](0 + i));
//         printf("y: %lf ", segments_x[i](0 + i));
//         printf("len: %lf\n", arc_len);*/

//         //calculate points on segment
//         double delta = density / arc_len;
//         double v_t;
//         for(v_t = (density - last_remain_len) / arc_len; v_t < 1; v_t += delta) {
//             geometry_msgs::PoseStamped pose;

//             pose.header.stamp = ros::Time(0);
//             pose.header.frame_id = "map";

//             pose.pose.position.x = segments_x[i](i + v_t);
//             pose.pose.position.y = segments_y[i](i + v_t);
//             pose.pose.position.z = 0;

//             tf::Quaternion q;
//             q.setRPY(0, 0, atan2(segments_y[i].derivative(i + v_t), segments_x[i].derivative(i + v_t)));
//             tf::quaternionTFToMsg(q, pose.pose.orientation);

//             path->poses.push_back(pose);
//             size++;
//         }

//         v_t -= delta;
//         last_remain_len = (1 - v_t) * arc_len;
//     }

//     path_point = path->poses[size-1];
// }