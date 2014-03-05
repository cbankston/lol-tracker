async = require 'async'
irelia = require '../../lib/irelia'
Summoner = require '../dal/summoner'
ImportSummonerRecentGamesQueue = require '../queues/import_summoner_recent_games'

module.exports = (summoner_id, next) ->
  async.waterfall [
    (callback) -> lookupSummonerDto(summoner_id, callback),
    (summoner_dto, callback) ->
      attributes = extractAttributes(summoner_dto)
      Summoner.createOrUpdate attributes, callback
    ,
    (summoner, callback) ->
      if summoner.update
        ImportSummonerRecentGamesQueue.push(summoner._id)

      callback(null)
  ], (err) ->
    next(err)

lookupSummonerDto = (id, next) ->
  irelia.getSummonerBySummonerId 'na', id, (err, summoners) ->
    return next(err) if err
    next(err, summoners[id])

extractAttributes = (summoner_dto) ->
  _id: summoner_dto.id,
  name: summoner_dto.name,
  profileIconId: summoner_dto.profileIconId,
  summonerLevel: summoner_dto.summonerLevel,
  revisionDate: summoner_dto.revisionDate,
  revisionDateStr: summoner_dto.revisionDateStr
