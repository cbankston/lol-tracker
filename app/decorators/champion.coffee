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
  "#{DDragon.champion_image_url}#{@image}"

module.exports = (model, next) ->
  new ChampionDecorator(model).decorate(next)
