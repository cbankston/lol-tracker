Summoner = require '../models/summoner'

module.exports.create = (attributes, next) ->
  new Summoner(attributes).save (err, summoner) ->
    next(err, summoner)

module.exports.createOrUpdate = (attributes, next) ->
  exports.find attributes._id, (err, summoner) ->
    return next(err) if err
    return exports.create(attributes, next) unless summoner
    exports.update(summoner, attributes, next)

module.exports.find = (id, next) ->
  Summoner.findById id, next

module.exports.findUpdateable = (next) ->
  Summoner.find {update: true}, next

module.exports.update = (summoner, attributes, next) ->
  summoner.set(attributes).save (err, updated_summoner) ->
    next(err, updated_summoner)
