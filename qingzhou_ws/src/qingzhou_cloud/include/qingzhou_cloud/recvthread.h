/*************************************************************************
	> File Name: recvthread.h
	> Author: 
	> Mail: 
	> Created Time: 2017年02月28日 星期二 16时11分56秒
 ************************************************************************/

#ifndef _RECVTHREAD_H
#define _RECVTHREAD_H


#include <vector>
#include <iostream>
#include <string>
#include <sstream>
#include <boost/assert.hpp>
#include <stdlib.h>
#include <stdio.h>
#include <boost/asio.hpp>
#include <boost/thread//thread.hpp>
#include <boost//assert.hpp>
#include <math.h>
#include <string>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <boost/date_time.hpp>
// ROS lib
#include "ros/ros.h"
#include "ros/time.h"
#include "app.h"
//other lib
#include "pthread.h"
#include "app.h"
#include "sendthread.h"

#define MAX_RECV_SOCKET_SIZE 20000

using namespace std;

typedef struct{
    char head[4];
    int len;
    unsigned char command;
    char para[0];
}__attribute__((packed)) recv_frame_t;

typedef struct{
    char head[4];
    int len;
    char command;
    char para[0];
}__attribute__((packed)) send_frame_t;

class recvthread{
public:
    recvthread();
    ~recvthread();

};
#endif
