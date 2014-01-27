async = require 'async'
importSummoner = require '../services/import_summoner'

queue = async.queue (summoner_id, next) ->
  importSummoner summoner_id, (err) ->
    console.log err if err
    preventRateLimiting(err, next)
, 1

preventRateLimiting = (err, next) ->
  setTimeout ->
    next(err)
  , 5000

module.exports.push = () ->
  queue.push.apply(queue.push, arguments)
