_ = require 'underscore'
DDragon = require '../../lib/ddragon'

class SummonerDecorator
  constructor: (@model) ->

  decorate: (next) ->
    attributes = @buildAttributes()
    next(null, attributes)

  buildAttributes: () ->
    _.extend @model,
      image_path: image_path

image_path = () ->
  "#{DDragon.profile_icon_image_url}#{@profileIconId}.png"

module.exports = (model, next) ->
  new SummonerDecorator(model).decorate(next)
