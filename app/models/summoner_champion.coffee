mongoose = require 'mongoose'
Schema = mongoose.Schema

summoner_champion = new Schema
  summonerId: 'number',
  championId: 'number',
  games: {
    total: {type: 'number', default: 0}
    won: {type: 'number', default: 0},
    lost: {type: 'number', default: 0}
  }
,
  _id: true,
#  use$SetOnSave: false

summoner_champion.index {summonerId: 1, championId: 1}, {unique: true}

module.exports = mongoose.model('SummonerChampion', summoner_champion)
