dot = require('consolidate').dot
comprise = require 'comprise'
fs = require 'fs'
path = require 'path'
view_path = path.resolve(__dirname, '../../app/views')

config = (app) ->
  app.set 'views', view_path
  app.set 'view engine', 'dot'

  app.engine '.dot', comprise.express(
    engine: 'dot',
    layout: 'layouts/main',
    layoutDir: view_path,
    partialDir: view_path
  )
 
module.exports = config
