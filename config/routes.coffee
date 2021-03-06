Summoners = require '../app/controllers/summoners'
SummonerChampions = require '../app/controllers/summoner_champions'
Games = require '../app/controllers/games'
Home = require '../app/controllers/home'

routes = (app) ->
 
  app.get '/summoners/:summoner_id/champions/:champion_id/stats', SummonerChampions.stats
  app.get '/summoners/:summoner_id/champions/:champion_id/games', SummonerChampions.games
  app.get '/summoners/:summoner_id/champions/:champion_id', SummonerChampions.show
  app.get '/summoners/:summoner_id/champions', SummonerChampions.index

  app.get '/summoners/:summoner_id/games/:id', Games.show
  app.get '/summoners/:summoner_id/games', Games.index

  app.get '/summoners/:summoner_id/stats', Summoners.stats
  app.get '/summoners/:summoner_id', Summoners.show
  app.get '/summoners', Summoners.index

  app.get '/', Home.index

module.exports = routes
