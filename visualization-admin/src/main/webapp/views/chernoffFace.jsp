<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chernoff faces </title>
    <jsp:include page="${ctx}/common/head.jsp"></jsp:include>
    <style>
        .chernoff > * {
            fill: none;
            stroke: #000;
        }


    </style>
</head>
<body>

    <div id="body" style="text-align: center;">
        <div style="margin: auto">
            <h1 style="margin-top: 50px;">Chernoff faces </h1>
            <p style="font-size: 10px;">使用数据源 : 信用卡数据集</p>

        </div>

    </div>
    <div style="margin-left: 300px;margin-right: 250px;margin-top:50px;text-align: left">

        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">数据源说明</h3>

            </div>
            <div class="panel-body">
                <div class="panel-body">
                    采用信用卡调查数据，含有"education","age", "job", "marital"(婚姻), "default", "balance"(收支情况), "housing", "loan"维度数据
                </div>

            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">说明</h3>
            </div>
            <div class="panel-body">
                <p>Chernoff面法用预先设置好的人脸表示多维信息，脸上每一个器官的特征以及脸的大小、形状代表不同的变化。</p>
                <p>上图中对应关系如下：</p>
                <p>face : education 取值范围 [0,1],hair: age 取值范围 [-1, 1],mouth: job 取值范围 [-1, 1]
                <p>nosew : marital 取值范围 [0, 1],noseh : default 取值范围 [0, 1],eyew : balance 取值范围 [0 ,1]
                <p>eyeh : housing 取值范围 [0, 1],brow : loan 取值范围 [-1, 1]</p>

                <p>适用于维度不多且某些维度有特殊含义的数据分析</p>
            </div>
        </div>
    </div>

</body>
<script>
    $(function () {

        draw();
        $("[data-toggle='tooltip']").tooltip();
    });

//    (function () {
//        var c = d3.chernoff()
//                .face(function(d) { return d.f; })
//                .hair(function(d) { return d.h; })
//                .mouth(function(d) { return d.m; })
//                .nosew(function(d) { return d.nw; })
//                .noseh(function(d) { return d.nh; })
//                .eyew(function(d) { return d.ew; })
//                .eyeh(function(d) { return d.eh; })
//                .brow(function(d) { return d.b; });
//
//
//
//        var svg = d3.select("#body").append("svg:svg")
//                        .attr("height", 500).attr("width", 500),
//                dat = [
//                    {f: 0, h: -1, m: -1, nw: 0.3, nh: 0.3, ew: 0.3, eh: 0.3, b: -1},
//                    {f: 0.5, h: 0, m: 0, nw: 0.3, nh: 1, ew: 1, eh: 0.3, b: 0},
//                    {f: 1, h: 1, m: 1, nw: 1, nh: 0.3, ew: 0.3, eh: 1, b: 1}];
//
//        svg.selectAll("g.chernoff").data(dat).enter()
//                .append("svg:g")
//                .attr("class", "chernoff")
//                .attr("transform", function(d, i) {
//                    return "scale(1." + i + ")translate(" +
//                            (i*100) + "," + (i*100) + ")";
//                })
//                .call(c);
//    })();

    function draw() {


        var types = ["education","age", "job", "marital", "default", "balance", "housing", "loan"];

        var typesMap = {
            education : "face",
            age : "hair",
            job : "mouth",
            marital : "nosew",
            default : "noseh",
            balance : "eyew",
            housing : "eyeh",
            loan : "brow"
        };
        var c = d3.chernoff()
                .face(function(d) { return d.education; })  // 0 - 1
                .hair(function(d) { return d.age; })        // -1 - 1
                .mouth(function(d) { return d.job; })       // -1 - 1
                .nosew(function(d) { return d.marital; })   // 0 - 1
                .noseh(function(d) { return d.default; })   // 0 - 1
                .eyew(function(d) { return d.balance; })    // 0 - 1
                .eyeh(function(d) { return d.housing; })    // 0 - 1
                .brow(function(d) { return d.loan; });      // -1 - 1


                var svg = d3.select("#body").append("svg:svg")
                                .attr("height", 620).attr("width", 800);

                var data = [],min = {},max = {}, n = 4;
                d3.csv("${ctx}/visualization-admin/resource/data/cardSelect.csv", function(cards) {

                    types.forEach(function (type, index) {
                        min[type] = -1000;
                        max[type] = 0;
                    });

                    for(var i = 0 ;i < n * n ; i++) {
                        var values = cards[i];
                        var tempData = {};
                        types.forEach(function (type) {
                            tempData[type] = parseInt(values[type]);
                            console.info(tempData[type])

                            if (tempData[type] > max[type]) {
                                max[type] = tempData[type];
                            }
                            if (tempData[type] < min[type] || min[type] == -1000) {
                                min[type] = tempData[type];
                            }
                        })

                        data.push(tempData);
                    }


                    for(var i = 0; i < n * n; i++) {
                        var values = data[i];
                        types.forEach(function (type,index) {

                            //范围为-1 - 1
                            if (index == 1 || index == 2 || index == 7) {
                                data[i][type] =  -1 + 2 * (data[i][type] - min[type] + 1) / (max[type] - min[type] + 1);
                            } else {//范围为0 - 1
                                data[i][type] =  (data[i][type] - min[type] + 1) / (max[type] - min[type] + 1);
                            }

                        })
                    }
                    console.info(data);
                    console.info(min);
                    console.info(max);


//            dat = [
//                {f: 0, h: -1, m: -1, nw: 0.3, nh: 0.3, ew: 0.3, eh: 0.3, b: -1},
//                {f: 0.5, h: 0, m: 0, nw: 0.3, nh: 1, ew: 1, eh: 0.3, b: 0},
//                {f: 1, h: 1, m: 1, nw: 1, nh: 0.3, ew: 0.3, eh: 1, b: 1}];

                    svg.selectAll("g.chernoff").data(data).enter()
                            .append("svg:g").attr("height", 150).attr("width", 200)
                            .attr("class", "chernoff")
                            .attr("transform", function(d, i) {

                                return "scale(1."  + (4 - n) + ")translate(" +
                                        ((Math.floor(i/n))*800/n) + "," + ((i%n)*600/n) + ")";
                            })
                            .call(c);



                });

    }




</script>

</html>