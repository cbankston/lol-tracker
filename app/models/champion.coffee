mongoose = require 'mongoose'
Schema = mongoose.Schema

champion = new Schema
  _id: 'number',
  botMmEnabled: 'boolean',
  defenseRank: 'number',
  attackRank: 'number',
  rankedPlayEnabled: 'boolean',
  name: 'string',
  botEnabled: 'boolean',
  difficultyRank: 'number',
  active: 'boolean',
  freeToPlay: 'boolean',
  magicRank: 'number'
,
  _id: true,
#  use$SetOnSave: false

module.exports = mongoose.model('Champion', champion)
