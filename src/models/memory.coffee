
mongoose = require 'mongoose'

Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

MemorySchema = new Schema
  email:
    type: String
    required: yes
  name:
    type: String
    required: yes
, collection: "memory"

Memory = mongoose.model 'Memory', MemorySchema

module.exports = Memory
