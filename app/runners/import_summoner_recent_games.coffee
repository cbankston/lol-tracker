async = require 'async'
irelia = require '../../lib/irelia'
Game = require '../dal/game'
ImportSummonerQueue = require '../queues/import_summoner'
TrackSummonerChampionGame = require './track_summoner_champion_game'

module.exports = (summoner_id, next) ->
  lookupSummonerGamesDto summoner_id, (err, games_dto) ->
    return next(err) if err
    async.each games_dto.games,
      (game, callback) ->
        importGame(summoner_id, game, callback)
      , next

importGame = (summoner_id, game, next) ->
  async.waterfall [
    (callback) ->
      attributes = extractAttributes(summoner_id, game)
      Game.findOrCreate attributes, callback
    ,
    (game, callback) ->
      if game.was_just_created
        importFellowPlayers(game, callback)
      else
        callback(null, game)
    (game, callback) ->
      if game.was_just_created
        TrackSummonerChampionGame(game, callback)
      else
        callback(null, game)
  ], (err) ->
    next(err)

importFellowPlayers = (game, next) ->
  async.each game.fellowPlayers || []
    , (player, callback) ->
      ImportSummonerQueue.push(player.summonerId)
      callback()
    , (err) ->
      next(err, game)

lookupSummonerGamesDto = (summoner_id, next) ->
  irelia.getRecentGamesBySummonerId "na", summoner_id, next

extractAttributes = (summoner_id, game_dto) ->
  summonerId: summoner_id,
  gameId: game_dto.gameId,
  invalid: game_dto.invalid,
  gameMode: game_dto.gameMode,
  gameType: game_dto.gameType,
  subType: game_dto.subType,
  mapId: game_dto.mapId,
  teamId: game_dto.teamId,
  championId: game_dto.championId,
  spell1: game_dto.spell1,
  spell2: game_dto.spell2,
  level: game_dto.level,
  createDate: game_dto.createDate,
  fellowPlayers: game_dto.fellowPlayers,
  stats: game_dto.stats
