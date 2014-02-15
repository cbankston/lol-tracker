window.App.Controllers.SummonerChampions =
  stats: (summoner_id, champion_id) ->
    games = new App.Collections.Games([], { summoner_id: summoner_id, champion_id: champion_id })

    view = new App.Views.GameStats
      games: games

    games.fetch
      complete: () ->
        view.render()
