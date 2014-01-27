Champion = require '../models/champion'

module.exports.create = (attributes, next) ->
  new Champion(attributes).save (err, champion) ->
    next(err, champion)

module.exports.createOrUpdate = (attributes, next) ->
  exports.find attributes._id, (err, champion) ->
    return next(err) if err
    return exports.create(attributes, next) unless champion
    exports.update(champion, attributes, next)

module.exports.find = (id, next) ->
  Champion.findById id, next

module.exports.findUpdateable = (next) ->
  Champion.find {update: true}, next

module.exports.update = (champion, attributes, next) ->
  champion.set(attributes).save (err, updated_champion) ->
    next(err, updated_champion)
