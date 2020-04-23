// Auto-generated. Do not edit!

// (in-package joh_gap_finding.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class gaps {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.numOfGaps = null;
      this.width = null;
    }
    else {
      if (initObj.hasOwnProperty('numOfGaps')) {
        this.numOfGaps = initObj.numOfGaps
      }
      else {
        this.numOfGaps = 0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gaps
    // Serialize message field [numOfGaps]
    bufferOffset = _serializer.int32(obj.numOfGaps, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.float32(obj.width, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gaps
    let len;
    let data = new gaps(null);
    // Deserialize message field [numOfGaps]
    data.numOfGaps = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'joh_gap_finding/gaps';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7907d1a64f5c611284b7ec1a5e86c172';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 numOfGaps
    float32 width
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new gaps(null);
    if (msg.numOfGaps !== undefined) {
      resolved.numOfGaps = msg.numOfGaps;
    }
    else {
      resolved.numOfGaps = 0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0.0
    }

    return resolved;
    }
};

module.exports = gaps;
