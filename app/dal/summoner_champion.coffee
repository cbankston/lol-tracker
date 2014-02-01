Game = require '../models/game'
SummonerChampion = require '../models/summoner_champion'

module.exports.create = (attributes, next) ->
  new SummonerChampion(attributes).save (err, record) ->
    next(err, record)

module.exports.findOrCreate = (attributes, next) ->
  exports.find attributes.summonerId, attributes.championId, (err, record) ->
    return next(err) if err
    unless record
      return exports.create attributes, (err, record) ->
        if (err && err.code == 11000)
          return exports.findOrCreate(attributes, next)
        else
          next(err, record)
    next(null, record)

module.exports.find = (summoner_id, champion_id, next) ->
  SummonerChampion.findOne({ championId: champion_id, summonerId: summoner_id }, next)

module.exports.findBySummonerId = (summoner_id, next) ->
  SummonerChampion.find( summonerId: summoner_id ).sort('-games.total').exec(next)

module.exports.increment = (id, increment_values, next) ->
  SummonerChampion.update({ _id: id }, {$inc: increment_values}, next)
