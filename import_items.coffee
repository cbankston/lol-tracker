require 'coffee-script'
require './config/initializers'

importItems = require './app/services/import_items'

console.log 'Importing Items'

importItems (err) ->
  console.log(err) if err
  console.log 'Done'
