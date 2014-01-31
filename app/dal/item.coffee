Item = require '../models/item'

module.exports.create = (attributes, next) ->
  new Item(attributes).save (err, item) ->
    next(err, item)

module.exports.createOrUpdate = (attributes, next) ->
  exports.find attributes._id, (err, item) ->
    return next(err) if err
    return exports.create(attributes, next) unless item
    exports.update(item, attributes, next)

module.exports.find = (id, next) ->
  Item.findById id, next

module.exports.update = (item, attributes, next) ->
  item.set(attributes).save (err, updated_item) ->
    next(err, updated_item)
