// Auto-generated. Do not edit!

// (in-package move_base_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let pathpoint = require('./pathpoint.js');

//-----------------------------------------------------------

class hgpathplanner {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.currentroad = null;
      this.hsize = null;
      this.vsize = null;
      this.cellsize = null;
      this.source = null;
      this.points = null;
    }
    else {
      if (initObj.hasOwnProperty('currentroad')) {
        this.currentroad = initObj.currentroad
      }
      else {
        this.currentroad = 0;
      }
      if (initObj.hasOwnProperty('hsize')) {
        this.hsize = initObj.hsize
      }
      else {
        this.hsize = 0;
      }
      if (initObj.hasOwnProperty('vsize')) {
        this.vsize = initObj.vsize
      }
      else {
        this.vsize = 0;
      }
      if (initObj.hasOwnProperty('cellsize')) {
        this.cellsize = initObj.cellsize
      }
      else {
        this.cellsize = 0.0;
      }
      if (initObj.hasOwnProperty('source')) {
        this.source = initObj.source
      }
      else {
        this.source = 0;
      }
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type hgpathplanner
    // Serialize message field [currentroad]
    bufferOffset = _serializer.uint8(obj.currentroad, buffer, bufferOffset);
    // Serialize message field [hsize]
    bufferOffset = _serializer.uint8(obj.hsize, buffer, bufferOffset);
    // Serialize message field [vsize]
    bufferOffset = _serializer.uint8(obj.vsize, buffer, bufferOffset);
    // Serialize message field [cellsize]
    bufferOffset = _serializer.float32(obj.cellsize, buffer, bufferOffset);
    // Serialize message field [source]
    bufferOffset = _serializer.uint8(obj.source, buffer, bufferOffset);
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = pathpoint.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type hgpathplanner
    let len;
    let data = new hgpathplanner(null);
    // Deserialize message field [currentroad]
    data.currentroad = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [hsize]
    data.hsize = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [vsize]
    data.vsize = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [cellsize]
    data.cellsize = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [source]
    data.source = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [points]
    // Deserialize array length for message field [points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points[i] = pathpoint.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 26 * object.points.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'move_base_msgs/hgpathplanner';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'aac1ecdd9fd50037e6e79455d05d1e5b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 currentroad
    uint8 hsize
    uint8 vsize
    float32 cellsize
    uint8 source
    pathpoint[] points
    
    ================================================================================
    MSG: move_base_msgs/pathpoint
    float64 x
    float64 y
    uint8 value
    int8 u
    float64 heading
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new hgpathplanner(null);
    if (msg.currentroad !== undefined) {
      resolved.currentroad = msg.currentroad;
    }
    else {
      resolved.currentroad = 0
    }

    if (msg.hsize !== undefined) {
      resolved.hsize = msg.hsize;
    }
    else {
      resolved.hsize = 0
    }

    if (msg.vsize !== undefined) {
      resolved.vsize = msg.vsize;
    }
    else {
      resolved.vsize = 0
    }

    if (msg.cellsize !== undefined) {
      resolved.cellsize = msg.cellsize;
    }
    else {
      resolved.cellsize = 0.0
    }

    if (msg.source !== undefined) {
      resolved.source = msg.source;
    }
    else {
      resolved.source = 0
    }

    if (msg.points !== undefined) {
      resolved.points = new Array(msg.points.length);
      for (let i = 0; i < resolved.points.length; ++i) {
        resolved.points[i] = pathpoint.Resolve(msg.points[i]);
      }
    }
    else {
      resolved.points = []
    }

    return resolved;
    }
};

module.exports = hgpathplanner;
