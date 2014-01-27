config = require('../config').get('mongo')
mongoose = require 'mongoose'

mongoose.connect "mongodb://#{config.user}@#{config.server}/#{config.database}"
mongoose.connection.on 'error', (err) ->
  console.log 'MongoDB Error: #{err.message}'
