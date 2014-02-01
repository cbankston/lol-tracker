_ = require 'underscore'
Champion = require '../dal/champion'
ChampionDecorator = require './champion'

class SummonerChampionDecorator
  constructor: (@model) ->

  decorate: (next) ->
    attributes = @buildAttributes()

    @populateChampion(attributes, next)

  populateChampion: (attributes, next) ->
    Champion.find attributes.championId, (err, champion) ->
      ChampionDecorator champion, (err, champion) ->
        attributes.champion = champion
        next(err, attributes)

  buildAttributes: () ->
    _.extend @model, {}

module.exports = (model, next) ->
  new SummonerChampionDecorator(model).decorate(next)
