async = require 'async'
Summoner = require '../dal/summoner'
Game = require '../dal/game'
GameDecorator = require '../decorators/game'
SummonerDecorator = require '../decorators/summoner'

index = (req, res) ->
  Summoner.findUpdateable (err, summoners) ->
    async.map summoners, SummonerDecorator, (err, summoners) ->
      res.render 'summoners/index', summoners: summoners

show = (req, res) ->
  Summoner.find req.params.summoner_id, (err, summoner) ->
    SummonerDecorator summoner, (err, summoner) ->
      res.render 'summoners/show',
        summoner: summoner

create = (req, res) ->
  res.render 'summoners/create'

update = (req, res) ->
  res.render 'summoners/update'

destroy = (req, res) ->
  res.render 'summoners/destroy'

module.exports.index = index
module.exports.show = show
module.exports.create = create
module.exports.update = update
module.exports.destroy = destroy
