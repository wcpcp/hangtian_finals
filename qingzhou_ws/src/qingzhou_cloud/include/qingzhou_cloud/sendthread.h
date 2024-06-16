/*************************************************************************
	> File Name: sendthread.h
	> Author: 
	> Mail: 
	> Created Time: 2017年02月28日 星期二 16时12分18秒
 ************************************************************************/

#ifndef _SENDTHREAD_H
#define _SENDTHREAD_H


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
//other lib
#include "pthread.h"
#include "app.h"


using namespace std;

class sendthread
{
public:
  //! Constructor.
  sendthread();
  ~sendthread();
private:



};

#endif
