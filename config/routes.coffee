Summoners = require '../app/controllers/summoners'
Games = require '../app/controllers/games'
Home = require '../app/controllers/home'

routes = (app) ->
 
  app.get '/summoners/:summoner_id/games/:id', Games.show

  app.get '/summoners/:id', Summoners.show
  app.get '/summoners', Summoners.index

  app.get '/', Home.index

module.exports = routes
