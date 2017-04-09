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
    <style>

        h1,body,html,#container, .section{
            padding: 0;
            margin: 0;
        }

        body{
            font-family: Arial,"Microsoft YaHei","Hiragino Sans GB",sans-serif;
        }
        html,body{
            height: 100%;
            overflow: hidden;
        }
        h1{
            font-size: 6em;
            font-weight: normal;
        }
        p{
            font-size: 2em;
            margin:0.5em 0 2em 0;
        }

        #container,.section{
            height: 100%;
            width: 100%;
            position: relative;
        }

        #section0{
            background-image: url(${ctx}/visualization-admin/resource/img/background0.jpg);
            color: #fff;
            text-shadow:1px 1px 1px #333;
        }
        #section1{
            color: #fff;
            text-shadow:1px 1px 1px #333;
            background-image: url(${ctx}/visualization-admin/resource/img/background.jpg);
        }
        #section2{
            background-image: url(${ctx}/visualization-admin/resource/img/background.jpg);
            color: #fff;
            text-shadow:1px 1px 1px #666;
        }
        #section3{
            color: #008283;
            background-image: url(${ctx}/visualization-admin/resource/img/background.jpg);
            text-shadow:1px 1px 1px #fff;
        }
        #section4{
            color: #008283;
            background-image: url(${ctx}/visualization-admin/resource/img/end.jpg);
            text-shadow:1px 1px 1px #fff;
        }
        #pages{
            position:fixed;
            right: 10px;
            top: 50%;
            list-style: none;
        }
        #pages li{
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #fff;
            margin: 0 0 10px 5px;
        }
        #pages li.active{
            width: 14px;
            height: 14px;
            border: 2px solid #FFFE00;
            background: none;
            margin-left: 0;
        }
        .intro{
            position: absolute;
            top: 50%;
            width: 100%;
            -webkit-transform: translateY(-50%);
            transform: translateY(-50%);
            text-align: center;
        }
        .intro span{
            padding-left: 200px;
            padding-right: 200px;
        }
        #section0 .title{
            -webkit-transform: translateX(-100%);
            transform: translateX(-100%);
            -webkit-animation: sectitle0 1s ease-in-out 100ms forwards;
            animation: sectitle0 1s ease-in-out 100ms forwards;
        }
        #section0 p{
            -webkit-transform: translateX(100%);
            transform: translateX(100%);
            -webkit-animation: sec0 1s ease-in-out 100ms forwards;
            animation: sec0 1s ease-in-out 100ms forwards;
        }
        #section1 .col-sm-5{
            -webkit-transform: translateX(-100%);
            transform: translateX(-100%);
            -webkit-animation: sectitle0 4s ease-in-out 100ms forwards;
            animation: sectitle0 4s ease-in-out 100ms forwards;
        }
        #section2 .col-sm-5{
            -webkit-transform: translateX(-100%);
            transform: translateX(-100%);
            -webkit-animation: sectitle0 7s ease-in-out 100ms forwards;
            animation: sectitle0 7s ease-in-out 100ms forwards;
        }
        #section3 .col-sm-3{
            -webkit-transform: translateX(-100%);
            transform: translateX(-100%);
            -webkit-animation: sectitle0 9s ease-in-out 100ms forwards;
            animation: sectitle0 9s ease-in-out 100ms forwards;
        }

        @-webkit-keyframes sectitle0{
            0%{
                -webkit-transform: translateX(-100%);
                transform: translateX(-100%);
            }
            100%{
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }
        }
        @keyframes sectitle0{
            0%{
                -webkit-transform: translateX(-100%);
                transform: translateX(-100%);
            }
            100%{
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }
        }
        @-webkit-keyframes sec0{
            0%{
                -webkit-transform: translateX(100%);
                transform: translateX(100%);
            }
            100%{
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }
        }
        @keyframes sec0{
            0%{
                -webkit-transform: translateX(100%);
                transform: translateX(100%);
            }
            100%{
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }
        }
    </style>
</head>
<body>
    <%--<jsp:include page="${ctx}/common/error.jsp"></jsp:include>--%>
    <%--<p>Apple</p>--%>
    <%--<p id="myid">Pear</p>--%>
    <%--<p>Banana</p>--%>



    <div class="container" id="container">
        <div class="section active" id="section0">

            <div class="intro">
                <h1 class="title">D3.js 高维可视化</h1>
                <p>D3.js是一个JavaScript库，它可以通过数据来操作文档。</p>
                <p>D3可以通过使用HTML、SVG和CSS把数据鲜活形象地展现出来。</p>
            </div>
        </div>
        <div class="section" id="section1">
            <div class="intro">
                <%--<h1 class="title">Example</h1>--%>
                <p>简单可视化方法</p>

                <div class="col-sm-3">
                    <div style="text-align: center">
                        <a href="${ctx}/visualization-admin/view?type=scatterPlot">
                            <img src="${ctx}/visualization-admin/resource/img/ScatterPlot.png" style="margin: auto;width: 400px;height: 300px;">
                            <br>
                             <span style="margin: auto">ScatterPlot</span>
                        </a>
                    </div>
                </div>
                    <div class="col-sm-1"></div>
                    <%--多曲线图矩阵--%>
                    <div class="col-sm-3">
                        <div style="text-align: center">
                            <a href="${ctx}/visualization-admin/view?type=mutilLine">
                                <img src="${ctx}/visualization-admin/resource/img/MutilLine.png" style="margin: auto;width: 400px;height: 300px;">
                                <br>
                                <span style="margin: auto">MutilLine</span>
                            </a>
                        </div>
                    </div>
                    <div class="col-sm-1"></div>
                    <%--圆形分段技术--%>
                    <div class="col-sm-3">
                        <div style="text-align: center">
                            <a href="${ctx}/visualization-admin/view?type=circle">
                                <img src="${ctx}/visualization-admin/resource/img/CircleSegment.png" style="margin: auto;width: 400px;height: 300px;">
                                <br>
                                <span style="margin: auto">CircleSegment</span>
                            </a>
                        </div>
                    </div>

            </div>

        </div>
        <div class="section" id="section2">
            <div class="intro">
                <%--<h1 class="title">Example</h1>--%>
                    <p>坐标轴可视化方法</p>
                    <%--平行坐标图--%>
                    <div class="col-sm-3">
                        <div style="text-align: center">
                            <a href="${ctx}/visualization-admin/view?type=parallelCoordinates">
                                <img src="${ctx}/visualization-admin/resource/img/ParallelCoordinates.png" style="margin: auto;width: 400px;height: 300px;">
                                <br>
                                <span style="margin: auto">ParallelCoordinates</span>
                            </a>
                        </div>
                    </div>

                    <div class="col-sm-1"></div>
                    <%--平行坐标图--%>
                    <div class="col-sm-3">
                       <div style="text-align: center">
                          <a href="${ctx}/visualization-admin/view?type=parallelSet">
                             <img src="${ctx}/visualization-admin/resource/img/ParallelSet.png" style="margin: auto;width: 400px;height: 300px;">
                             <br>
                              <span style="margin: auto">ParallelSet</span>
                          </a>
                       </div>
                    </div>
                    <div class="col-sm-1"></div>
                    <%--星形图矩阵--%>
                    <div class="col-sm-3">
                        <div style="text-align: center">
                            <a href="${ctx}/visualization-admin/view?type=rundar">
                                <img src="${ctx}/visualization-admin/resource/img/CircularParallelCoordinates.png" style="margin: auto;width: 400px;height: 300px;">
                                <br>
                                <span style="margin: auto">Rundar</span>
                            </a>
                        </div>
                    </div>
            </div>
        </div>
        <div class="section" id="section3">
            <div class="intro">
                <p>其他可视化方法</p>
                <div class="col-sm-1"></div>
                <%--surveyPlot--%>
                <div class="col-sm-5">
                    <div style="text-align: center">
                        <a href="${ctx}/visualization-admin/view?type=surveyPlot">
                            <img src="${ctx}/visualization-admin/resource/img/SurveyPlot.png" style="margin: auto;width: 400px;height: 300px;">
                            <br>
                            <span style="margin: auto">SurveyPlot</span>
                        </a>
                    </div>
                </div>
                <div class="col-sm-1"></div>
                <%--surveyPlot--%>
                <div class="col-sm-5">
                    <div style="text-align: center">
                        <a href="${ctx}/visualization-admin/view?type=chernoffFace">
                            <img src="${ctx}/visualization-admin/resource/img/Chernoff faces.png" style="margin: auto;width: 400px;height: 300px;">
                            <br>
                            <span style="margin: auto">ChernoffFace</span>
                        </a>
                    </div>
                </div>

            </div>
        </div>
        <div class="section" id="section4">
            <div class="intro">
                <h1 class="title">THE END</h1>
                <p>可视化技术仍在发展，不同场景下应选择合适的可视化技术，扬长避短</p>


            </div>
        </div>



        <%--<table class="table" style="margin-top: 50px;">--%>
            <%--<tr>--%>
                <%--<td>--%>
                    <%--&lt;%&ndash;散点图矩阵&ndash;%&gt;--%>
                    <%--<div style="text-align: center">--%>
                        <%--<a href="${ctx}/visualization-admin/view?type=scatterPlot">--%>
                            <%--<img src="${ctx}/visualization-admin/resource/img/ScatterPlot.png" style="margin: auto;width: 400px;height: 300px;">--%>
                            <%--<br>--%>
                            <%--<span style="margin: auto">Scatter Plot</span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--&lt;%&ndash;平行坐标图&ndash;%&gt;--%>
                    <%--<div style="text-align: center">--%>
                        <%--<a href="${ctx}/visualization-admin/view?type=parallelCoordinates">--%>
                            <%--<img src="${ctx}/visualization-admin/resource/img/ParallelCoordinates.png" style="margin: auto;width: 400px;height: 300px;">--%>
                            <%--<br>--%>
                            <%--<span style="margin: auto">Parallel Coordinates</span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td>--%>
                    <%--&lt;%&ndash;多曲线图矩阵&ndash;%&gt;--%>
                    <%--<div style="text-align: center">--%>
                        <%--<a href="${ctx}/visualization-admin/view?type=mutilLine">--%>
                            <%--<img src="${ctx}/visualization-admin/resource/img/MutilLine.png" style="margin: auto;width: 400px;height: 300px;">--%>
                            <%--<br>--%>
                            <%--<span style="margin: auto">MutilLine</span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--&lt;%&ndash;平行坐标图&ndash;%&gt;--%>
                    <%--<div style="text-align: center">--%>
                        <%--<a href="${ctx}/visualization-admin/view?type=parallelSet">--%>
                            <%--<img src="${ctx}/visualization-admin/resource/img/ParallelSet.png" style="margin: auto;width: 400px;height: 300px;">--%>
                            <%--<br>--%>
                            <%--<span style="margin: auto">Parallel Set</span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td>--%>
                    <%--&lt;%&ndash;星形图矩阵&ndash;%&gt;--%>
                    <%--<div style="text-align: center">--%>
                        <%--<a href="${ctx}/visualization-admin/view?type=rundar">--%>
                            <%--<img src="${ctx}/visualization-admin/resource/img/CircularParallelCoordinates.png" style="margin: auto;width: 400px;height: 300px;">--%>
                            <%--<br>--%>
                            <%--<span style="margin: auto">MutilLine</span>--%>
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
            <%--<tr>--%>
                <%--<td>--%>
                    <%--&lt;%&ndash;surveyPlot&ndash;%&gt;--%>
                    <%--<div style="text-align: center">--%>
                        <%--<a href="${ctx}/visualization-admin/view?type=surveyPlot">--%>
                            <%--<img src="${ctx}/visualization-admin/resource/img/SurveyPlot.png" style="margin: auto;width: 400px;height: 300px;">--%>
                            <%--<br>--%>
                            <%--<span style="margin: auto">surveyPlot</span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</td>--%>
                <%--&lt;%&ndash;<td>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;&lt;%&ndash;圆形分段技术&ndash;%&gt;&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<div style="text-align: center">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<a href="${ctx}/visualization-admin/view?type=circle">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<img src="${ctx}/visualization-admin/resource/img/CircleSegment.png" style="margin: auto;width: 400px;height: 300px;">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<br>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<span style="margin: auto">Circle Segment</span>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</a>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</td>&ndash;%&gt;--%>
            <%--</tr>--%>
        <%--</table>--%>
    </div>

</body>
<script>
    $(function(){
        $("#container").switchPage({
            'loop' : true,
            'keyboard' : true,
            'duration' : 1000,//每次动画执行的时间
//            'direction' : 'horizontal',//滑动的方向 horizontal,vertical,

        });
    });


//    var svg3 = d3.select(".container")
//            .append("svg")
//            .attr("width", 800)
//            .attr("height", 600);
//
//    //数据
//    var nodes = [ { name: "scatterPlot" }, { name: "Parallel Coordinates" },
//                    { name: "rundar" }, { name: "mutilLine" },
//                    { name: "parallelSet" }, { name: "CircleSegment" },
//                    { name: "surveyPlot" } ];
//
//    var edges = [ { source : 0 , target: 1 } , { source : 0 , target: 3 } ,
//        { source : 1 , target: 4 } , { source : 1 , target: 4 } ,
//        { source : 2 , target: 5 } , { source : 3 , target: 6 } ];
//
//    //布局（数据转换）
//    var force = d3.layout.force()
//            .nodes(nodes)       //指定节点数组
//            .links(edges)       //指定连线数组
//            .size([800, 600])     //指定作用域范围
//            .linkDistance(250)      //指定连线长度
//            .charge([-500]);        //相互之间的作用力
//
//    force.start();          //开始作用
//
//    console.log(nodes);
//    console.log(edges);
//
//    //绘制
//    //添加连线
//    var svg_edges = svg3.selectAll("line")
//            .data(edges)
//            .enter()
//            .append("line")
//            .style("stroke", "#ccc")
//            .style("stroke-width",5);
//
//     color = d3.scale.category20();
//
//    //添加节点
//    var svg_nodes = svg3.selectAll("circle")
//            .data(nodes)
//            .enter()
//            .append("circle")
//            .attr("r", 50)
//            .style("fill", function (d, i) {
//                return color(i);
//
//            })
//            .call(force.drag);          //使节点能够拖动
//
//    //添加节点描述
//    var svg_text = svg3.selectAll("text")
//            .data(nodes)
//            .enter()
//            .append("text")
//            .style("fill","black")
//            .attr("dx", 20)
//            .attr("dy", 8)
//            .text(function (d) {
//                return d.name;
//            });
//
//    force.on("tick",function () {
//        //对于每一个时间间隔更新
//        svg_edges.attr("x1",function (d) {
//            return d.source.x;
//        })
//                .attr("y1",function (d) {
//                    return d.source.y;
//                })
//                .attr("x2",function (d) {
//                    return d.target.x;
//                })
//                .attr("y2",function (d) {
//                    return d.target.y;
//                });
//
//        //更新节点坐标
//        svg_nodes.attr("cx",function (d) {
//            return d.x;
//        })
//                .attr("cy",function (d) {
//                    return d.y;
//                });
//
//        //更新文字坐标
//        svg_text.attr("x",function (d) {
//            return d.x;
//
//        })
//                .attr("y", function (d) {
//                    return d.y;
//                });
//
//    })


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
