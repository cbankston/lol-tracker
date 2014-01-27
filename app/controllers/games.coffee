Summoner = require '../dal/summoner'
Game = require '../dal/game'
GameDecorator = require '../decorators/game'
SummonerDecorator = require '../decorators/summoner'

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

module.exports.show = show
