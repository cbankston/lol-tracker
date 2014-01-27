mongoose = require 'mongoose'
Schema = mongoose.Schema

summoner = new Schema
  _id: 'number',
  name: 'string',
  profileIconId: 'number',
  summonerLevel: 'number',
  revisionDate: 'number',
  revisionDateStr: 'string'
  update: 'boolean', default: false
,
  _id: true,
#  use$SetOnSave: false

module.exports = mongoose.model('Summoner', summoner)
