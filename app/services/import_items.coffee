_ = require 'underscore'
async = require 'async'
DDragon = require '../../lib/ddragon'
Item = require '../dal/item'

module.exports = (next) ->
  lookupItems (err, items) ->
    return next(err) if err

    async.each Object.keys(items), (item_id, callback) ->
      attributes = extractAttributes(item_id, items[item_id])
      Item.createOrUpdate attributes, callback
    , (err) ->
      next(err)

lookupItems = (next) ->
  DDragon.getItems (err, response) ->
    return next(err) if err
    next(err, response.data)

extractAttributes = (item_id, item_dto) ->
  _id: item_id,
  name: item_dto.name,
  group: item_dto.group,
  description: item_dto.description,
  colloq: item_dto.colloq,
  plaintext: item_dto.plaintext,
  from: item_dto.from,
  into: item_dto.into,
  image: item_dto.image.full,
  gold: item_dto.gold,
  tags: item_dto.tags,
  maps: item_dto.maps,
  stats: item_dto.stats,
  depth: item_dto.depth
