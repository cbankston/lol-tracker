async = require 'async'
Summoner = require '../dal/summoner'
Game = require '../dal/game'
GameDecorator = require '../decorators/game'
SummonerDecorator = require '../decorators/summoner'

index = (req, res) ->
  Summoner.find req.params.summoner_id, (err, summoner) ->
    SummonerDecorator summoner, (err, summoner) ->
      Game.findBySummonerId summoner._id, (err, games) ->
        async.map games, GameDecorator, (err, games) ->
          res.render 'games/index',
            summoner: summoner,
            games: games

show = (req, res) ->
  Summoner.find req.params.summoner_id, (err, summoner) ->
    SummonerDecorator summoner, (err, summoner) ->
      Game.find req.params.id, req.params.summoner_id, (err, game) ->
        unless game
          return res.json error: 'not found'

        GameDecorator game, (err, game) ->
          res.render 'games/show',
            summoner: summoner,
            game: game

module.exports.index = index
module.exports.show = show
