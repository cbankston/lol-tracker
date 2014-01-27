fs = require 'fs'
nconf = require 'nconf'
path = require 'path'

nconf.file path.resolve(__dirname, 'default.json')

overrides_path = path.resolve(__dirname, 'overrides.json')
if fs.existsSync(overrides_path)
  nconf.file(overrides_path)

module.exports = nconf
