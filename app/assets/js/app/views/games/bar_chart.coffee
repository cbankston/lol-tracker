window.App.Views.GamesBarChart = App.Views.BarChart.extend
  defaults: _.defaults
    xAttr: 'gameId'
    renderXAxis: false
  , App.Views.BarChart.prototype.defaults

  initialize: (options) ->
    _this = this

    App.Views.BarChart.prototype.initialize.apply(this, arguments)

    @collection = new Backbone.Collection
    @collection.comparator = "#{@options.xAttr}"

    options.games.each (item) ->
      _this.collection.add _this.transformData(item)

  transformData: (point) ->
    data = {}
    data[@options.xAttr] = point.get(@options.xAttr)
    data[@options.yAttr] = point.get('stats')[@options.yAttr]
    data

  getXScale: () ->
    padding = @options.barPadding

    d3.scale.ordinal()
      .rangeRoundBands([0, @width], padding)
      .domain(@getXDomain())
