mongoose = require 'mongoose'
Schema = mongoose.Schema

item = new Schema
  _id: 'number',
  name: 'string',
  group: 'string',
  description: 'string',
  colloq: 'string',
  plaintext: 'string',
  from: 'array',
  into: 'array',
  image: 'string',
  gold: Schema.Types.Mixed
  tags: 'array',
  maps: Schema.Types.Mixed
  stats: Schema.Types.Mixed
  depth: 'number'
,
  _id: true,
#  use$SetOnSave: false

module.exports = mongoose.model('Item', item)
