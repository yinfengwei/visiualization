<%--
  Created by IntelliJ IDEA.
  User: yinfeng
  Date: 2017/3/21 0021
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>工程</title>
    <jsp:include page="${ctx}/common/head.jsp"></jsp:include>

    <style type="text/css">

        svg {
            font-size: 14px;
        }

        .foreground path {
            fill: none;
            stroke-opacity: .5;
            stroke-width: 1.5px;
        }

        .foreground path.fade {
            stroke: #000;
            stroke-opacity: .05;
        }

        .legend {
            font-size: 18px;
            font-style: oblique;
        }

        .legend line {
            stroke-width: 2px;
        }

        .unknown {
            stroke: #800;
        }

        .secondary {
            stroke: #080;
        }

        .primary{
            stroke: #848;
        }

        .tertiary{
            stroke: #008;
        }


        .brush .extent {
            fill-opacity: .3;
            stroke: #fff;
            shape-rendering: crispEdges;
        }

        .axis line, .axis path {
            fill: none;
            stroke: #000;
            shape-rendering: crispEdges;
        }

        .axis text {
            text-shadow: 0 1px 0 #fff;
            cursor: move;
        }

    </style>
</head>
<body style="margin: auto;">
<jsp:include page="${ctx}/common/error.jsp"></jsp:include>
    <div id="body" style="text-align: center">
        <div style="margin: auto">
            <h1 style="margin-top: 50px;">Parallel Coordinates/平行坐标图</h1>
            <p style="font-size: 10px;">使用数据源 : 信用卡数据集</p>
            <div class="form-group" style="margin-left: 300px;margin-right: 250px;">
                <label class="col-sm-3 control-label">分析维度类型：</label>
                <div class="col-sm-4">
                    <select id="type" name="type" class="selectpicker form-control" multiple="multiple">
                        <option value="age">age</option>
                        <option value="job">job</option>
                        <option value="marital">marital</option>
                        <option value="default">default</option>
                        <option value="balance">balance</option>
                        <option value="housing">housing</option>
                        <option value="loan">loan</option>
                    </select>
                </div>
                <div>
                    <button class="btn" onclick="redraw()">重新绘制</button>
                </div>
             </div>
        </div>

    </div>
    <div style="margin-left: 300px;margin-right: 250px;text-align: left">


    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">数据源说明</h3>
        </div>
        <div class="panel-body">
            采用信用卡调查数据，含有"age", "job", "marital"(婚姻), "default", "balance"(收支情况), "housing", "loan"维度数据
            颜色采用用户教育程度，分别为"unknown","secondary","primary","tertiary"四个教育程度，分别代表
            未知、中等教育、基本教育、高等教育。
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">优点</h3>
        </div>
        <div class="panel-body">
            <p> 1、D3.js 可以直观显示维度相关性</p>
            <p> 2、可以拖动鼠标进行数据选择，分析数据之间的相关性</p>
            <p> 3、根据数据分析的需求可以对显示数据源维度进行筛选分析</p>
        </div>
    </div>


</div>
</body>
<script type="text/javascript">


    var education = ["1", "2", "3", "4"],
            traits = ["age", "job", "marital", "default", "balance", "housing", "loan"];

    //使对应class
    var cardMap = ["unknown","secondary","primary","tertiary"];


    var m = [80, 160, 200, 160],
            w = 1280 - m[1] - m[3],
            h = 800 - m[0] - m[2];

    var x = d3.scale.ordinal().domain(traits).rangePoints([0, w]),
            y = {};

    var line = d3.svg.line(),
            axis = d3.svg.axis().orient("left"),
            foreground;

    var svg = d3.select("#body").append("svg:svg")
            .attr("width", w + m[1] + m[3])
            .attr("height", h + m[0] + m[2])
            .append("svg:g")
            .attr("transform", "translate(" + m[3] + "," + m[0] + ")");

    $(function () {
//        traits = ["job", "marital", "default", "balance", "housing", "loan"];
        $('#type').selectpicker('val', traits);
        console.info($('#type').val());
//        traits = ($('#type').val());

        draw();
    });

    function redraw() {
        d3.select("#body").select("svg").remove();

        svg = d3.select("#body").append("svg:svg")
                .attr("width", w + m[1] + m[3])
                .attr("height", h + m[0] + m[2])
                .append("svg:g")
                .attr("transform", "translate(" + m[3] + "," + m[0] + ")");

        traits = ($('#type').val());


        draw();

    }

    function draw() {
        d3.csv("${ctx}/visualization-admin/resource/data/cardSelect.csv", function(card) {

            // Create a scale and brush for each trait.
            traits.forEach(function(d) {
                // Coerce values to numbers.
                card.forEach(function(p) {
                    p[d] = +p[d];
                });

                y[d] = d3.scale.linear()
                        .domain(d3.extent(card, function(p) {
                            return p[d];
                        }))
                        .range([h, 0]);

                y[d].brush = d3.svg.brush()
                        .y(y[d])
                        .on("brush", brush);
            });

            // Add a legend.
            var legend = svg.selectAll("g.legend")
                    .data(education)
                    .enter().append("svg:g")
                    .attr("class", "legend")
                    .attr("transform", function(d, i) {
                        return "translate(0," + (i * 20 + 584) + ")";
                    });

            legend.append("svg:line")
                    .attr("class", function(d) {

                        return cardMap[d - 1];

                    })
                    .attr("x2", 8);

            legend.append("svg:text")
                    .attr("x", 12)
                    .attr("dy", ".31em")
                    .text(function(d) {

                        return "Education : " + cardMap[d - 1];

                    });

            // Add foreground lines.
            foreground = svg.append("svg:g")
                    .attr("class", "foreground")
                    .selectAll("path")
                    .data(card)
                    .enter().append("svg:path")
                    .attr("d", path)
                    .attr("class", function(d) {
                        return cardMap[d.education - 1];
                    });

            // Add a group element for each trait.
            var g = svg.selectAll(".trait")
                    .data(traits)
                    .enter().append("svg:g")
                    .attr("class", "trait")
                    .attr("transform", function(d) {
                        return "translate(" + x(d) + ")";
                    })
                    .call(d3.behavior.drag()
                            .origin(function(d) {
                                return {x: x(d)}; }
                            )
                            .on("dragstart", dragstart)
                            .on("drag", drag)
                            .on("dragend", dragend));

            // Add an axis and title.
            g.append("svg:g")
                    .attr("class", "axis")
                    .each(function(d) {
                        d3.select(this).call(axis.scale(y[d]));
                    })
                    .append("svg:text")
                    .attr("text-anchor", "middle")
                    .attr("y", -9)
                    .text(String);

            // Add a brush for each axis.
            g.append("svg:g")
                    .attr("class", "brush")
                    .each(function(d) { d3.select(this).call(y[d].brush); })
                    .selectAll("rect")
                    .attr("x", -8)
                    .attr("width", 16);

            function dragstart(d) {
                i = traits.indexOf(d);
            }

            function drag(d) {
                x.range()[i] = d3.event.x;
                traits.sort(function(a, b) {
                    return x(a) - x(b);
                });
                g.attr("transform", function(d) {
                    return "translate(" + x(d) + ")";
                });
                foreground.attr("d", path);
            }

            function dragend(d) {
                x.domain(traits).rangePoints([0, w]);
                var t = d3.transition().duration(500);
                t.selectAll(".trait").attr("transform", function(d) { return "translate(" + x(d) + ")"; });
                t.selectAll(".foreground path").attr("d", path);
            }
        });
    }



    // Returns the path for a given data point.
    function path(d) {
        return line(traits.map(function(p) {
            return [x(p), y[p](d[p])];
        }));
    }

    // Handles a brush event, toggling the display of foreground lines.
    function brush() {
        var actives = traits.filter(function(p) { return !y[p].brush.empty(); }),
                extents = actives.map(function(p) { return y[p].brush.extent(); });
        foreground.classed("fade", function(d) {
            return !actives.every(function(p, i) {
                return extents[i][0] <= d[p] && d[p] <= extents[i][1];
            });
        });
    }

</script>

</html>
