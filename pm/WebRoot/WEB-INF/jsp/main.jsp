<%@ page import="com.icker.pm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>项目管理系统--项目列表</title>
<base href="<%=basePath%>">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="styles/bootstrap.css" rel="stylesheet">
<link href="styles/backstage.css" rel="stylesheet">
<script src="js/jquery.js"></script>
<script src="js/bootstrap/js/bootstrap.js"></script>
<script src="js/highcharts/highcharts.js"></script>
<script src="js/highcharts/exporting.js"></script>

</head>

<body>
	<div class="container container-own">
		<jsp:include page="common/header.jsp"></jsp:include>
		<jsp:include page="common/sideBar.jsp"></jsp:include>
		<h2>
			<i>来到首页了哟</i><span id="showTime2" class="label pull-right"></span><span
				id="showTime" class="label label-primary pull-right"></span>
		</h2>
		<div class="line-spacing"></div>
		<div class="jumbotron" style="background-color: #ffffff">
		  <h1>欢迎光临！谢谢惠顾！</h1>
		  <hr>
		  <p><a class="btn btn-primary btn-lg" href="projectController/projectList" role="button">Come on~</a></p>
		</div>
		
		<!-- 项目报表 -->
		<div id="chart">
			
		</div>
		<!-- 用于放置项目列表 -->
		<div id="proList">
			
		</div>
		<jsp:include page="common/loginRegisterModal.jsp"></jsp:include>
	</div>
</body>
</html>
