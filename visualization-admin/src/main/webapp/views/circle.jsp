<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>圆形分段技术</title>
    <jsp:include page="${ctx}/common/head.jsp"></jsp:include>

</head>
<body>

    <div id="body" style="text-align: center;">
        <div style="margin: auto">
            <h1 style="margin-top: 50px;">Circle Segment/圆形分段技术</h1>
            <p style="font-size: 10px;">使用数据源 :葡萄酒数据集 </p>

        </div>

    </div>
    <div style="margin-left: 300px;margin-right: 250px;margin-top:50px;text-align: left">

        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">数据源说明</h3>

            </div>
            <div class="panel-body">
                <div class="panel-body">
                    <p>葡萄酒数据集是意大利同一地区生长的葡萄酒的化学分析结果，但来自三个不同的品种。
                        分析确定了三种葡萄酒中每种葡萄酒中13种成分的数量。</p>
                    <p>其中13中成分分别为</p>
                    <p>1、type/葡萄酒类型 2、Alcohol/酒精 3、Malic acid,Ash/苹果酸4、Alcalinity of ash/灰分碱度 5、Magnesium/镁 </p>
                    <p>6、Total phenols/酚类 7、Flavanoids/黄酮素类 8、Nonflavanoid phenols 9、Proanthocyanins/原花青素 </p>
                    <p>10、Color intensity/颜色强度 11、Hue/色调 12、OD280/OD315 of diluted wines/稀释酒13、Proline/脯氨酸</p>
                </div>

            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">优点</h3>
            </div>
            <div class="panel-body">
                <p>使用一段圆弧代表多维信息的某一属性，属性值使用圆弧的灰度值表示，
                    将数据按照分类信息由内向外排列，能够发现多维信息集合分类的决定维度</p>
            </div>
        </div>
    </div>

</body>
<script>

    var width = 800, height = 650;

    //画图
    function draw() {

        var types = ["type", "Alcohol", "Malic acid", "Ash", "Alcalinity of ash",
            "Magnesium", "Total phenols", "Flavanoids" ,"Nonflavanoid phenols", "Proanthocyanins",
            "Color intensity", "Hue", "OD280/OD315 of diluted wines", "Proline"];

        var species = ["葡萄酒1", "葡萄酒2", "葡萄酒3"];

        //获取数据
        d3.csv("${ctx}/visualization-admin/resource/data/wine.csv", function(wines) {
            var data = {},min = {}, max = {};

            types.forEach(function (type) {
                data[type] = [];
                wines.forEach(function (wine) {
                    data[type].push(parseFloat(wine[type]));
                });

                min[type] = d3.min(data[type]);
                max[type] = d3.max(data[type]);

            });
            console.info(data);



        var svg = d3.select("#body")
                .append("svg")
                .attr("width", width)
                .attr("height", height);
        //饼图分布
        var dataset = [];
        var size = types.length * 2;


        for(var j = 0 ;j < size; j++) {
            dataset.push(1);
        }

        //布局
        var pie = d3.layout.pie();

        //将数据转化为饼图数据
        var piedata = pie(dataset);

        var arcs = svg.selectAll("g")
                .data(piedata)
                .enter()
                .append("g")
                .attr("transform","translate("+ (width/2) +","+ ((width/2) - 80) +")");

        var color = d3.scale.category10();

        for (var i = 0; i < 178 ; i++) {


            var outerRadius = 20 + (i + 1) * 1.5; //外半径
            var innerRadius = 20 + i * 1.5; //内半径，为0则中间没有空白

            var arc = d3.svg.arc()  //弧生成器
                    .innerRadius(innerRadius)   //设置内半径
                    .outerRadius(outerRadius);  //设置外半径

            var times = 0;
            arcs.append("path")
                    .attr("fill",d3.rgb("yellow"))
                    .attr("d",function(d){
                        return arc(d);   //调用弧生成器，得到路径值
                    })
                    .transition()
                    .duration(2000)
                    .attr("fill",function(d,k){
                        //调换前两块
                        if (k == 1 || (k % 2 == 0 && (k != 0))) {
                            //计算灰度值，根据每个属性的值大小
                            var type = types[times];

                            var values = data[type];
                            times++;
                            var gray = (values[i] - min[type])/(max[type] - min[type]) * 255;
//                            console.info(gray);
                            return d3.rgb(gray,gray,gray);
                        } else {
                            if ( i < 59) {
                                return color(0);
                            } else if( i < 130) {
                                return color(1);
                            } else {
                                return color(2);
                            }
                        }

                    });


        }
            //添加图例
            var arcEnd = d3.svg.arc()  //弧生成器
                    .innerRadius((20 + 185 * 1.5))   //设置内半径
                    .outerRadius((20 + 195 * 1.5));  //设置外半径

            var typeTimes = 0;
            arcs.append("text")
                    .attr("transform",function(d,i){

//                        //第一个元素（最中间的），只平移不旋转
//                        if( i == 0 )
                            return "translate(" + arc.centroid(d) + ")";

//                        //其他的元素，既平移也旋转
//                        var r = 0;
////                        if()  // 0 - 180 度以内的
////                            r = 180 * ((d.x + d.dx / 2 - Math.PI / 2) / Math.PI);
////                        else  // 180 - 360 度以内的
////                            r = 180 * ((d.x + d.dx / 2 + Math.PI / 2) / Math.PI);
//                        //判断是否属于
//                        if ( i  < size / 2) {
//                            r = 180 * (i /(size / 2));
//                        } else {
//                            r = 180 * ((i - size / 2 )/(size / 2));
//                        }
//                        console.info(r);
//                        //既平移也旋转
//                        return  "translate(" + arc.centroid(d) + ")" +
//                                "rotate(" + r + ")";

//                        return "translate(" + arcEnd.centroid(d) + ")";
                    })
                    .attr("text-anchor","bottom")
                    .text(function(d,i){
                        if (i == 1 || (i % 2 == 0 && (i != 0))) {
                            var type = types[typeTimes];
                            typeTimes++;
                            return type;
                        }

                    });

            // Add a legend.
            var legend = svg.selectAll("g.legend")
                    .data(species)
                    .enter().append("svg:g")
                    .attr("class", "legend")
                    .attr("transform", function(d, i) {
                        return "translate(20," + (i * 20 + 530) + ")";
                    });

            legend.append("svg:circle")
                    .attr("fill", function(d,i) {

                        return color(i);

                    })
                    .attr("r", 3);

            legend.append("svg:text")
                    .attr("x", 12)
                    .attr("dy", ".31em")
                    .text(function(d) {

                        return "species : " + d;

                    });

        });



    }


    $(function () {

        draw();
    });



</script>

</html>