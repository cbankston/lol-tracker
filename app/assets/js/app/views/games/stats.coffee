window.App.Views.GameStats = Backbone.View.extend
  initialize: (options) ->
    @games = options.games

  render: () ->
    cs_chart = new App.Views.GamesBarChart
      el: '.js-cs-chart',
      games: @games,
      yAttr: "minionsKilled"
    cs_chart.render()

    damage_chart = new App.Views.GamesBarChart
      el: '.js-damage-chart',
      games: @games,
      yAttr: "totalDamageDealtToChampions"
    damage_chart.render()

    gold_chart = new App.Views.GamesBarChart
      el: '.js-gold-chart',
      games: @games,
      yAttr: "goldEarned"
    gold_chart.render()

    this
