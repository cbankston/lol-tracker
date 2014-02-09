express = require 'express'
require './initializers'
dot = require('./initializers/dot')
mincer = require('./initializers/mincer')

config = (app) ->
  app.set 'port', process.env.PORT || 3000

  dot(app);
  mincer(app);

  app.use express.methodOverride() # Allows the use of HTTP 'DELETE' AND 'PUT' methods.
  app.use express.logger()
  app.use app.router
  app.use express.errorHandler()
 
module.exports = config
