// Generated by gencpp from file qingzhou_cloud/current_location.msg
// DO NOT EDIT!


#ifndef QINGZHOU_CLOUD_MESSAGE_CURRENT_LOCATION_H
#define QINGZHOU_CLOUD_MESSAGE_CURRENT_LOCATION_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace qingzhou_cloud
{
template <class ContainerAllocator>
struct current_location_
{
  typedef current_location_<ContainerAllocator> Type;

  current_location_()
    : x(0.0)
    , y(0.0)
    , heading(0.0)  {
    }
  current_location_(const ContainerAllocator& _alloc)
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





  typedef boost::shared_ptr< ::qingzhou_cloud::current_location_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::qingzhou_cloud::current_location_<ContainerAllocator> const> ConstPtr;

}; // struct current_location_

typedef ::qingzhou_cloud::current_location_<std::allocator<void> > current_location;

typedef boost::shared_ptr< ::qingzhou_cloud::current_location > current_locationPtr;
typedef boost::shared_ptr< ::qingzhou_cloud::current_location const> current_locationConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::qingzhou_cloud::current_location_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::qingzhou_cloud::current_location_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::qingzhou_cloud::current_location_<ContainerAllocator1> & lhs, const ::qingzhou_cloud::current_location_<ContainerAllocator2> & rhs)
{
  return lhs.x == rhs.x &&
    lhs.y == rhs.y &&
    lhs.heading == rhs.heading;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::qingzhou_cloud::current_location_<ContainerAllocator1> & lhs, const ::qingzhou_cloud::current_location_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace qingzhou_cloud

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::qingzhou_cloud::current_location_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::qingzhou_cloud::current_location_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::qingzhou_cloud::current_location_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::qingzhou_cloud::current_location_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::qingzhou_cloud::current_location_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::qingzhou_cloud::current_location_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::qingzhou_cloud::current_location_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bc1dd36b5547fef69e6daa06ae2e13ac";
  }

  static const char* value(const ::qingzhou_cloud::current_location_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xbc1dd36b5547fef6ULL;
  static const uint64_t static_value2 = 0x9e6daa06ae2e13acULL;
};

template<class ContainerAllocator>
struct DataType< ::qingzhou_cloud::current_location_<ContainerAllocator> >
{
  static const char* value()
  {
    return "qingzhou_cloud/current_location";
  }

  static const char* value(const ::qingzhou_cloud::current_location_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::qingzhou_cloud::current_location_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float64 x\n"
"float64 y\n"
"float64 heading\n"
;
  }

  static const char* value(const ::qingzhou_cloud::current_location_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::qingzhou_cloud::current_location_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.x);
      stream.next(m.y);
      stream.next(m.heading);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct current_location_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::qingzhou_cloud::current_location_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::qingzhou_cloud::current_location_<ContainerAllocator>& v)
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

#endif // QINGZHOU_CLOUD_MESSAGE_CURRENT_LOCATION_H