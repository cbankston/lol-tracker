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
  Game.findByChampionIdAndSummonerId req.params.champion_id, req.params.summoner_id, (err, games) ->
    res.format
      html: () ->
        async.map games, GameDecorator, (err, games) ->
          Summoner.find req.params.summoner_id, (err, summoner) ->
            SummonerDecorator summoner, (err, summoner) ->
              Champion.find req.params.champion_id, (err, champion) ->
                unless champion
                  return res.json error: 'not found'

                ChampionDecorator champion, (err, champion) ->
                  data =
                    games: games
                    champion: champion,
                    summoner: summoner

                  res.render 'summoner_champions/show', data
      json: () ->
        res.json games

stats = (req, res) ->
  Summoner.find req.params.summoner_id, (err, summoner) ->
    SummonerDecorator summoner, (err, summoner) ->
      Champion.find req.params.champion_id, (err, champion) ->
        unless champion
          return res.json error: 'not found'

        ChampionDecorator champion, (err, champion) ->
          res.render 'summoner_champions/stats',
            summoner: summoner
            champion: champion

module.exports.index = index
module.exports.show = show
module.exports.stats = stats
