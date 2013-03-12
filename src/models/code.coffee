
mongoose = require 'mongoose'

Schema   = mongoose.Schema

CodeSchema = new Schema
  code: String
  redeemed:
    type: Boolean
, collection: "Code"

module.exports = mongoose.model 'Code', CodeSchema
