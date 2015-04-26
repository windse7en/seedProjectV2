var dataset = [1, 2, 3, 4, 5, 6];
var words = ["Financial H.I", 
             "Industrial H.Index",
             "Goverment Health Index",
             "Industrial Health Index",
             "Health Related Company Health Index",
             "Consumer/Patient Health Index"]

var width = 400,
    height = 300;

var wx = d3.scale.linear()
    .domain([0, d3.max(dataset)])
    .range([0, width * 9 / 10]);

var color = d3.scale.category20();
var set_color = function(d,i){return color(d);};

var svg = d3.select("#health_index_line_chart").append("svg").attr("width", width).attr("height", height);

svg.selectAll("rect").data(dataset).enter()
    .append("rect")
    .attr("y", function (d, i) {
    return (i + 1) * 10;
})
    .attr("fill", "red")
    .attr("height", 20)
    .transition()
    .duration(3000)
    .ease("bounce")
    .delay(function (d, i) {
    return i * 200;
})
    .attr("x", 10).attr("y", function (d) {
    return d * 30;
})
    .attr("width", function (d) {
    return (d+1) * (width/7);
}).attr("height", 20)
    .attr("fill", set_color);

svg.selectAll("rect")
    .on("click", function (d, i) {
    d3.select(this)
        .attr("fill", "green");
})
    .on("mouseover", function (d, i) {
    d3.select(this).attr("fill", "yellow");
})
    .on("mouseout", function (d, i) {
    d3.select(this).transition().duration(1000)
        .attr("fill", set_color);
});


svg.selectAll("text").data(dataset).enter()
    .append("text")
    .text(function (d) {
    return words[d-1];
    })
    .attr("y", function (d, i) {
    return (i + 1) * 30 + 15;
    })
    .attr("x", 20)
    .attr("fill", "white");