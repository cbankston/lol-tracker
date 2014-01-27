_ = require 'underscore'
cdn_url = 'http://ddragon.leagueoflegends.com/cdn/3.15.5/img/champion/'

class ChampionDecorator
  constructor: (@model) ->

  decorate: (next) ->
    attributes = @buildAttributes()
    next(null, attributes)

  buildAttributes: () ->
    _.extend @model,
      image_path: image_path

image_path = () ->
  "#{cdn_url}#{image_name(@name)}.png"

image_name = (name) ->
  name.charAt(0).toUpperCase() + name.toLowerCase().slice(1)

module.exports = (model, next) ->
  new ChampionDecorator(model).decorate(next)
