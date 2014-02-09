async = require 'async'
Summoner = require '../dal/summoner'
Game = require '../dal/game'
GameDecorator = require '../decorators/game'
SummonerDecorator = require '../decorators/summoner'
FellowPlayerDecorator = require '../decorators/fellow_player'

index = (req, res) ->
  Summoner.find req.params.summoner_id, (err, summoner) ->
    SummonerDecorator summoner, (err, summoner) ->
      Game.findBySummonerId summoner._id, (err, games) ->
        async.map games, GameDecorator, (err, games) ->
          res.render 'games/index',
            summoner: summoner,
            games: games

show = (req, res) ->
  results = {}

  async.series [
    (next) ->
      Summoner.find req.params.summoner_id, (err, summoner) ->
        return next(Error('Summoner not found')) unless summoner

        SummonerDecorator summoner, (err, summoner) ->
          results.summoner = summoner
          next(err)
    , (next) ->
      Game.find req.params.id, req.params.summoner_id, (err, game) ->
        return next(Error('Game not found')) unless game

        GameDecorator game, (err, game) ->
          results.game = game
          next(err)
    , (next) ->
      players = results.game.fellowPlayers
      players.unshift {
        championId: results.game.championId,
        teamId: results.game.teamId,
        summonerId: results.game.summonerId
      }

      async.map players, FellowPlayerDecorator, (err, players) ->
        results.teams = players.reduce (acc, value, index) ->
          acc[value.teamId].push value
          acc
        , { 100: [], 200: [] }

        next(null)
  ], (err) ->
    if err
      return res.json error: 'not found'

    res.render 'games/show',
      summoner: results.summoner,
      game: results.game,
      teams: results.teams


module.exports.index = index
module.exports.show = show
