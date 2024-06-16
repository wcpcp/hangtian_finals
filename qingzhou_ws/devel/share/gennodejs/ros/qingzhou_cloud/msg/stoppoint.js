// Auto-generated. Do not edit!

// (in-package qingzhou_cloud.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class stoppoint {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.X = null;
      this.Y = null;
      this.updownstatus = null;
      this.startCommand = null;
    }
    else {
      if (initObj.hasOwnProperty('X')) {
        this.X = initObj.X
      }
      else {
        this.X = 0.0;
      }
      if (initObj.hasOwnProperty('Y')) {
        this.Y = initObj.Y
      }
      else {
        this.Y = 0.0;
      }
      if (initObj.hasOwnProperty('updownstatus')) {
        this.updownstatus = initObj.updownstatus
      }
      else {
        this.updownstatus = 0;
      }
      if (initObj.hasOwnProperty('startCommand')) {
        this.startCommand = initObj.startCommand
      }
      else {
        this.startCommand = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type stoppoint
    // Serialize message field [X]
    bufferOffset = _serializer.float32(obj.X, buffer, bufferOffset);
    // Serialize message field [Y]
    bufferOffset = _serializer.float32(obj.Y, buffer, bufferOffset);
    // Serialize message field [updownstatus]
    bufferOffset = _serializer.uint8(obj.updownstatus, buffer, bufferOffset);
    // Serialize message field [startCommand]
    bufferOffset = _serializer.uint8(obj.startCommand, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type stoppoint
    let len;
    let data = new stoppoint(null);
    // Deserialize message field [X]
    data.X = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [Y]
    data.Y = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [updownstatus]
    data.updownstatus = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [startCommand]
    data.startCommand = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 10;
  }

  static datatype() {
    // Returns string type for a message object
    return 'qingzhou_cloud/stoppoint';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '66100b3bfca7763e0a4f3b7884b40cac';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 X
    float32 Y
    uint8 updownstatus
    uint8 startCommand
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new stoppoint(null);
    if (msg.X !== undefined) {
      resolved.X = msg.X;
    }
    else {
      resolved.X = 0.0
    }

    if (msg.Y !== undefined) {
      resolved.Y = msg.Y;
    }
    else {
      resolved.Y = 0.0
    }

    if (msg.updownstatus !== undefined) {
      resolved.updownstatus = msg.updownstatus;
    }
    else {
      resolved.updownstatus = 0
    }

    if (msg.startCommand !== undefined) {
      resolved.startCommand = msg.startCommand;
    }
    else {
      resolved.startCommand = 0
    }

    return resolved;
    }
};

module.exports = stoppoint;
