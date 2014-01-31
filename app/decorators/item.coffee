_ = require 'underscore'
DDragon = require '../../lib/ddragon'

class ItemDecorator
  constructor: (@model) ->

  decorate: (next) ->
    attributes = @buildAttributes()
    next(null, attributes)

  buildAttributes: () ->
    _.extend @model,
      image_path: image_path

image_path = () ->
  "#{DDragon.item_image_url}#{@image}"

module.exports = (model, next) ->
  new ItemDecorator(model).decorate(next)
