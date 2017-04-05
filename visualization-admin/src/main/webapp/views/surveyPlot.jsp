<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Survey Plot</title>
    <jsp:include page="${ctx}/common/head.jsp"></jsp:include>

</head>
<body>

    <div id="body" style="text-align: center;">
        <div style="margin: auto">
            <h1 style="margin-top: 50px;">Survey Plot</h1>
            <p style="font-size: 10px;">使用数据源 : 鸢尾花(iris)数据集 </p>
            <div class="form-group" style="margin-left: 300px;margin-right: 250px;">
                <label class="col-sm-3 control-label">排序维度：</label>
                <div class="col-sm-4">
                    <select id="type" name="type" class="selectpicker form-control">
                        <option value="0">species</option>
                        <option value="1" selected>sepal length</option>
                        <option value="2">sepal width</option>
                        <option value="3">petal length</option>
                        <option value="4">petal width</option>
                    </select>
                </div>
                <div>
                    <button class="btn btn-info" onclick="redraw()">重新绘制</button>
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
                <h3 class="panel-title">说明</h3>
            </div>
            <div class="panel-body">
                <p>借鉴多线图与平行坐标的思想，不同维度使用直线段表示，线段长度与维度值成比例</p>
                <p>多维数据集按照某些维度进行排序可以发现准确的分类规则</p>
            </div>
        </div>
    </div>

</body>
<script>

    var width = 800, height = 550;
    var types = ['species','sepal length','sepal width','petal length','petal width'];
    var color = d3.scale.category10();

    var speciesMap = {
        setosa : 1,
        versicolor : 2,
        virginica : 3
    };

    var species = ["setosa", "versicolor", "virginica"];
    var data = [], min = {}, max = {};
    //获取数据
    d3.csv("${ctx}/visualization-admin/resource/data/iris.csv", function(flowers) {

        types.forEach(function (type) {
            min[type] = 0;
            max[type] = 0;
        });
        flowers.forEach(function (flower) {
            var temp = {};

            types.forEach(function (type) {
                if (type == 'species') {
                    temp[type] = speciesMap[flower[type]];

                } else {
                    temp[type] = parseFloat(flower[type]);
                }

                if (temp[type] > max[type]) {
                    max[type] = temp[type];
                } else if (temp[type] < min[type] || min[type] == 0) {
                    min[type] = temp[type];
                }
            });
            data.push(temp);
        });
        console.info(data);
        console.info(min);
        console.info(max);
    });
    //画图
    function draw(type) {


            //按年龄从小到大排序
            data.sort(function(a,b){
                return a[type] - b[type];
            });
            console.info(data);


//            types.forEach(function (type) {
//                data[type] = [];
//                flowers.forEach(function (flower) {
//                    if (type == 'species') {
//                        data[type].push(speciesMap[flower[type]]);
//
//                    } else {
//                        data[type].push(parseFloat(flower[type]));
//                    }
//                });
//
//                min[type] = d3.min(data[type]) - 1;
//                max[type] = d3.max(data[type]);
//
//            });
//            console.info(data);
            var svg = d3.select("#body")
                    .append("svg")
                    .attr("width", width)
                    .attr("height", height);

            //根据类型将画布分为几个部分
            var g = {}, size = 150;

            var info = {};




        types.forEach(function (type,index) {

                g[type] = svg.append("g")
                        .attr("width", width / types.length)
                        .attr("height", height);

                //添加文字
                var word =  g[type].append("text")
                        .attr("transform",function(d){
                            return "translate(" + (index + 0.3) * width / types.length + ",20)";
                        })
                        .text(function(d,i){
                            return type;
                        });



                info[type] =  g[type].append("text")
                        .attr("transform",function(d){
                            return "translate(" + (index + 0.3) * width / types.length + ",450)";
                        })
                        .text(function(d,i){
                            return type;
                        });
            });
        var drag = d3.behavior.drag()
                .on("drag", dragmove);

        function dragmove(d) {
            d3.select(this)
                    .attr("y1", d3.event.y )
                    .attr("y2", d3.event.y );

            if (d3.event.y > 50) {

                var value = data[Math.floor((d3.event.y - 50) / 2.5)];


                types.forEach(function (type,index) {
                    if(type == "species"){
                        info[type].text(type + ": "+ species[value[type] - 1]);
                    } else {
                        info[type].text(type + ": "+ value[type]);
                    }

                });
            }
        }

        //添加标尺线
        var hoverLine = svg.append("line")
                .attr("class","hover-line")
                .attr("x1",0)
                .attr("y1",0)
                .attr("x2",width)
                .attr("y2",0)
                .attr("stroke-width",2.5)
                .attr("stroke", d3.rgb("black"))
                .call(drag);


//                        .attr("transform","translate("+ index * width/types.length+",0)");

//            var values = data;

            for (var i = 0; i < data.length; i++) {

                var values = data[i];

                types.forEach(function (type,index) {

                    var offset = width/types.length * (values[type] - min[type] + 1)/(max[type] - min[type] + 1);

                    //居中显示，1/2 g长度 - 1/2 线长度
                    var trans = (width/types.length) / 2  - 1/2  * offset;


                    //画直线
                    var line =  g[type].append("line")
                            .attr("x1",(index + 0.5) * width/types.length)
                            .attr("y1",50)
                            .attr("x2",(index + 0.5) * width/types.length)
                            .attr("y2",50)
                            .transition()
                            .duration(2000)
                            .attr("x1",index * width/types.length)
                            .attr("y1",50 + 2.5 * i)
                            .attr("x2",index * width/types.length + offset)
                            .attr("y2",50 + 2.5 * i)
                            .attr("stroke-width",2.5)
                            .attr("transform","translate("+ trans +",0)")
                            .attr("stroke", d3.rgb("yellow"))
                            .transition()
                            .duration(1000)
                            .attr("stroke",color(values.species));

                });

            }




//            });



//        });

        // Add a legend.
        var legend = svg.selectAll("g.legend")
                .data(species)
                .enter().append("svg:g")
                .attr("class", "legend")
                .attr("transform", function(d, i) {
                    return "translate(600," + (i * 20 + 470) + ")";
                });

        legend.append("svg:circle")
                .attr("fill", function(d,i) {

                    return color(i + 1);

                })
                .attr("r", 3);

        legend.append("svg:text")
                .attr("x", 12)
                .attr("dy", ".31em")
                .text(function(d) {

                    return "species : " + d;

                });

    }


    $(function () {

        draw(types[$('#type').val()]);
    });
    function redraw() {
        console.info(types[$('#type').val()]);
        d3.select("#body").select("svg").remove();
        draw(types[$('#type').val()])
    }



</script>

</html>