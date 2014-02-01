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

game.methods.won = () ->
  @stats.win

game.index {summonerId: 1, championId: 1}

module.exports = mongoose.model('Game', game)
