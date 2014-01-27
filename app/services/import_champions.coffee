_ = require 'underscore'
async = require 'async'
irelia = require '../../lib/irelia'
Champion = require '../dal/champion'

module.exports = (next) ->
  lookupChampions (err, champions) ->
    async.each champions, (champion_dto, callback) ->
      attributes = extractAttributes(champion_dto)
      Champion.createOrUpdate attributes, callback
    , (err) ->
      next(err)

lookupChampions = (next) ->
  irelia.getChampions 'na', false, (err, response) ->
    return next(err) if err
    next(err, response.champions || [])

extractAttributes = (champion_dto) ->
  _id: champion_dto.id,
  botMmEnabled: champion_dto.botMmEnabled,
  defenseRank: champion_dto.defenseRank,
  attackRank: champion_dto.attackRank,
  rankedPlayEnabled: champion_dto.rankedPlayEnabled,
  name: champion_dto.name,
  botEnabled: champion_dto.botEnabled,
  difficultyRank: champion_dto.difficultyRank,
  active: champion_dto.active,
  freeToPlay: champion_dto.freeToPlay,
  magicRank: champion_dto.magicRank
