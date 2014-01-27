require 'coffee-script'
require './config/initializers'

async = require 'async'
importSummonerQueue = require './app/queues/import_summoner'
Summoner = require './app/dal/summoner'

updateSummoners = ->
  Summoner.findUpdateable (err, summoners) ->
    return console.log(err) if err
    async.each summoners
      , (summoner, callback) ->
        importSummonerQueue.push(summoner._id)
        callback()
      , (err) ->
        console.log err if err

updateSummoners()
setInterval updateSummoners, 60 * 30 * 1000
