window.App.Views.BaseChart = Backbone.View.extend
  defaults:
    xAttr: "x"
    yAttr: "y"
    margin: { top: 20, right: 20, bottom: 30, left: 40 }

  initialize: (options) ->
    @options = _.defaults(options, @defaults)

  render: () ->
    margin = @options.margin
    @width = @$el.width() - margin.left - margin.right
    @height = @$el.height() - margin.top - margin.bottom

    @svg = d3.select(@el).append("svg")
        .attr("width", @width + margin.left + margin.right)
        .attr("height", @height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

    @scales = 
      x: @getXScale(),
      y: @getYScale()

    @renderAxes()
    @renderData()

    this
