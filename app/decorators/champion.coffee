_ = require 'underscore'
DDragon = require '../../lib/ddragon'

class ChampionDecorator
  constructor: (@model) ->

  decorate: (next) ->
    attributes = @buildAttributes()
    next(null, attributes)

  buildAttributes: () ->
    _.extend @model,
      image_path: image_path

image_path = () ->
  "#{DDragon.champion_image_url}#{image_name(@name)}.png"

image_name = (name) ->
  name.charAt(0).toUpperCase() + name.toLowerCase().slice(1)

module.exports = (model, next) ->
  new ChampionDecorator(model).decorate(next)
