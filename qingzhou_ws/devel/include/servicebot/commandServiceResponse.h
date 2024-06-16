// Generated by gencpp from file servicebot/commandServiceResponse.msg
// DO NOT EDIT!


#ifndef SERVICEBOT_MESSAGE_COMMANDSERVICERESPONSE_H
#define SERVICEBOT_MESSAGE_COMMANDSERVICERESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace servicebot
{
template <class ContainerAllocator>
struct commandServiceResponse_
{
  typedef commandServiceResponse_<ContainerAllocator> Type;

  commandServiceResponse_()
    : resp()  {
    }
  commandServiceResponse_(const ContainerAllocator& _alloc)
    : resp(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _resp_type;
  _resp_type resp;





  typedef boost::shared_ptr< ::servicebot::commandServiceResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::servicebot::commandServiceResponse_<ContainerAllocator> const> ConstPtr;

}; // struct commandServiceResponse_

typedef ::servicebot::commandServiceResponse_<std::allocator<void> > commandServiceResponse;

typedef boost::shared_ptr< ::servicebot::commandServiceResponse > commandServiceResponsePtr;
typedef boost::shared_ptr< ::servicebot::commandServiceResponse const> commandServiceResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::servicebot::commandServiceResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::servicebot::commandServiceResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::servicebot::commandServiceResponse_<ContainerAllocator1> & lhs, const ::servicebot::commandServiceResponse_<ContainerAllocator2> & rhs)
{
  return lhs.resp == rhs.resp;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::servicebot::commandServiceResponse_<ContainerAllocator1> & lhs, const ::servicebot::commandServiceResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace servicebot

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::servicebot::commandServiceResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::servicebot::commandServiceResponse_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::servicebot::commandServiceResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::servicebot::commandServiceResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::servicebot::commandServiceResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::servicebot::commandServiceResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::servicebot::commandServiceResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "b791c1a4a4f0cee32b54dd1a73706a59";
  }

  static const char* value(const ::servicebot::commandServiceResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xb791c1a4a4f0cee3ULL;
  static const uint64_t static_value2 = 0x2b54dd1a73706a59ULL;
};

template<class ContainerAllocator>
struct DataType< ::servicebot::commandServiceResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "servicebot/commandServiceResponse";
  }

  static const char* value(const ::servicebot::commandServiceResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::servicebot::commandServiceResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string resp\n"
"\n"
;
  }

  static const char* value(const ::servicebot::commandServiceResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::servicebot::commandServiceResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.resp);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct commandServiceResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::servicebot::commandServiceResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::servicebot::commandServiceResponse_<ContainerAllocator>& v)
  {
    s << indent << "resp: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.resp);
  }
};

} // namespace message_operations
} // namespace ros

#endif // SERVICEBOT_MESSAGE_COMMANDSERVICERESPONSE_H
