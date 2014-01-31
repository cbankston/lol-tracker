require 'coffee-script'
require './config/initializers'

importChampionDetails = require './app/services/import_champion_details'

console.log 'Importing Champion Details'

importChampionDetails (err) ->
  console.log(err) if err
  console.log 'Done'
