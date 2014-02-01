async = require 'async'
Champion = require '../dal/champion'
ChampionDecorator = require '../decorators/champion'
Game = require '../dal/game'
GameDecorator = require '../decorators/game'
Summoner = require '../dal/summoner'
SummonerChampion = require '../dal/summoner_champion'
SummonerChampionDecorator = require '../decorators/summoner_champion'
SummonerDecorator = require '../decorators/summoner'

index = (req, res) ->
  Summoner.find req.params.summoner_id, (err, summoner) ->
    SummonerDecorator summoner, (err, summoner) ->
      SummonerChampion.findBySummonerId summoner._id, (err, summoner_champions) ->
        async.map summoner_champions, SummonerChampionDecorator, (err, summoner_champions) ->
          res.render 'summoner_champions/index',
            summoner: summoner,
            summoner_champions: summoner_champions

show = (req, res) ->
  Summoner.find req.params.summoner_id, (err, summoner) ->
    SummonerDecorator summoner, (err, summoner) ->
      Champion.find req.params.champion_id, (err, champion) ->
        unless champion
          return res.json error: 'not found'

        ChampionDecorator champion, (err, champion) ->
          Game.findByChampionIdAndSummonerId req.params.champion_id, req.params.summoner_id, (err, games) ->
            async.map games, GameDecorator, (err, games) ->
              res.render 'summoner_champions/show',
                summoner: summoner,
                champion: champion,
                games: games

module.exports.index = index
module.exports.show = show
