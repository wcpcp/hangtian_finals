// Generated by gencpp from file move_base_msgs/hglocation.msg
// DO NOT EDIT!


#ifndef MOVE_BASE_MSGS_MESSAGE_HGLOCATION_H
#define MOVE_BASE_MSGS_MESSAGE_HGLOCATION_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace move_base_msgs
{
template <class ContainerAllocator>
struct hglocation_
{
  typedef hglocation_<ContainerAllocator> Type;

  hglocation_()
    : x(0.0)
    , y(0.0)
    , heading(0.0)  {
    }
  hglocation_(const ContainerAllocator& _alloc)
    : x(0.0)
    , y(0.0)
    , heading(0.0)  {
  (void)_alloc;
    }



   typedef double _x_type;
  _x_type x;

   typedef double _y_type;
  _y_type y;

   typedef double _heading_type;
  _heading_type heading;





  typedef boost::shared_ptr< ::move_base_msgs::hglocation_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::move_base_msgs::hglocation_<ContainerAllocator> const> ConstPtr;

}; // struct hglocation_

typedef ::move_base_msgs::hglocation_<std::allocator<void> > hglocation;

typedef boost::shared_ptr< ::move_base_msgs::hglocation > hglocationPtr;
typedef boost::shared_ptr< ::move_base_msgs::hglocation const> hglocationConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::move_base_msgs::hglocation_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::move_base_msgs::hglocation_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::move_base_msgs::hglocation_<ContainerAllocator1> & lhs, const ::move_base_msgs::hglocation_<ContainerAllocator2> & rhs)
{
  return lhs.x == rhs.x &&
    lhs.y == rhs.y &&
    lhs.heading == rhs.heading;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::move_base_msgs::hglocation_<ContainerAllocator1> & lhs, const ::move_base_msgs::hglocation_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace move_base_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::move_base_msgs::hglocation_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::move_base_msgs::hglocation_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::move_base_msgs::hglocation_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::move_base_msgs::hglocation_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::move_base_msgs::hglocation_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::move_base_msgs::hglocation_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::move_base_msgs::hglocation_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bc1dd36b5547fef69e6daa06ae2e13ac";
  }

  static const char* value(const ::move_base_msgs::hglocation_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xbc1dd36b5547fef6ULL;
  static const uint64_t static_value2 = 0x9e6daa06ae2e13acULL;
};

template<class ContainerAllocator>
struct DataType< ::move_base_msgs::hglocation_<ContainerAllocator> >
{
  static const char* value()
  {
    return "move_base_msgs/hglocation";
  }

  static const char* value(const ::move_base_msgs::hglocation_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::move_base_msgs::hglocation_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float64 x\n"
"float64 y\n"
"float64 heading\n"
;
  }

  static const char* value(const ::move_base_msgs::hglocation_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::move_base_msgs::hglocation_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.x);
      stream.next(m.y);
      stream.next(m.heading);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct hglocation_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::move_base_msgs::hglocation_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::move_base_msgs::hglocation_<ContainerAllocator>& v)
  {
    s << indent << "x: ";
    Printer<double>::stream(s, indent + "  ", v.x);
    s << indent << "y: ";
    Printer<double>::stream(s, indent + "  ", v.y);
    s << indent << "heading: ";
    Printer<double>::stream(s, indent + "  ", v.heading);
  }
};

} // namespace message_operations
} // namespace ros

#endif // MOVE_BASE_MSGS_MESSAGE_HGLOCATION_H
