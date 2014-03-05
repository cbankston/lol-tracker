_ = require 'underscore'
async = require 'async'
SummonerChampion = require '../dal/summoner_champion'

module.exports = (game, next) ->
  async.waterfall [
    (callback) ->
      attributes = _.pick(game, 'summonerId', 'championId')
      SummonerChampion.findOrCreate attributes, callback
    ,
    (summoner_champion, callback) ->
      increment_values = 
        'games.total': 1,
        'games.won': if game.won() then 1 else 0,
        'games.lost': if game.won() then 0 else 1

      SummonerChampion.increment(summoner_champion._id, increment_values, callback)
  ], (err) ->
    next(err)
