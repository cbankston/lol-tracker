resque = require '../../lib/coffee_resque'

module.exports = {
  queue: 'league_api'
  name: 'ImportSummonerRecentGames'
  push: ->
    params = Array.prototype.slice.call(arguments, 0)
    resque.enqueue(@queue, @name, params)
  runner: () ->
    require '../runners/import_summoner_recent_games'
}
