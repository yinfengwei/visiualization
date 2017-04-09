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
    <title>散点矩阵</title>
    <jsp:include page="${ctx}/common/head.jsp"></jsp:include>

    <style type="text/css">

        svg {
            font-size: 14px;
        }

        .axis {
            shape-rendering: crispEdges;
        }

        .axis line {
            stroke: #ddd;
            stroke-width: .5px;
        }

        .axis path {
            display: none;
        }

        rect.extent {
            fill: #000;
            fill-opacity: .125;
            stroke: #fff;
        }

        rect.frame {
            fill: #fff;
            fill-opacity: .7;
            stroke: #aaa;
        }

        circle {
            fill: #ccc;
            fill-opacity: .5;
        }

        .legend circle {
            fill-opacity: 1;
        }

        .legend text {
            font-size: 18px;
            font-style: oblique;
        }

        .cell text {
            pointer-events: none;
        }

        .setosa {
            fill: #800;
        }

        .versicolor {
            fill: #080;
        }

        .virginica {
            fill: #008;
        }

    </style>
</head>
<body style="text-align: center">
<jsp:include page="${ctx}/common/error.jsp"></jsp:include>
    <div style="margin: auto" id="body">
        <h1>Scatter Plot/散点矩阵图</h1>
        <p style="font-size: 10px;">使用数据源 : 鸢尾花(iris)数据集</p>
    </div>

    <div style="margin-left: 300px;margin-right: 250px;text-align: left">

        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">数据源说明</h3>
            </div>
            <div class="panel-body">
                鸢尾花(iris)是数据挖掘常用到的一个数据集，包含150种鸢尾花的信息.
                每50种取自三个鸢尾花种之一（setosa,versicolour或virginica)。
                每个花的特征用下面的5种属性描述
                萼片长度(Sepal.Length)、萼片宽度(Sepal.Width)、花瓣长度(Petal.Length)、
                花瓣宽度(Petal.Width)、类(Species)。
            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">散点矩阵图优点</h3>
            </div>
            <div class="panel-body">
                <p> 1、使用一个二维散点图表达每对维度之间的关系</p>
                <p> 2、可直观显示任意两个维度间的相关性</p>
            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">散点矩阵图不足</h3>
            </div>
            <div class="panel-body">
                <p> 1、维数增加时屏幕显示问题</p>
                <p> 2、只能发现两个维度之间的关系</p>
            </div>
        </div>


    </div>

</body>
<script>
    // Size parameters.
    var size = 140,
            padding = 10,
            n = 4,
            traits = ["sepal length", "sepal width", "petal length", "petal width"];

    $(function () {
        $("[data-toggle='tooltip']").tooltip();
//        n = 3;
//        traits = ["sepal width", "petal length", "petal width"];

        draw();
    });

    function draw() {
        //读取数据
        d3.csv("${ctx}/visualization-admin/resource/data/iris.csv", function (error, flowers) {
            if (error) {
                throw error;
            }


            // 位置
            var x = {}, y = {};

            traits.forEach(function(trait) {
                // Coerce values to numbers.
                flowers.forEach(function(d) {
                    d[trait] = +d[trait];
                });

                var value = function(d) {
                            return d[trait];
                        }, domain = [d3.min(flowers, value), d3.max(flowers, value)],
                        range = [padding / 2, size - padding / 2];

                x[trait] = d3.scale.linear().domain(domain).range(range);
                y[trait] = d3.scale.linear().domain(domain).range(range.reverse());

            });

            // Axes.
            var axis = d3.svg.axis()
                    .ticks(5)
                    .tickSize(size * n);

            // Brush.
            var brush = d3.svg.brush()
                    .on("brushstart", brushstart)
                    .on("brush", brush)
                    .on("brushend", brushend);

            // Root panel.
            var svg = d3.select("#body").append("svg:svg")
                    .attr("width", 1280)
                    .attr("height", 600)
                    .append("svg:g")
                    .attr("transform", "translate(359.5,19.5)");

            // Legend.
            var legend = svg.selectAll("g.legend")
                    .data(["setosa", "versicolor", "virginica"])
                    .enter().append("svg:g")
                    .attr("class", "legend")
                    .attr("transform", function(d, i) {
                        return "translate(600," + (i * 20 + 500) + ")";
                    });

            legend.append("svg:circle")
                    .attr("class", String)
                    .attr("r", 3);

            legend.append("svg:text")
                    .attr("x", 12)
                    .attr("dy", ".31em")
                    .text(function(d) { return "Iris " + d; });

            // X-axis.
            svg.selectAll("g.x.axis")
                    .data(traits)
                    .enter().append("svg:g")
                    .attr("class", "x axis")
                    .attr("transform", function(d, i) {
                        return "translate(" + i * size + ",0)";
                    })
                    .each(function(d) {
                        d3.select(this).call(axis.scale(x[d]).orient("bottom"));
                    });

            // Y-axis.
            svg.selectAll("g.y.axis")
                    .data(traits)
                    .enter().append("svg:g")
                    .attr("class", "y axis")
                    .attr("transform", function(d, i) {
                        return "translate(560," + i * size + ")";
                    })
                    .each(function(d) {
                        d3.select(this).call(axis.scale(y[d]).orient("left"));
                    });

            // Cell and plot.
            var cell = svg.selectAll("g.cell")
                    .data(cross(traits, traits))
                    .enter().append("svg:g")
                    .attr("class", "cell")
                    .attr("transform", function(d) {
                        return "translate(" + d.i * size + "," + d.j * size + ")";
                    })
                    .each(plot);

            // Titles for the diagonal.
            cell.filter(function(d) {
                return d.i == d.j;
            }).append("svg:text")
                    .attr("x", padding)
                    .attr("y", padding)
                    .attr("dy", ".71em")
                    .text(function(d) {
                        return d.x;
                    });

            function plot(p) {

                var cell = d3.select(this);

                // Plot frame.
                cell.append("svg:rect")
                        .attr("class", "frame")
                        .attr("x", padding / 2)
                        .attr("y", padding / 2)
                        .attr("width", size - padding)
                        .attr("height", size - padding);

//                // Plot dots.
                cell.selectAll("circle")
                        .data(flowers)
                        .enter().
                append("svg:circle")
                        .attr("class", function(d) {
                            return d.species;
                        })
                        .attr("cx", function(d) {
                            return x[p.x](d[p.x]);
                        })
                        .attr("cy", function(d) {
                            return y[p.y](d[p.y]);
                        })
                        .attr("r", 3);

                // Plot brush.
                cell.call(brush.x(x[p.x]).y(y[p.y]));
            }

            // Clear the previously-active brush, if any.
            function brushstart(p) {
                if (brush.data !== p) {
                    cell.call(brush.clear());
                    brush.x(x[p.x]).y(y[p.y]).data = p;
                }
            }

            // Highlight the selected circles.
            function brush(p) {
                var e = brush.extent();
                svg.selectAll(".cell circle").attr("class", function(d) {
                    return e[0][0] <= d[p.x] && d[p.x] <= e[1][0]
                    && e[0][1] <= d[p.y] && d[p.y] <= e[1][1]
                            ? d.species : null;
                });
            }

            // If the brush is empty, select all circles.
            function brushend() {
                if (brush.empty()) svg.selectAll(".cell circle").attr("class", function(d) {
                    return d.species;
                });
            }

            function cross(a, b) {
                var c = [], n = a.length, m = b.length, i, j;
                for (i = -1; ++i < n;) for (j = -1; ++j < m;) c.push({x: a[i], i: i, y: b[j], j: j});
                return c;
            }
        });

    }



</script>
</html>
