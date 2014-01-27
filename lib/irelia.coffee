Irelia = require 'irelia'
config = require('../config/config').get('riot_api')

module.exports = new Irelia
  endpoint: config.endpoint,
  key: config.key,
  debug: config.debug
