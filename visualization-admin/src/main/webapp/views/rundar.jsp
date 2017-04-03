<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>圆形平行坐标系</title>
    <jsp:include page="${ctx}/common/head.jsp"></jsp:include>
    <style>
        .webs polygon {
            fill: white;
            fill-opacity: 0.5;
            stroke: gray;
            stroke-dasharray: 10 5;
        }
        .areas polygon {
            fill-opacity: 0.0;
            stroke-width: 1;
        }
        .areas circle {
            fill: white;
            stroke-width: 1;
        }
        .lines line {
            fill: none;
            stroke: black;
            shape-rendering: crispEdges;
        }
    </style>

</head>
<body>

    <div id="body" style="text-align: center;">
        <div style="margin: auto">
            <h1 style="margin-top: 50px;">Circular Parallel Coordinates</h1>
            <p style="font-size: 10px;">使用数据源 : 鸢尾花(iris)数据集</p>
        </div>

    </div>
    <div style="margin-left: 300px;margin-right: 250px;margin-top:50px;text-align: left">


        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">数据源说明</h3>
            </div>
            <div class="panel-body">
                <div class="panel-body">
                    鸢尾花(iris)是数据挖掘常用到的一个数据集，包含150种鸢尾花的信息.
                    每50种取自三个鸢尾花种之一（setosa,versicolour或virginica)。
                    每个花的特征用下面的5种属性描述
                    萼片长度(Sepal.Length)、萼片宽度(Sepal.Width)、花瓣长度(Petal.Length)、
                    花瓣宽度(Petal.Width)、类(Species)。
                </div>
            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">优点</h3>
            </div>
            <div class="panel-body">
                <p>它与平行坐标系
                    的不同在于使用圆形的k条半径表示k维空间，由于坐标轴
                    内外的几何不对称性，它能更好地揭示多维信息之间的某些
                    特殊关系。</p>

            </div>
        </div>
    </div>

</body>
<script>

    var width = 800, height = 600;

    //画图
    function draw() {

        //创建画布
        var svg = d3.select("#body").append("svg")
                .attr("width", width)
                .attr("height", height);

        //创建图表元素
        var main = svg.append('g')
                .classed('main', true)
                .attr('transform', "translate(" + width/2 + "," + height/2 + ")");


        var types = ['species','sepal length','sepal width','petal length','petal width'];
        var speciesMap = {
            setosa : 1,
            versicolor : 2,
            virginica : 3
        };
        var species = ["setosa", "versicolor", "virginica"];
        var data = {},
                // 网轴的范围，类似坐标轴
                rangeMin = {},
                rangeMax = {},
                size = 0;           //数据量




        d3.csv("${ctx}/visualization-admin/resource/data/iris.csv", function (error, flowers) {
            if (error) {
                throw error;
            }
            size = flowers.length;

            //data set

            types.forEach(function (type) {

                var value = [];

                flowers.forEach(function(flower) {
                    if (type == 'species') {
                        value.push(speciesMap[flower[type]]);

                    } else {
                        value.push(parseFloat(flower[type]));
                    }

                });

                data[type] = value;
                // 网轴的范围，类似坐标轴

                rangeMin[type] = d3.min(value) - 1;

                rangeMax[type] = d3.max(value);


            });

            console.info(data);
            console.info(rangeMin);
            console.info(rangeMax);
            console.info(size);


        //计算坐标并绘制


        // 设定一些方便计算的常量
        var radius = 250,
                // 指标的个数，即fieldNames的长度
                total = types.length,
                // 需要将网轴分成几级，即网轴上从小到大有多少个正多边形
                level = 4,
                arc = 2 * Math.PI;
        // 每项指标所在的角度
        var onePiece = arc/total;
        // 计算网轴的正多边形的坐标
        var polygons = {
            webs: [],
            webPoints: []
        };
        for(var k=level;k>0;k--) {
            var webs = '',
                    webPoints = [];
            var r = radius/level * k;
            for(var i=0;i<total;i++) {
                var x = r * Math.sin(i * onePiece),
                        y = r * Math.cos(i * onePiece);
                webs += x + ',' + y + ' ';
                webPoints.push({
                    x: x,
                    y: y
                });
            }
            polygons.webs.push(webs);
            polygons.webPoints.push(webPoints);
        }
        var origns = '';

        for(var k=0;k < total;k++) {
            var x = 0, y = 0;
            origns += x + ',' + y + ' ';

        }
        // 绘制网轴
        var webs = main.append('g')
                .classed('webs', true);
        webs.selectAll('polygon')
                .data(polygons.webs)
                .enter()
                .append('polygon')
                .attr('points',origns)
                .transition()
                .duration(1000)
                .attr('points', function(d) {
                    return d;
                });

//        setTimeout("console.log('abx')", 2000);

        // 添加纵轴
        var lines = main.append('g')
                .classed('lines', true);
        lines.selectAll('line')
                .data(polygons.webPoints[0])
                .enter()
                .append('line')
                .attr('x1', 0)
                .attr('y1', 0)
                .attr('x2', 0)
                .attr('y2', 0)
                .transition()
                .duration(1000)
                .attr('x2', function(d) {
                    return d.x;
                })
                .attr('y2', function(d) {
                    return d.y;
                });
        // 计算雷达图表的坐标
        var areasData = [];


        for(var i=0;i< size;i++) {
            var area = '', points = [];

            for(var k=0;k < total;k++) {
                var type = types[k];
                var value = data[type];
                var r = radius * (value[i] - rangeMin[type])/(rangeMax[type] - rangeMin[type]);
                var x = r * Math.sin(k * onePiece),
                        y = r * Math.cos(k * onePiece);
                area += x + ',' + y + ' ';
                points.push({
                    x: x,
                    y: y
                })
            }
            areasData.push({
                polygon: area,
                points: points
            });
        }

        console.info(areasData);

        var colors = d3.scale.category10();

        // 添加g分组包含所有雷达图区域
        var areas = main.append('g')
                .classed('areas', true);
        // 添加g分组用来包含一个雷达图区域下的多边形以及圆点
        areas.selectAll('g')
                .data(areasData)
                .enter()
                .append('g')
                .attr('class',function(d, i) {
                    return 'area' + (i+1);
                });

        for(var i=0;i<areasData.length;i++) {
            // 依次循环每个雷达图区域
            var area = areas.select('.area' + (i+1)),
                    areaData = areasData[i];

            var trait = data["species"];

            var color = colors(trait[i]);
//            console.info(trait[i]);
//            console.info(color);



            // 绘制雷达图区域下的多边形
            area.append('polygon')
                    .attr('stroke', function(d, index) {
                        return color;
                    })
                    .attr('fill', function(d, index) {
                        return color;
                    })
                    .attr('points',origns)
                    .transition()
                    .duration(4000)
                    .attr('points', areaData.polygon);
            // 绘制雷达图区域下的点
            var circles = area.append('g')
                    .classed('circles', true);
            circles.selectAll('circle')
                    .data(areaData.points)
                    .enter()
                    .append('circle')
                    .attr('stroke', function(d, index) {
                        return color;
                    })
                    .attr('cx',0)
                    .attr('cy',0)
                    .attr('r', 0)
                    .transition()
                    .duration(4000)
                    .attr('cx', function(d) {
                        return d.x;
                    })
                    .attr('cy', function(d) {
                        return d.y;
                    })
                    .attr('r', 3);

        }
        // 计算文字标签坐标
        var textPoints = [];
        var textRadius = radius + 20;
        for(var i=0;i<total;i++) {
            var x = textRadius * Math.sin(i * onePiece),
                    y = textRadius * Math.cos(i * onePiece);
            textPoints.push({
                x: x,
                y: y
            });
        }

        // 绘制文字标签
        var texts = main.append('g')
                .classed('texts', true);
        texts.selectAll('text')
                .data(textPoints)
                .enter()
                .append('text')
                .attr('x', function(d) {
                    return d.x - 20;
                })
                .attr('y', function(d) {
                    return d.y;
                })
                .text(function(d,i) {
                    return types[i];
                });




        var legend = svg.selectAll("g.legend")
                .data(species)
                .enter().append("svg:g")
                .attr("class", "legend")
                .attr("transform", function(d, i) {
                    return "translate(500," + (i * 20 + 530) + ")";
                });

        legend.append("svg:circle")
                .attr("fill", function(d) {

                    console.log(speciesMap[d]);
                    return colors(speciesMap[d]);

                })
                .attr("r", 3);

        legend.append("svg:text")
                .attr("x", 12)
                .attr("dy", ".31em")
                .text(function(d) {

                    return "species : " + d;

                });
        });

        <%--d3.csv("${ctx}/visualization-admin/resource/data/bank-without-data.csv", function(error, csv) {--%>

        <%--});--%>

    }


    $(function () {
//        traits = ["job", "marital", "default", "balance", "housing", "loan"];
//        $('#type').selectpicker('val', "card");
//        console.info($('#type').val());
//        traits = ($('#type').val());

        draw();
    });

//    function redraw() {
//        d3.select("#body").select("svg").remove();
//
//        draw($('#type').val());
//
//    }


</script>

</html>