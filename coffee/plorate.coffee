scatter = () ->
    width = 600
    height = 600
    radius = 2
    margin = {top: 20, right: 20, bottom: 20, left: 20}
    x_scale = d3.scale.linear()
    y_scale = d3.scale.linear()
    x_axis = d3.svg.axis().scale(x_scale).orient("bottom").ticks(5)
    y_axis = d3.svg.axis().scale(y_scale).orient("bottom").ticks(5)
    x = (d, i) -> +d.x
    y = (d, i) -> +d.y
    point_class = '.point'
    on_mouseover = () -> null
    on_mouseout = () -> null

    chart = (selection) ->
        selection.each((data) ->
            # Update scales.
            x_extent = d3.extent(data, x)
            y_extent = d3.extent(data, y)
            x_scale
                .domain(d3.extent(data, x))
                .range([0, width - margin.left - margin.right])
            y_scale
                .domain(d3.extent(data, y))
                .range([height - margin.top - margin.bottom, 0])

            console.log height - margin.top - margin.bottom
            console.log width - margin.left - margin.right

            # Select the svg element, if it exists.
            svg = d3.select(this).selectAll("svg").data([data])

            # Otherwise, create the skeletal chart.
            g_enter = svg.enter()
                .append("svg")
                .append("g")

            svg
                .attr("width", width)
                .attr("height", height)

            g = svg.select("g")
                .attr("transform",
                      "translate(" + margin.left + "," + margin.top + ")")


            g.selectAll("circle")
                .data(data)
              .enter().append("circle")
                .attr("class", "point")
                .attr("cx", (d, i) -> x_scale(x(d)))
                .attr("cy", (d, i) -> y_scale(y(d)))
                .attr("r", radius)
                .on("mouseover", on_mouseover)
                .on("mouseout", on_mouseout)

        )


    # Properties.

    chart.width = (args...) -> 
        if not args.length
            return width
        else
            width = args[0]
            return chart

    chart.height= (args...) -> 
        if not args.length
            return height
        else
            height = args[0]
            return chart

    chart.margin = (args...) -> 
        if not args.length
            return margin 
        else
            margin = args[0]
            return chart

    chart.radius = (args...) -> 
        if not args.length
            return radius 
        else
            radius = args[0]
            return chart

    chart.x_scale= (args...) -> 
        if not args.length
            return x_scale 
        else
            x_scale = args[0]
            return chart

    chart.y_scale= (args...) -> 
        if not args.length
            return y_scale 
        else
            y_scale = args[0]
            return chart

    chart.x_axis= (args...) -> 
        if not args.length
            return x_axis 
        else
            x_axis = args[0]
            return chart

    chart.y_axis= (args...) -> 
        if not args.length
            return y_axis 
        else
            y_axis = args[0]
            return chart

    chart.x = (args...) -> 
        if not args.length
            return x 
        else
            x = args[0]
            return chart

    chart.y = (args...) -> 
        if not args.length
            return y 
        else
            y = args[0]
            return chart

    chart.point_class = (args...) -> 
        if not args.length
            return point_class 
        else
            point_class = args[0]
            return chart

    chart.on_mouseover = (args...) -> 
        if not args.length
            return on_mouseover 
        else
            on_mouseover = args[0]
            return chart

    chart.on_mouseout = (args...) -> 
        if not args.length
            return on_mouseout 
        else
            on_mouseout = args[0]
            return chart

    return chart


#timeseries = (target, data, width, height) ->
#    mini = d3.min((d3.min(i) for i in data))
#    maxi = d3.max((d3.max(i) for i in data))
#    length = d3.max((i.length for i in data))
#    padding = 50
#
#    scale_x = d3.scale.linear()
#        .domain([0, length])
#        .range([padding, width - padding])
#    axis_x = d3.svg.axis()
#        .scale(scale_x)
#        .orient("bottom")
#        .ticks(5)
#
#    scale_y = d3.scale.linear()
#        .domain([mini, maxi])
#        .range([height - padding, padding])
#    axis_y = d3.svg.axis()
#        .scale(scale_y)
#        .orient("left")
#        .ticks(5)
#
#    plot = target
#        .append("svg")
#        .attr("class", "chart")
#        .attr("width", width)
#        .attr("height", height)
#
#    plot.selectAll('path.line')
#        .data(data)
#      .enter().append("svg:path")
#        .attr("d", d3.svg.line()
#                    .x((d,i) -> scale_x(i))
#                    .y(scale_y))
#
#    plot.append("g")
#        .attr("class", "axis")
#        .attr("transform", "translate(" + (padding) + ", 0)")
#        .call(axis_y)
#
#    plot.append("g")
#        .attr("class", "axis")
#        .attr("transform", "translate(0," + (height - padding) + ")")
#        .call(axis_x)
#
#hinton = (target, data, width) ->
#    n_rows = data.length
#    n_columns = data[0].length
#    # TODO: check that all entries of data have the same length
#    size = 1.0 * width / n_columns
#    height = n_rows * size
#    padding = 2 * size
#    max_size = size * 0.8
#    min_size = 0
#
#    mini = d3.min((d3.min(i) for i in data))
#    maxi = d3.max((d3.max(i) for i in data))
#
#    grid_points = []
#    for row, i in data
#        for cell, j in row
#            cell = cell / maxi
#            abs_cell = Math.abs(cell)
#            grid_points.push({
#                'y': i - abs_cell / 2 + .5,
#                'x': j - abs_cell / 2 + .5, 
#                'color': if cell > 0 then 'white' else 'black',
#                'value': cell,
#                'abs_value': Math.abs(cell)})
#    
#    grid = target.append("svg")
#        .attr("width", width)
#        .attr("height", height)
#        .attr("class", "chart")
#        .style("background", "#888")
#
#    scale_y = d3.scale.linear()
#       .domain([0, n_rows])
#       .range([padding, height - padding])
#
#    scale_x = d3.scale.linear()
#       .domain([0, n_columns])
#       .range([padding, width - padding])
#
#    scale_size = d3.scale.linear()
#       .domain([0, 1])
#       .range([min_size, max_size])
#
#    rects = grid.selectAll(".rect")
#        .data(grid_points)
#      .enter().append("svg:rect")
#        .attr("class", "cell")
#        .attr("value", (d) -> d.value)
#        .attr("y", (d) -> scale_y(d.y))
#        .attr("x", (d) -> scale_x(d.x))
#        .attr("width", (d) -> scale_size(d.abs_value))
#        .attr("height", (d) -> scale_size(d.abs_value))
#        .style("fill", (d) -> d.color)
#
#

@plorate = {}
plorate.scatter = scatter
