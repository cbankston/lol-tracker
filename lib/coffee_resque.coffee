CoffeeResque = require 'coffee-resque'
Config = require('../config/config').get('redis')

client = CoffeeResque.connect
  host: Config.host,
  port: Config.port

module.exports = client
