_ = require 'underscore'
async = require 'async'
Champion = require '../dal/champion'
ChampionDecorator = require './champion'
Summoner = require '../dal/summoner'
SummonerDecorator = require './summoner'

class FellowPlayerDecorator
  constructor: (@model) ->

  decorate: (next) ->
    attributes = @buildAttributes()

    async.parallel [
      (callback) => _this.populateChampion(attributes, callback),
      (callback) => _this.populateSummoner(attributes, callback),
    ], (err, results) ->
      next(err, attributes)

  populateChampion: (attributes, next) ->
    Champion.find attributes.championId, (err, champion) ->
      ChampionDecorator champion, (err, decorated_champion) ->
        attributes.champion = decorated_champion
        next(err)

  populateSummoner: (attributes, next) ->
    Summoner.find attributes.summonerId, (err, summoner) ->
      SummonerDecorator summoner, (err, decorated_summoner) ->
        attributes.summoner = decorated_summoner
        next(err)

  buildAttributes: () ->
    _.extend @model, {}

module.exports = (model, next) ->
  new FellowPlayerDecorator(model).decorate(next)
