require 'coffee-script'
require './config/initializers'

_ = require 'underscore'
resque = require './lib/coffee_resque'
ImportSummonerQueue = require './app/queues/import_summoner'
ImportSummonerRecentGamesQueue = require './app/queues/import_summoner_recent_games'

rateLimiter = (runner) ->
  () ->
    args = _.values(arguments)
    setTimeout ->
      runner.apply(null, args)
    , 1000

jobs = {}
jobs[ImportSummonerQueue.name] = rateLimiter(ImportSummonerQueue.runner())
jobs[ImportSummonerRecentGamesQueue.name] = rateLimiter(ImportSummonerRecentGamesQueue.runner())

worker = resque.worker(ImportSummonerQueue.queue, jobs)
worker.on 'error', (err, worker, queue, job) ->
  console.error err.stack

worker.start()

trigger_exit = ->
  worker.end ->
    process.exit()

process.on('SIGINT', trigger_exit)
process.on('SIGTERM', trigger_exit)
