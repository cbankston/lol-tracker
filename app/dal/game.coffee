Game = require '../models/game'

module.exports.create = (attributes, next) ->
  new Game(attributes).save (err, game) ->
    game.was_just_created = true if game
    next(err, game)

module.exports.findOrCreate = (attributes, next) ->
  exports.find attributes.gameId, attributes.summonerId, (err, game) ->
    return next(err) if err
    return exports.create(attributes, next) unless game
    next(null, game)

module.exports.find = (game_id, summoner_id, next) ->
  Game.findOne { gameId: game_id, summonerId: summoner_id }, next

module.exports.findByChampionIdAndSummonerId = (champion_id, summoner_id, next) ->
  Game.find( summonerId: summoner_id, championId: champion_id ).sort('-createDate').exec(next)

module.exports.findBySummonerId = (summoner_id, next) ->
  Game.find( summonerId: summoner_id ).sort('-createDate').exec(next)
