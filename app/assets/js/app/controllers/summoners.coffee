window.App.Controllers.Summoners =
  stats: (summoner_id) ->
    games = new App.Collections.Games([], { summoner_id: summoner_id })

    view = new App.Views.GameStats
      games: games

    games.fetch
      complete: () ->
        view.render()
