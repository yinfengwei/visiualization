<%--
  Created by IntelliJ IDEA.
  User: yinfeng
  Date: 2016/11/3 0003
  Time: 23:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>D3.js 高维数据可视化</title>
    <jsp:include page="${ctx}/common/head.jsp"></jsp:include>
    <%--<style>--%>
        <%--.axis path,--%>
        <%--.axis line{--%>
            <%--fill: none;--%>
            <%--stroke: black;--%>
            <%--shape-rendering: crispEdges;--%>
        <%--}--%>

        <%--.axis text {--%>
            <%--font-size: 11px;--%>
            <%--font-family: sans-serif;--%>
        <%--}--%>
    <%--</style>--%>
</head>
<body>
    <jsp:include page="${ctx}/common/error.jsp"></jsp:include>
    <%--<p>Apple</p>--%>
    <%--<p id="myid">Pear</p>--%>
    <%--<p>Banana</p>--%>


    <div class="container">
        <div style="text-align: center;margin-top: 30px;">
            <h1 style="margin: auto;">D3.js 高维可视化</h1>
        </div>

        <table class="table" style="margin-top: 50px;">
            <tr>
                <td>
                    <%--散点图矩阵--%>
                    <div style="text-align: center">
                        <a href="${ctx}/visualization-admin/view?type=scatterPlot">
                            <img src="${ctx}/visualization-admin/resource/img/ScatterPlot.png" style="margin: auto;width: 400px;height: 300px;">
                            <br>
                            <span style="margin: auto">Scatter Plot</span>
                        </a>
                    </div>
                </td>
                <td>
                    <%--平行坐标图--%>
                    <div style="text-align: center">
                        <a href="${ctx}/visualization-admin/view?type=parallelCoordinates">
                            <img src="${ctx}/visualization-admin/resource/img/ParallelCoordinates.png" style="margin: auto;width: 400px;height: 300px;">
                            <br>
                            <span style="margin: auto">Parallel Coordinates</span>
                        </a>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <%--多曲线图矩阵--%>
                    <div style="text-align: center">
                        <a href="${ctx}/visualization-admin/view?type=mutilLine">
                            <img src="${ctx}/visualization-admin/resource/img/MutilLine.png" style="margin: auto;width: 400px;height: 300px;">
                            <br>
                            <span style="margin: auto">MutilLine</span>
                        </a>
                    </div>
                </td>
                <td>
                    <%--平行坐标图--%>
                    <div style="text-align: center">
                        <a href="${ctx}/visualization-admin/view?type=parallelSet">
                            <img src="${ctx}/visualization-admin/resource/img/ParallelSet.png" style="margin: auto;width: 400px;height: 300px;">
                            <br>
                            <span style="margin: auto">Parallel Set</span>
                        </a>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <%--星形图矩阵--%>
                    <div style="text-align: center">
                        <a href="${ctx}/visualization-admin/view?type=rundar">
                            <img src="${ctx}/visualization-admin/resource/img/CircularParallelCoordinates.png" style="margin: auto;width: 400px;height: 300px;">
                            <br>
                            <span style="margin: auto">MutilLine</span>
                        </a>
                    </div>
                </td>
                <td>
                    <%--圆形分段技术--%>
                    <div style="text-align: center">
                        <a href="${ctx}/visualization-admin/view?type=circle">
                            <img src="${ctx}/visualization-admin/resource/img/CircleSegment.png" style="margin: auto;width: 400px;height: 300px;">
                            <br>
                            <span style="margin: auto">Circle Segment</span>
                        </a>
                    </div>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<td>--%>
                    <%--&lt;%&ndash;surveyPlot&ndash;%&gt;--%>
                    <%--<div style="text-align: center">--%>
                        <%--<a href="${ctx}/visualization-admin/view?type=surveyPlot">--%>
                            <%--<img src="${ctx}/visualization-admin/resource/img/CircleSegment.png" style="margin: auto;width: 400px;height: 300px;">--%>
                            <%--<br>--%>
                            <%--<span style="margin: auto">surveyPlot</span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--&lt;%&ndash;圆形分段技术&ndash;%&gt;--%>
                    <%--<div style="text-align: center">--%>
                        <%--<a href="${ctx}/visualization-admin/view?type=circle">--%>
                            <%--<img src="${ctx}/visualization-admin/resource/img/CircleSegment.png" style="margin: auto;width: 400px;height: 300px;">--%>
                            <%--<br>--%>
                            <%--<span style="margin: auto">Circle Segment</span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>
        </table>
    </div>

</body>
<script>
//    var str = "China";
//
//    var body = d3.select("body");
//    var p = body.selectAll("p");
//
//    //绑定单个数据
////    //绑定数据到DOM
////    p.datum(str);
////
////    //d代表绑定的数据
////    p.text(function (d, i) {
////        return "第" + i + "个元素绑定的数据是" + d;
////    })
//
////    //绑定数组
////    var dataset = ["I like dogs", "I like cats", "I like snake"];
////    p.data(dataset).text(function (d,i) {
////        return d;
////    })
//
//    //添加元素
//    body.append("p").text("append p element");
//
//    //在特定元素前添加
//    body.insert("p","#myid").text("insert p element");
//
//    //删除元素
//    var pr = body.select("#myid");
//    pr.remove();

//    //画布，普通画布
//    var width = 300;        //宽度
//    var height = 300;       //高度
//
//    var svg = d3.select("body")
//            .append("svg")
//            .attr("width",width)
//            .attr("height", height);
//
//    var dataset = [250, 210, 170, 130, 90];         //数据（宽度）
//
//    var rectHeight = 25;        //矩形所占的像素高度
//
//    svg.selectAll("rect")
//            .data(dataset)
//            .enter()
//            .append("rect")      //绑定数据
//            .attr("x",20)
//            .attr("y",function (d, i) {
//                return i * rectHeight;
//            })
//            .attr("width",function (d) {
//                return d;
//            })
//            .attr("height", rectHeight-2)
//            .attr("fill","steelblue");

    //比例尺
//    var dataset = [1.2, 2.3, 0.9, 1.5, 3.3];
//
//    var min = d3.min(dataset);
//    var max = d3.max(dataset);
//
//    var linear = d3.scale.linear()    //返回线性比例尺
//            .domain([min, max])        //设置比例尺的定义域，也就原始数据
//            .range([0, 300]);           //设置值域，就是映射数据
//
//    alert(linear(0.9));
//    alert(linear(2.3));
//    alert(linear(2.5));

//    //序数比例尺 -- 一一对应计算，不是定义域内变量则默认为第一个即0对应的color
//    var index = [0, 1, 2, 3, 4];
//    var color = ["red", "blue", "green", "yellow", "black"];
//
//    var ordinal = d3.scale.ordinal()
//            .domain(index)
//            .range(color);
//
//    alert(ordinal(0));
//    alert(ordinal(2));
//    alert(ordinal(6));


//    //比例尺与柱形图结合、坐标轴
//    var width = 300;        //宽度
//    var height = 300;       //高度
//
//    var svg = d3.select("body")
//            .append("svg")
//            .attr("width",width)
//            .attr("height", height);
//
//    var dataset = [2.5, 2.1, 1.7, 1.3, 0.9];
//
//    //比例尺
//    var linear = d3.scale.linear()
//            .domain([0, d3.max(dataset)])
//            .range([0, 250]);
//
//    //坐标轴
//    var axis = d3.svg.axis()            //生成坐标轴
//            .scale(linear)      //指定比例尺
//            .orient("bottom")   //刻度方向
//            .ticks(7);           //制定刻度的数量
//
//    //将坐标轴添加到画布中
//    svg.append("g")
//            .attr("class","axis")
//            .attr("transform", "translate(20, 130)")
//            .call(axis);
//
//    var rectHeight = 25;
//
//    svg.selectAll("rect")
//            .data(dataset)
//            .enter()
//            .append("rect")
//            .attr("x", 20)
//            .attr("y", function (d, i) {
//                return i * rectHeight;
//
//            })
//            .attr("width", function (d) {
//                return linear(d);
//
//            })
//            .attr("height", rectHeight - 2)
//            .attr("fill", "steelblue");

    //完整的柱形图
    //1 .添加画布
//    var width = 400;
//    var height = 400;
//
//    //2. 在body 中添加一个SVG画布
//    var svg = d3.select("body")
//            .append("svg")
//            .attr("width", width)
//            .attr("height", height);
//
//    //画布周边的空白
//    var padding = {left:30, right:30, top:20, bottom:20};
//
//    //3. 定义数据和比例尺
//    var dataset = [10, 20, 30, 40, 33, 24, 12, 5];
//
//    //x轴比例尺
//    var xScale = d3.scale.ordinal()     //序数比例尺
//            .domain(d3.range(dataset.length))
//            .rangeRoundBands([0, width - padding.left - padding.right]);
//
//    //y轴比例尺
//    var yScale = d3.scale.linear()      //线性比例尺
//            .domain([0,d3.max(dataset)])
//            .range([height - padding.top - padding.bottom, 0]);
//
//    //4. 定义坐标轴
//    var xAxis = d3.svg.axis()
//            .scale(xScale)
//            .orient("bottom");
//
//    //定义y轴
//    var yAxis = d3.svg.axis()
//            .scale(yScale)
//            .orient("left");
//
//    //5 添加矩形与文字元素
//    //矩形之间的空白
//    var rectPadding = 4;
//
//    //添加矩形元素
//    var rects = svg.selectAll(".MyRect")
//            .data(dataset)
//            .enter()
//            .append("rect")
//            .attr("class", "MyRect")
//            .attr("transform", "translate(" + padding.left + "," + padding.top + ")")
//            .attr("x", function (d, i) {
//                return xScale(i) + rectPadding/2;
//
//            })
//            .attr("y", function (d) {
//                return yScale(d);
//
//            })
//            .attr("width", xScale.rangeBand() - rectPadding)
//            .attr("height", function (d) {
//                return height - padding.top - padding.bottom - yScale(d);
//
//            })
//            .attr("fill", "steelblue")
//            .on("mouseover",function (d, i) {
//                d3.select(this)
//                        .attr("fill", "yellow");
//            })
//            .on("mouseout", function (d, i) {
//                d3.select(this)
//                        .transition()
//                        .duration(500)
//                        .attr("fill", "steelblue");
//
//            })
//            .transition()
//            .duration(1000)
//            .delay(500)
//            .attr("fill", "red");
//
//    //文字元素
//    var texts = svg.selectAll(".MyText")
//            .data(dataset)
//            .enter()
//            .append("text")
//            .attr("class", "MyText")
//            .attr("transform", "translate(" + padding.left + "," + padding.top + ")")
//            .attr("x", function (d, i) {
//                return xScale(i) + rectPadding/2 - 5;
//
//            })
//            .attr("y", function (d) {
//                var min = yScale.domain()[0];
//                return yScale(min) ;
//
//            })
//            .transition()
//            .delay(function (d, i) {
//                return 200 * i;
//            })
//            .duration(2000)
//            .ease("bounce")
//            .attr("y", function (d) {
//                return yScale(d) ;
//
//            })
//            .attr("dx", function () {
//                return (xScale.rangeBand() - rectPadding)/2;
//
//            })
//            .attr("dy", function (d) {
//                return 20;
//
//            })
//            .text(function (d) {
//                return d;
//
//            });
//
//    //6. 添加x轴
//    svg.append("g")
//            .attr("class", "axis")
//            .attr("transform", "translate(" + padding.left + "," + (height - padding.bottom) + ")")
//            .call(xAxis);
//    svg.append("g")
//            .attr("class", "axis")
//            .attr("transform", "translate(" + padding.left + "," + padding.top + ")")
//            .call(yAxis);
//
//    //动态效果
//    var svg1 = d3.select("body")
//            .append("svg")
//            .attr("height",400)
//            .attr("width", 400);
//
//    //动态效果
//    var circle = svg1.append("circle")
//            .attr("cx", 200)
//            .attr("cy", 200)
//            .attr("r", 100)
//            .attr("fill", "green");
//
//    circle.transition()
//            .duration(1000)
//            .attr("cx", 300)
//            .attr("fill", "red")
//            .attr("r", 25);
//
//    circle.on("click", function () {
//        alert(d3.event);
//    })
//
//
//    //饼图
//
//    var svg2 = d3.select("body")
//            .append("svg")
//            .attr("height",400)
//            .attr("width", 400);
//
//    var dataset1 = [30, 10, 43, 55, 13];
//
//    //布局
//    var pie = d3.layout.pie();
//
//    //数据转化
//    var piedata = pie(dataset);
//
//    //弧生成器
//    var outerRadius = 150;      //外半径
//    var innerRadius = 0;        //内半径
//
//    //弧生成器
//    var arc = d3.svg.arc()      //弧生成器
//            .innerRadius(innerRadius)
//            .outerRadius(outerRadius);
//
//    //添加图形元素
//    var arcs = svg2.selectAll("g")
//            .data(piedata)
//            .enter()
//            .append("g")
//            .attr("transform", "translate(" + (400/2) + "," + (400/2) + ")");
//
//    //颜色
//    var color = d3.scale.category10();
//
//    //调用弧生成器，添加路径
//    arcs.append("path")
//            .attr("fill", function (d, i) {
//                return color(i);
//            })
//            .attr("d", function (d) {
//                return arc(d);
//            });
//
//    //添加数据显示
//    arcs.append("text")
//            .attr("transform",function (d) {
//                return "translate(" + arc.centroid(d) + ")";
//            })
//            .attr("text-anchor", "middle")
//            .text(function (d) {
//                return d.data;
//            });
//
//
    //力导向图
    var svg3 = d3.select(".container")
            .append("svg")
            .attr("width", 800)
            .attr("height", 600);

    //数据
    var nodes = [ { name: "scatterPlot" }, { name: "Parallel Coordinates" },
                    { name: "rundar" }, { name: "mutilLine" },
                    { name: "parallelSet" }, { name: "青岛" },
                    { name: "天津" } ];

    var edges = [ { source : 0 , target: 1 } , { source : 0 , target: 2 } ,
        { source : 0 , target: 3 } , { source : 1 , target: 4 } ,
        { source : 1 , target: 5 } , { source : 1 , target: 6 } ];

    //布局（数据转换）
    var force = d3.layout.force()
            .nodes(nodes)       //指定节点数组
            .links(edges)       //指定连线数组
            .size([800, 600])     //指定作用域范围
            .linkDistance(250)      //指定连线长度
            .charge([-500]);        //相互之间的作用力

    force.start();          //开始作用

    console.log(nodes);
    console.log(edges);

    //绘制
    //添加连线
    var svg_edges = svg3.selectAll("line")
            .data(edges)
            .enter()
            .append("line")
            .style("stroke", "#ccc")
            .style("stroke-width",2);

     color = d3.scale.category20();

    //添加节点
    var svg_nodes = svg3.selectAll("circle")
            .data(nodes)
            .enter()
            .append("circle")
            .attr("r", 20)
            .style("fill", function (d, i) {
                return color(i);

            })
            .call(force.drag);          //使节点能够拖动

    //添加节点描述
    var svg_text = svg3.selectAll("text")
            .data(nodes)
            .enter()
            .append("text")
            .style("fill","black")
            .attr("dx", 20)
            .attr("dy", 8)
            .text(function (d) {
                return d.name;
            });

    force.on("tick",function () {
        //对于每一个时间间隔更新
        svg_edges.attr("x1",function (d) {
            return d.source.x;
        })
                .attr("y1",function (d) {
                    return d.source.y;
                })
                .attr("x2",function (d) {
                    return d.target.x;
                })
                .attr("y2",function (d) {
                    return d.target.y;
                });

        //更新节点坐标
        svg_nodes.attr("cx",function (d) {
            return d.x;
        })
                .attr("cy",function (d) {
                    return d.y;
                });

        //更新文字坐标
        svg_text.attr("x",function (d) {
            return d.x;

        })
                .attr("y", function (d) {
                    return d.y;
                });

    })


    //弦图
//
//    var city_name = [ "北京" , "上海" , "广州" , "深圳" , "香港"  ];
//
//    var population = [
//        [ 1000,  3045　 , 4567　, 1234 , 3714 ],
//        [ 3214,  2000　 , 2060　, 124  , 3234 ],
//        [ 8761,  6545　 , 3000　, 8045 , 647  ],
//        [ 3211,  1067  , 3214 , 4000  , 1006 ],
//        [ 2146,  1034　 , 6745 , 4764  , 5000 ]
//    ];
//
//    var chord_layout = d3.layout.chord()
//            .padding(0.03) //节点之间的间隔
//            .sortSubgroups(d3.descending) //排序
//            .matrix(population); //输入矩阵
//
//    var groups = chord_layout.groups();
//    var chords = chord_layout.chords();
//
//
//    console.log( groups );
//    console.log( chords );
//
//     var width = 600;
//     var height = 600;
//     var innerRadius = width/2 * 0.7;
//     var outerRadius = innerRadius * 1.1;
//
//    var color20 = d3.scale.category20();
//
//    var svg = d3.select("body").append("svg")
//            .attr("width", width)
//            .attr("height", height)
//            .append("g")
//            .attr("transform", "translate(" + width/2 + "," + height/2 + ")");
//
//    var outer_arc = d3.svg.arc()
//            .innerRadius(innerRadius)
//            .outerRadius(outerRadius);
//
//    var g_outer = svg.append("g");
//
//    g_outer.selectAll("path")
//            .data(groups)
//            .enter()
//            .append("path")
//            .style("fill", function(d) { return color20(d.index); })
//            .style("stroke", function(d) { return color20(d.index); })
//            .attr("d", outer_arc );
//
//    g_outer.selectAll("text")
//            .data(groups)
//            .enter()
//            .append("text")
//            .each( function(d,i) {
//                d.angle = (d.startAngle + d.endAngle) / 2;
//                d.name = city_name[i];
//            })
//            .attr("dy",".35em")
//            .attr("transform", function(d){
//                return "rotate(" + ( d.angle * 180 / Math.PI ) + ")" +
//                        "translate(0,"+ -1.0*(outerRadius+10) +")" +
//                        ( ( d.angle > Math.PI*3/4 && d.angle < Math.PI*5/4 ) ? "rotate(180)" : "");
//            })
//            .text(function(d){
//                return d.name;
//            });
//    var inner_chord = d3.svg.chord()
//            .radius(innerRadius);
//
//    svg.append("g")
//            .attr("class", "chord")
//            .selectAll("path")
//            .data(chords)
//            .enter()
//            .append("path")
//            .attr("d", inner_chord )  //
//            .style("fill", function(d) { return color20(d.source.index); })
//            .style("opacity", 1)
//            .on("mouseover",function(d,i){
//                d3.select(this)
//                        .style("fill","yellow");
//            })
//            .on("mouseout",function(d,i) {
//                d3.select(this)
//                        .transition()
//                        .duration(1000)
//                        .style("fill",color20(d.source.index));
//            });


    //集群图布局

    <%--var width = 400;--%>
    <%--var height = 400;--%>
    <%--var cluster = d3.layout.cluster()--%>
            <%--.size([width,height - 200]);--%>

    <%--d3.json("${ctx}/visualization-admin/views/city.json", function (error, root) {--%>
        <%--var nodes = cluster.nodes(root);--%>
        <%--var links = cluster.links(nodes);--%>

        <%--console.log(nodes);--%>
        <%--console.log(links);--%>
    <%--})--%>

    <%--var diagonal = d3.svg.diagonal()--%>
        <%--.projection(function(d) { return [d.y, d.x]; });--%>

    <%--var link = svg.selectAll(".link")--%>
            <%--.data(links)--%>
            <%--.enter()--%>
            <%--.append("path")--%>
            <%--.attr("class", "link")--%>
            <%--.attr("d", diagonal);   //使用对角线生成器--%>

    <%--//读取文件--%>
    <%--d3.csv("${ctx}/visualization-admin/resource/data/flowers.csv",function(error,csvdata){--%>

        <%--if(error){--%>
            <%--console.log(error);--%>
        <%--}--%>
        <%--console.log(csvdata);--%>

        <%--for( var i=0; i<csvdata.length; i++ ){--%>
            <%--var sLength = csvdata[i]["sepal length"];--%>
            <%--var sWidth = csvdata[i]["sepal width"];--%>
            <%--var pLength = csvdata[i]["petal length"];--%>
            <%--var pWidth = csvdata[i]["petal width"];--%>
            <%--var species = csvdata[i].species;--%>
            <%--console.log( "sLength: " + sLength + "\n" +--%>
                    <%--"sWidth: " + sWidth + "\n" +--%>
                    <%--"pLength: " + pLength + "\n" +--%>
                    <%--"pWidth: " + pWidth + "\n" +--%>
                    <%--"species: " + species  );--%>
        <%--}--%>

    <%--});--%>












</script>

</html>
