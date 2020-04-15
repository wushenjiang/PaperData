<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>论文云</title>
<script src='https://cdn.bootcss.com/echarts/3.7.0/echarts.simple.js'></script>
<script src="./js/echarts-wordcloud.js"></script>
<script src="./js/jquery-1.11.3.min.js"></script>
<!-- 引入Bootstrap核心样式文件 -->
<link href="css/bootstrap.css" rel="stylesheet">
<!-- 引入BootStrap核心js文件 -->
<script src="./js/bootstrap.js"></script>
<style>
html, body, #main {
	width: 100%;
	height: 100%;
	margin: 0;
}
</style>
</head>
<body>
	<div id="main"></div>
	<div>
		<table class="table table-hover">
			<thead>
				<tr>
					<td style="font-size: 20px;">论文链接</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${dataList}" var="data" varStatus="vs">
					<tr>
						<td><a href="${data.paperlink}">${data.papername}</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<script>
		var chart = echarts.init(document.getElementById('main'));
		var postURL = "/PaperData/getData";
		var mydata = new Array();
		$.ajaxSettings.async = false;
		$.post(postURL, {}, function(rs) {
			var dataList = JSON.parse(rs);
			for (var i = 0; i < dataList.length; i++) {
				var d = {};
				d['name'] = dataList[i].name;
				d['value'] = dataList[i].value;
				mydata.push(d);
			}
		});
		$.ajaxSettings.async = true;
		var option = {
			tooltip : {},
			series : [ {
				type : 'wordCloud',
				gridSize : 2,
				sizeRange : [ 20, 50 ],
				rotationRange : [ -90, 90 ],
				shape : 'pentagon',
				width : 800,
				height : 600,
				drawOutOfBound : false,
				textStyle : {
					normal : {
						color : function() {
							return 'rgb('
									+ [ Math.round(Math.random() * 160),
											Math.round(Math.random() * 160),
											Math.round(Math.random() * 160) ]
											.join(',') + ')';
						}
					},
					emphasis : {
						shadowBlur : 10,
						shadowColor : '#333'
					}
				},
				data : mydata
			} ]
		};
		chart.setOption(option);
		chart.on('click', function(params) {
			var url = "clickFunction?name=" + params.name;
			window.location.href = url;
		});
	</script>
</body>
</html>