
mongoose = require 'mongoose'

Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

MemorySchema = new Schema
  email:
    type: String
  memory:
    type: String
    required: yes
  name:
    type: String
    required: yes
, collection: "Memory"

Memory = mongoose.model 'Memory', MemorySchema

module.exports = Memory
