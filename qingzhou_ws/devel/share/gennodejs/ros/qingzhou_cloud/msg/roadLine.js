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

class roadLine {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lineX = null;
      this.lineY = null;
      this.lineStatus = null;
    }
    else {
      if (initObj.hasOwnProperty('lineX')) {
        this.lineX = initObj.lineX
      }
      else {
        this.lineX = [];
      }
      if (initObj.hasOwnProperty('lineY')) {
        this.lineY = initObj.lineY
      }
      else {
        this.lineY = [];
      }
      if (initObj.hasOwnProperty('lineStatus')) {
        this.lineStatus = initObj.lineStatus
      }
      else {
        this.lineStatus = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type roadLine
    // Serialize message field [lineX]
    bufferOffset = _arraySerializer.float32(obj.lineX, buffer, bufferOffset, null);
    // Serialize message field [lineY]
    bufferOffset = _arraySerializer.float32(obj.lineY, buffer, bufferOffset, null);
    // Serialize message field [lineStatus]
    bufferOffset = _serializer.uint8(obj.lineStatus, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type roadLine
    let len;
    let data = new roadLine(null);
    // Deserialize message field [lineX]
    data.lineX = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [lineY]
    data.lineY = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [lineStatus]
    data.lineStatus = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.lineX.length;
    length += 4 * object.lineY.length;
    return length + 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'qingzhou_cloud/roadLine';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '979b1a9d0eae9e69bcac1c5b8eb2ff08';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32[] lineX
    float32[] lineY
    uint8 lineStatus
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new roadLine(null);
    if (msg.lineX !== undefined) {
      resolved.lineX = msg.lineX;
    }
    else {
      resolved.lineX = []
    }

    if (msg.lineY !== undefined) {
      resolved.lineY = msg.lineY;
    }
    else {
      resolved.lineY = []
    }

    if (msg.lineStatus !== undefined) {
      resolved.lineStatus = msg.lineStatus;
    }
    else {
      resolved.lineStatus = 0
    }

    return resolved;
    }
};

module.exports = roadLine;
