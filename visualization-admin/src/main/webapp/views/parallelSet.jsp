<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>工程</title>
    <jsp:include page="${ctx}/common/head.jsp"></jsp:include>
    <style>
        .axis path,
        .axis line{
            fill:none;
            stroke:black;
            shape-rendering:crispEdges;
        }
    </style>


</head>
<body>

    <div id="body" style="text-align: center">
        <div style="margin: auto">
            <h1 style="margin-top: 50px;">Parallel Set</h1>
            <div class="form-group" style="margin-left: 300px;margin-right: 250px;">
                <label class="col-sm-3 control-label">使用数据源 ：</label>
                <div class="col-sm-4">
                    <select id="type" name="type" class="selectpicker form-control">
                        <option value="card">信用卡数据集(部分)</option>
                        <option value="cars">汽车评估数据</option>

                    </select>
                </div>
                <div>
                    <button class="btn btn-primary" onclick="redraw()">重新绘制</button>
                </div>
             </div>
        </div>

    </div>
    <div style="margin-left: 300px;margin-right: 250px;margin-top:50px;text-align: left">


        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">数据源说明</h3>
            </div>
            <div class="panel-body">
                采用信用卡部分调查数据，含有"marital"(婚姻), "default", "balance"(收支情况), "housing", "loan"维度数据
                颜色采用用户婚姻状况，分别为"married","single","divorced"三种
            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">优点</h3>
            </div>
            <div class="panel-body">
                <p> 1、适合离散型高维数据的分析</p>
                <p> 2、D3.js 可以进行选择某一个维度上的特定离散变量进行数据直观显示</p>
                <p> 3、根据数据分析的需求可以对显示数据源维度进行筛选分析</p>
            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">不足</h3>
            </div>
            <div class="panel-body">
                <p> 1、维数依赖于屏幕垂直高度</p>
                <p> 2、维数增加时,垂直轴比较靠近，辨认维数关系比较难</p>
                <p> 3、数据量比较大时容易进行混淆跟重叠</p>
            </div>
        </div>
    </div>

</body>
<script>

    function draw(type) {

        var chart,vis;
        if (type == "card"){

            chart = d3.parsets().dimensions(["marital", "education", "default", "housing","loan"]);

            vis = d3.select("#body").append("svg")
                    .attr("width", chart.width())
                    .attr("height", chart.height());

            d3.csv("${ctx}/visualization-admin/resource/data/bank-without-data.csv", function(error, csv) {
                vis.datum(csv).call(chart);
            });
        } else {

            chart = d3.parsets().dimensions(["buying", "maint", "doors", "persons","lug_boot","safety"]);

            vis = d3.select("#body").append("svg")
                    .attr("width", chart.width())
                    .attr("height", chart.height());

            d3.csv("${ctx}/visualization-admin/resource/data/car.csv", function(error, csv) {
                vis.datum(csv).call(chart);
            });
        }
    }


    $(function () {
//        traits = ["job", "marital", "default", "balance", "housing", "loan"];
        $('#type').selectpicker('val', "card");
        console.info($('#type').val());
//        traits = ($('#type').val());

        draw($('#type').val());
    });

    function redraw() {
        d3.select("#body").select("svg").remove();

        draw($('#type').val());

    }


    <%--d3.csv("${ctx}/visualization-admin/resource/data/cardSelect.csv", function(cards) {--%>
        <%--var gdp = [];--%>
        <%--for(var i = 1; i <= 4; i++)--%>
            <%--gdp[i] = [];--%>

        <%--console.info(cards[0].education == 3);--%>

        <%--cards.forEach(function(card,index) {--%>
<%--//            if(card.education == '1') {--%>
                <%--gdp[1].push([index,parseInt(card.balance)]);--%>
                <%--gdp[2].push([index,parseInt(card.age)]);--%>
<%--//            }--%>
<%--//            if(card.education == '2') {--%>
<%--//                gdp[2].push([index,parseInt(card.balance)]);--%>
<%--//            }--%>
<%--//            if(card.education == '3') {--%>
<%--//                gdp[3].push([index,parseInt(card.balance)]);--%>
<%--//            }--%>
<%--//            if(card.education == '4') {--%>
<%--//                gdp[4].push([index,parseInt(card.balance)]);--%>
<%--//            }--%>
        <%--})--%>

        <%--dataset.push({"education" : "primary", "gdp" : gdp[1]});--%>
        <%--dataset.push({"education" : "secondary", "gdp" : gdp[2]});--%>
<%--//        dataset.push({"education" : "tertiary", "gdp" : gdp[3]});--%>
<%--//        dataset.push({"education" : "tertiary", "gdp" : gdp[4]});--%>

        <%--console.info(dataset);--%>
        <%--console.info(dataset.length);--%>


<%--//    dataset.push({"country" : "education1", "gdp" : 123});--%>


<%--//    var dataset=[--%>
<%--//        {--%>
<%--//            country:"china",--%>
<%--//            gdp:[[2000,11920],[2001,13170],[2002,14550],--%>
<%--//                [2003,16500],[2004,19440],[2005,22870],--%>
<%--//                [2006,27930],[2007,35040],[2008,45470],--%>
<%--//                [2009,51050],[2010,59490],[2011,73140],--%>
<%--//                [2012,83860],[2013,103550],]--%>
<%--//        }];--%>
<%--//    console.info(dataset);--%>
<%--//        {--%>
<%--//            country:"japan",--%>
<%--//            gdp:[[2000,47310],[2001,41590],[2002,39800],--%>
<%--//                [2003,43020],[2004,46550],[2005,45710],--%>
<%--//                [2006,43560],[2007,43560],[2008,48490],--%>
<%--//                [2009,50350],[2010,54950],[2011,59050],--%>
<%--//                [2012,59370],[2013,48980],]--%>
<%--//        }--%>
<%--//    ];--%>


        <%--var padding={top:70, right:70, bottom: 70, left:70};--%>

        <%--//获取y轴最大值最小值--%>
        <%--var gdpmax=0,gdpmin=0;--%>
        <%--for(var i=0;i<dataset.length;i++){--%>

            <%--var maxGdp=d3.max(dataset[i].gdp,function(d){--%>
                <%--return d[1];--%>
            <%--});--%>
            <%--if(maxGdp>gdpmax) {--%>
                <%--gdpmax=maxGdp;--%>
            <%--}--%>

            <%--var minGdp=d3.min(dataset[i].gdp,function(d){--%>
                <%--return d[1];--%>
            <%--});--%>
            <%--if(minGdp<gdpmin){--%>
                <%--gdpmin=minGdp;--%>
            <%--}--%>

        <%--}--%>
        <%--console.log(gdpmax + " " + gdpmin);--%>


        <%--var xScale=d3.scale.linear()--%>
                <%--.domain([0,250])--%>
                <%--.range([0,width-padding.left-padding.right]);--%>

        <%--var yScale=d3.scale.linear()--%>
                <%--.domain([gdpmin,gdpmax*1.1])--%>
                <%--.range([height-padding.bottom-padding.top,0]);--%>





        <%--var linePath=d3.svg.line()//创建一个直线生成器--%>
                        <%--.x(function(d){--%>
                            <%--return xScale(d[0]);--%>
                        <%--})--%>
                        <%--.y(function(d){--%>
                            <%--return yScale(d[1]);--%>
                        <%--})--%>
                       <%--.interpolate("basis")//插值模式--%>
                <%--;--%>

        <%--//定义两个颜色--%>
        <%--var colors=[d3.rgb(0,0,255),d3.rgb(0,255,0),d3.rgb(255,0,0),d3.rgb(255,255,0)];--%>
 <%--//           var colors=d3.scale.category10();--%>

        <%--var svg=d3.select("body")--%>
                <%--.append("svg")--%>
                <%--.attr("width",width)--%>
                <%--.attr("height",height);--%>

        <%--svg.selectAll("path")--%>
                <%--.data(dataset)--%>
                <%--.enter()--%>
                <%--.append("path")--%>
                <%--.attr("transform","translate("+padding.left+","+padding.top+")")--%>
                <%--.attr("d",function(d,i){--%>
<%--//                    var w = width-padding.left-padding.right;--%>
<%--//                    var h = height-padding.bottom-padding.top;--%>
<%--//                    var min = d3.min(dataset[i].gdp,function(d) {--%>
<%--//                        return d[1];--%>
<%--//                    });--%>
<%--//                    var max = d3.max(dataset[i].gdp,function(d) {--%>
<%--//                        return d[1];--%>
<%--//                    });--%>
<%--//--%>
<%--//                    var xScale1=d3.scale.linear()--%>
<%--//                            .domain([0, 250])--%>
<%--//                            .range([w/250 * min, w/250 * max]);--%>
<%--//--%>
<%--//                    var yScale1=d3.scale.linear()--%>
<%--//                            .domain([gdpmin,gdpmax*1.1])--%>
<%--//                            .range([gdpmin + h/(gdpmax*1.1 - gdpmin) * (max - gdpmin),gdpmin + h/(gdpmax*1.1 - gdpmin) * (min - gdpmin)]);--%>
<%--//--%>
<%--//                    var linePath1=d3.svg.line()//创建一个直线生成器--%>
<%--//                            .x(function(d){--%>
<%--//                                return xScale1(d[0]);--%>
<%--//                            })--%>
<%--//                            .y(function(d){--%>
<%--//                                return yScale1(d[1]);--%>
<%--//                            })--%>
<%--//                            .interpolate("basis")//插值模式--%>

                    <%--return linePath(d.gdp);--%>
                    <%--//返回线段生成器得到的路径--%>
                <%--})--%>
                <%--.attr("fill","none")--%>
                <%--.attr("stroke-width",3)--%>
                <%--.attr("stroke",function(d,i){--%>

                    <%--return colors[i];--%>
<%--//                    return colors[i];--%>
                <%--});--%>

        <%--var xAxis=d3.svg.axis()--%>
                <%--.scale(xScale)--%>
                <%--.ticks(5)--%>
                <%--.tickFormat(d3.format("d"))--%>
                <%--.orient("bottom");--%>

        <%--var yAxis=d3.svg.axis()--%>
                <%--.scale(yScale)--%>
                <%--.orient("left");--%>

        <%--//添加一个g用于放x轴--%>
        <%--svg.append("g")--%>
                <%--.attr("class","axis")--%>
                <%--.attr("transform","translate("+padding.left+","+(height-padding.top)+")")--%>
                <%--.call(xAxis);--%>

        <%--svg.append("g")--%>
                <%--.attr("class","axis")--%>
                <%--.attr("transform","translate("+padding.left+","+padding.top+")")--%>
                <%--.call(yAxis);--%>

    <%--});--%>

</script>

</html>