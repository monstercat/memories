
mongoose = require 'mongoose'

Schema   = mongoose.Schema

CodeSchema = new Schema
  code: String
, collection: "Code"

module.exports = mongoose.model 'Code', CodeSchema
