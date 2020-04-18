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
    }
    else {
      if (initObj.hasOwnProperty('numOfGaps')) {
        this.numOfGaps = initObj.numOfGaps
      }
      else {
        this.numOfGaps = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gaps
    // Serialize message field [numOfGaps]
    bufferOffset = _serializer.int32(obj.numOfGaps, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gaps
    let len;
    let data = new gaps(null);
    // Deserialize message field [numOfGaps]
    data.numOfGaps = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'joh_gap_finding/gaps';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '80967cdca74685dc952c88f8276188b1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 numOfGaps
    
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

    return resolved;
    }
};

module.exports = gaps;
