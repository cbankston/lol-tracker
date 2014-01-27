mongoose = require 'mongoose'
Schema = mongoose.Schema

game = new Schema
  gameId: 'number',
  summonerId: 'number',
  invalid: 'string',
  gameMode: 'string',
  gameType: 'string',
  subType: 'string',
  mapId: 'string',
  teamId: 'string',
  championId: 'string',
  spell1: 'string',
  spell2: 'string',
  level: 'string',
  createDate: 'string',
  fellowPlayers: 'array',
  stats: Schema.Types.Mixed
,
  _id: true,
#  use$SetOnSave: false

module.exports = mongoose.model('Game', game)
