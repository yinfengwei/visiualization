<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>工程</title>
    <jsp:include page="${ctx}/common/head.jsp"></jsp:include>
    <style>
        /*.axis path,*/
        /*.axis line{*/
            /*fill:none;*/
            /*stroke:black;*/
            /*shape-rendering:crispEdges;*/
        /*}*/
        /*.line:nth-child(2){*/
            /*stroke-dasharray: 397;             !* //设置虚线的间隔长度 *!*/
            /*stroke-dashoffset: 397;             !* 设置线段偏移长度 *!*/

            /*animation: dash 4s infinite;*/
        /*} !*添加动画的效果，具体想怎么动，可以修改这里面的东西*!*/
        /*@keyframes dash {*/
        /*!*<span style="white-space:pre">   </span>*!*/
            /*0%{*/
                /*stroke-dashoffset: 397;*/
            /*}*/
            /*25%{*/
                /*stroke-dashoffset: 0;*/
            /*}*/
            /*50%{*/
                /*stroke-dashoffset: -397;*/
            /*}75%{*/
                /*stroke-dashoffset: 0;*/
            /*}*/
            /*100%{*/
                /*stroke-dashoffset: 397;*/
            /*}*/
        /*}*/
        .line {
            /*stroke-dasharray: 10000;*/
            /*stroke-dashoffset: 10000;*/
            animation: dash 10s linear forwards;
        }

        @keyframes dash {
            to {
                stroke-dashoffset: 0;
            }
        }
    </style>


</head>
<body>
<div id="body" style="text-align: center">
    <div style="margin: auto">
        <h1 style="margin-top: 50px;">Mutil Line</h1>
        <p style="font-size: 10px;">使用数据源 : 信用卡数据集</p>
    </div>

</div>
<div style="margin-left: 300px;margin-right: 250px;text-align: left">


    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">数据源说明</h3>
        </div>
        <div class="panel-body">
            采用信用卡调查数据，含有"age", "job", "marital"(婚姻), "balance"(收支情况), "loan"维度数据
            颜色采用用户教育程度，分别为"unknown","secondary","primary","tertiary"四个教育程度，分别代表
            未知、中等教育、基本教育、高等教育。
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">优点</h3>
        </div>
        <div class="panel-body">
            <p>1、每一条线段代表一个维度，可反映多维信息在维度的变化趋势</p>
            <p>2、可视化可以实现动态数据显示效果</p>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">不足</h3>
        </div>
        <div class="panel-body">
            <p>只能发现大致趋势，作用比较有限</p>
        </div>
    </div>
    </div>

</body>
<script>

    var width=900;
    var height=600;

    var dataset = new Array();
    var type = ["education","age","balance","job","marital",
        "loan"];

    var script = ["用户的教育程度1-4:unknown,secondary,primary,tertiary",
    "年龄大小","收支情况","工作类型","婚姻: 未婚、已婚、离婚","是否负债"];
//    var type = ["buying","maint","balance","job","marital",
//        "default","housing" ,"loan"];




    d3.csv("${ctx}/visualization-admin/resource/data/cardSelect.csv", function(cards) {
        var gdp = {};

        type.forEach(function (trait) {
            gdp[trait] = [];
            cards.forEach(function(card,index) {
                  gdp[trait].push([index, parseInt(card[trait])]);
            });

            dataset.push({"type" : trait, "gdp" : gdp[trait]});

        });

        var padding={top:70, right:70, bottom: 70, left:70};

        //直接处理数据
        var yScaleList;
        var n = dataset.length;  //维度
        var h = height-padding.bottom-padding.top;

        var max,min ;

        for(var i = 0; i < dataset.length; i++) {
            max = d3.max(dataset[i].gdp,function(d){
                return d[1];
            });
            min = d3.min(dataset[i].gdp,function(d){
                return d[1];
            });
//            console.info(max + " ,"+ min);

            yScaleList = d3.scale.linear()
                    .domain([max,min])
                    .range([h/n * (i + 1), h/n * i + 10]);

            //替换映射后数据
            dataset[i].gdp.forEach(function (d) {
                d[1] = yScaleList(d[1]);
            })
        }


        //   获取y轴最大值最小值
        var gdpmax=0,gdpmin=0;
        for(var i=0;i<dataset.length;i++){

            var maxGdp=d3.max(dataset[i].gdp,function(d){
                return d[1];
            });
            if(maxGdp>gdpmax) {
                gdpmax=maxGdp;
            }

            var minGdp=d3.min(dataset[i].gdp,function(d){
                return d[1];
            });
            if(minGdp<gdpmin){
                gdpmin=minGdp;
            }

        }
//        console.log(gdpmax + " " + gdpmin);

        var xScale=d3.scale.linear()
                .domain([0,250])
                .range([0,width-padding.left-padding.right]);

        var yScale=d3.scale.linear()
                .domain([gdpmin,gdpmax])
                .range([height-padding.bottom-padding.top,0]);

        var linePath=d3.svg.line()//创建一个直线生成器
                        .x(function(d){
                            return xScale(d[0]);
                        })
                        .y(function(d){
                            return yScale(d[1]);
                        })
                       .interpolate("basis")//插值模式


        //定义两个颜色
        var color = d3.scale.category20();

        var svg=d3.select("#body")
                .append("svg")
                .attr("width",width)
                .attr("height",height);

        var tooltip = d3.select('body').append('div')
                .style('position', 'absolute')
                .style('padding', '0 10px')
                .style('background', 'white')
                .style('opacity', 0);



        svg.selectAll("path")
                .data(dataset)
                .enter()
                .append("path")
                .attr("transform","translate("+padding.left+","+padding.top+")")
                .attr("d",function(d,i){
                    return linePath(d.gdp);
                    //返回线段生成器得到的路径
                })
//                .attr("stroke-dasharray",10000)
//                .attr("stroke-dashoffset", 10000)
                .attr("class","line")
                .attr("fill","none")
                .attr("stroke-width",3)
                .attr("stroke",function(d,i){
                    return color(i);
                })
                .on('mouseover', function(d,i) {

                    var t = type[i];
                    tooltip.transition()
                            .style('opacity', 0.9)
                    tooltip.html(script[i])
                            .style('left', (d3.event.pageX - 35) + 'px')
                            .style('top', (d3.event.pageY - 40) + 'px');
                });

        var path = $('.line');  //获取class标签为line的元素
//        var path = d3.selectAll(".line");
        console.info(path);

        for (var i = 0 ;i < path.length; i++) {
            var length = path[i].getTotalLength();
            path[i].style.strokeDasharray = length;
            path[i].style.strokeDashoffset = length;
        }
        console.info(path);


        var xAxis=d3.svg.axis()
                .scale(xScale)
                .ticks(5)
                .tickFormat(d3.format("d"))
                .orient("bottom");

        var yAxis=d3.svg.axis()
                .scale(yScale)
                .orient("left");

        //添加一个g用于放x轴
        svg.append("g")
                .attr("class","axis")
                .attr("transform","translate("+padding.left+","+(height-padding.top)+")")
                .call(xAxis);

        svg.append("g")
                .attr("class","axis")
                .attr("transform","translate("+padding.left+","+padding.top+")")
                .call(yAxis);

//        // Add a legend.
        var legend = svg.selectAll("g.legend")
                .data(type)
                .enter().append("svg:g")
                .attr("class", "legend")
                .attr("transform", function(d, i) {
                    return "translate(80," + (n - i + 0.5) * (height-padding.bottom-padding.top)/n + ")";
                });

        legend.append("svg:text")
                .attr("x", 12)
                .attr("dy", ".31em")
                .text(function(d,i) {

                    return type[i];

                });


    });

</script>

</html>