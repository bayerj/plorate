scatter = () ->
    width = 800
    height = 800
    radius = 2
    margin = {top: 50, right: 50, bottom: 50, left: 50}
    x_scale = d3.scale.linear()
    y_scale = d3.scale.linear()
    x_axis = d3.svg.axis().scale(x_scale).orient("bottom").tickSize(10, 0)
    y_axis = d3.svg.axis().scale(y_scale).orient("left").tickSize(10, 0)
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

            # Select the svg element, if it exists.
            svg = d3.select(this).selectAll("svg").data([data])

            # Otherwise, create the skeletal chart.
            g_enter = svg.enter()
                .append("svg")
                .append("g")
            g_enter.append("g").attr("class", "x axis")
            g_enter.append("g").attr("class", "y axis")

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

            g.select(".x.axis")
                .attr("transform", "translate(0," + y_scale.range()[0] + ")")
                .call(x_axis)

            g.select(".y.axis")
                .attr("transform", "translate(" + x_scale.range()[0] + ", 0)")
                .call(y_axis)

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


sequence = () -> 
    width = 800
    height = 300
    margin = {top: 20, right: 20, bottom: 20, left: 20}
    x_scale = d3.scale.linear()
    y_scale = d3.scale.linear()
    x_axis = d3.svg.axis().scale(x_scale).orient("bottom").tickSize(10, 0)
    y_axis = d3.svg.axis().scale(y_scale).orient("left").tickSize(10, 0)
    x = (d, i) -> +i
    y = (d, i) -> +d
    on_mouseover = () -> null
    on_mouseout = () -> null
    sequence_class = 'sequence'

    chart = (selection) ->
        selection.each((data) ->
            console.log data
            length = d3.max((i.length for i in data))
            console.log length

            # Update scales.
            x_extent = [0, length]
            y_min = d3.min((d3.min(i) for i in data))
            y_max = d3.max((d3.max(i) for i in data))

            x_scale
                .domain(x_extent)
                .range([0, width - margin.left - margin.right])
            y_scale
                .domain([y_min, y_max])
                .range([height - margin.top - margin.bottom, 0])

            # Select the svg element, if it exists.
            svg = d3.select(this).selectAll("svg").data([data])

            # Otherwise, create the skeletal chart.
            g_enter = svg.enter()
                .append("svg")
                .append("g")
            g_enter.append("g").attr("class", "x axis")
            g_enter.append("g").attr("class", "y axis")

            svg
                .attr("width", width)
                .attr("height", height)

            g = svg.select("g")
                .attr("transform",
                      "translate(" + margin.left + "," + margin.top + ")")

            g.selectAll('path.line')
                .data(data)
              .enter().append("svg:path")
                .attr("d", d3.svg.line()
                            .x((d, i) -> x_scale(x(d, i)))
                            .y((d, i) -> y_scale(y(d, i))))
                .attr("class", sequence_class)
                .on("mouseover", on_mouseover)
                .on("mouseout", on_mouseout)

            g.select(".x.axis")
                .attr("transform", "translate(0," + y_scale.range()[0] + ")")
                .call(x_axis)

            g.select(".y.axis")
                .attr("transform", "translate(" + x_scale.range()[0] + ", 0)")
                .call(y_axis)

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

    chart.sequence_class = (args...) -> 
        if not args.length
            return sequence_class
        else
            sequence_class = args[0]
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


bar = () ->
    width = 800
    height = 400
    bar_margin = 1
    margin = {top: 50, right: 50, bottom: 50, left: 50}
    y_scale = d3.scale.linear()
    x_scale = d3.scale.linear()
    x = (d, i) -> +i
    y = (d, i) -> +d
    bar_class = 'bar'
    on_mouseover = () -> null
    on_mouseout = () -> null
    y_axis = d3.svg.axis().scale(y_scale).orient("left").ticks(5)
    labels = null

    chart = (selection) ->
        selection.each((data) ->
            labels = d3.range(data.length) if labels == null
            # Update scales.
            y_extent = [0, d3.max(y(i) for i in data)]
            y_scale
                .range([height - margin.top - margin.bottom, 0])
                .domain(y_extent)

            x_extent = [0, data.length]
            x_scale
                .domain(x_extent)
                .range([0, width - margin.right - margin.left])

            # Select the svg element, if it exists.
            svg = d3.select(this).selectAll("svg").data([data])

            # Otherwise, create the skeletal chart.
            g_enter = svg.enter()
                .append("svg")
                .append("g")
            g_enter.append("g").attr("class", "y axis")

            svg
                .attr("width", width)
                .attr("height", height)

            g = svg.select("g")
                .attr("transform",
                      "translate(" + margin.left + "," + margin.top + ")")

            bar_width = (x_scale(data.length) - x_scale(0)) / data.length - bar_margin

            g.selectAll("rect")
                .data(data)
              .enter().append("rect")
                .attr("class", bar_class)
                .attr("x", (d, i) -> x_scale(x(d, i)))
                .attr("y", (d, i) -> y_scale(y(d, i)))
                .attr("width", (d, i) -> bar_width)
                .attr("height", (d, i) -> height - margin.bottom - margin.top - y_scale(y(d, i)))
                .on("mouseover", on_mouseover)
                .on("mouseout", on_mouseout)

            g.selectAll("text")
                .data(data)
              .enter().append('text')
                .attr("x", (d, i) -> x_scale(x(d, i)))
                .attr("y", (d, i) -> y_scale(y(d, i)))
                .text((d, i) -> labels[i])


            g.select(".y.axis")
                .attr("transform", "translate(" + x_scale.range()[0] + ", 0)")
                .call(y_axis)

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

    chart.bar_class = (args...) -> 
        if not args.length
            return bar_class 
        else
            bar_class = args[0]
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

    chart.labels = (args...) -> 
        if not args.length
            return labels 
        else
            labels = args[0]
            return labels
    return chart


@plorate = {}
plorate.scatter = scatter
plorate.sequence = sequence
plorate.bar = bar
