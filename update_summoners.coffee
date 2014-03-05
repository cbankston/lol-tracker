require 'coffee-script'
require './config/initializers'

async = require 'async'
ImportSummonerQueue = require './app/queues/import_summoner'
Summoner = require './app/dal/summoner'

handleError = (err) ->
  console.log(err)

updateSummoners = ->
  Summoner.findUpdateable (err, summoners) ->
    return handleError(err) if err

    async.each summoners,
      (summoner, callback) ->
        ImportSummonerQueue.push(summoner._id)
        callback()
      (err) ->
        handleError(err) if err

updateSummoners()
setInterval updateSummoners, 30 * 60 * 1000
