window.App.Collections.Games = Backbone.Collection.extend
  model: window.App.Models.Game,
  initialize: (data, options) ->
    if options.champion_id
      this.url = "/summoners/#{options.summoner_id}/champions/#{options.champion_id}"
    else
      this.url = "/summoners/#{options.summoner_id}/games"
