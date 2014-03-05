_ = require 'underscore'
async = require 'async'
DDragon = require '../../lib/ddragon'
Champion = require '../dal/champion'

module.exports = (next) ->
  lookupChampions (err, champions) ->
    return next(err) if err

    async.each Object.keys(champions), (key, callback) ->
      champion_dto = champions[key]
      attributes = extractAttributes(champion_dto)
      Champion.createOrUpdate attributes, callback
    , (err) ->
      next(err)

lookupChampions = (next) ->
  DDragon.getChampions (err, response) ->
    return next(err) if err
    next(err, response.data)

extractAttributes = (champion_dto) ->
  _id: champion_dto.key,
  name: champion_dto.name,
  title: champion_dto.title,
  blurb: champion_dto.blurb,
  image: champion_dto.image.full,
  tags: champion_dto.tags,
  partype: champion_dto.partype,
  stats: champion_dto.stats
