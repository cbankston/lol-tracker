require 'coffee-script'
require './config/initializers'

importChampions = require './app/runners/import_champions'

console.log 'Importing Champions'
importChampions (err) ->
  console.log(err) if err
  console.log 'Done'
