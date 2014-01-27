_ = require 'underscore'
cdn_url = 'http://ddragon.leagueoflegends.com/cdn/3.15.5/img/profileicon/'

class SummonerDecorator
  constructor: (@model) ->

  decorate: (next) ->
    attributes = @buildAttributes()
    next(null, attributes)

  buildAttributes: () ->
    _.extend @model,
      image_path: image_path

image_path = () ->
  "#{cdn_url}#{@profileIconId}.png"

module.exports = (model, next) ->
  new SummonerDecorator(model).decorate(next)
