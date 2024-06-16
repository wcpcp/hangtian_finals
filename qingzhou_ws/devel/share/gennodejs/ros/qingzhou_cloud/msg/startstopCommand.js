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

class startstopCommand {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.startstopcommand = null;
    }
    else {
      if (initObj.hasOwnProperty('startstopcommand')) {
        this.startstopcommand = initObj.startstopcommand
      }
      else {
        this.startstopcommand = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type startstopCommand
    // Serialize message field [startstopcommand]
    bufferOffset = _serializer.uint8(obj.startstopcommand, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type startstopCommand
    let len;
    let data = new startstopCommand(null);
    // Deserialize message field [startstopcommand]
    data.startstopcommand = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a message object
    return 'qingzhou_cloud/startstopCommand';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4aaa2a9c02b5667fbf5717c1c2e38c8e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 startstopcommand
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new startstopCommand(null);
    if (msg.startstopcommand !== undefined) {
      resolved.startstopcommand = msg.startstopcommand;
    }
    else {
      resolved.startstopcommand = 0
    }

    return resolved;
    }
};

module.exports = startstopCommand;
