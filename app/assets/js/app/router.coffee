window.App.Router = Backbone.Router.extend
  routes:  {
    "summoners/:summoner_id/stats": App.Controllers.Summoners.stats,
    "summoners/:summoner_id/champions/:champion_id/stats": App.Controllers.SummonerChampions.stats,
  }
