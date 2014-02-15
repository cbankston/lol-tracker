window.App.Views.BarChart = App.Views.BaseChart.extend
  defaults: _.defaults
    barPadding: 0.1
    renderXAxis: true
    renderYAxis: true
  , App.Views.BaseChart.prototype.defaults

  getXDomain: () ->
    @collection.pluck(@options.xAttr)

  getYDomain: () ->
    [0, d3.max(@collection.pluck(@options.yAttr))]

  getXScale: () ->
    padding = @options.barPadding

    d3.scale.ordinal()
      .rangeRoundBands([0, @width], padding)
      .domain(@getXDomain())

  getYScale: () ->
    d3.scale.linear()
      .rangeRound([@height, 0])
      .domain(@getYDomain())

  getXAxis: () ->
    d3.svg.axis()
      .scale(@scales.x)
      .orient("bottom")
      .tickFormat(() -> '')

  getYAxis: () ->
    d3.svg.axis()
      .scale(@scales.y)
      .orient("left")

  renderXAxis: () ->
    @svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + @height + ")")
      .call(@getXAxis())

  renderYAxis: () ->
    @svg.append("g")
      .attr("class", "y axis")
      .call(@getYAxis())

  renderAxes: () ->
    @renderXAxis() if @options.renderXAxis
    @renderYAxis() if @options.renderYAxis

  mapData: () ->
    _.map @collection.models, (point) =>
      {
        x: point.get(@options.xAttr)
        y: point.get(@options.yAttr)
      }

  renderData: () ->
    chart = this
    x = @scales.x
    y = @scales.y

    @svg.selectAll(".bar")
      .data(@mapData())
      .enter().append("rect")
      .attr("class", "bar")
      .attr("x", (d) -> x(d.x) )
      .attr("width", x.rangeBand() )
      .attr("y", (d) -> y(d.y) )
      .attr("height", (d) -> chart.height - y(d.y) )
