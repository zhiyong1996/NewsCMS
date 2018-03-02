<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>NewsPreview</title>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
  </head>
  <style>
  	#content{
  		width:690px;
  		font-size: 18px;
  	}
  	.h2{
  		padding: 10px 0;
  	}
  </style>
  <body style="padding:30px;">
	<div class="top" style="display: fixed;top: 0;left: 0;">
		<button class="layui-btn" onclick="history.go(-1)"><i class="fa fa-angle-double-left" aria-hidden="true"></i>  返回</button>
	</div>
	<hr class="layui-hr-blue"/>
	<div class="main">
		<h2 class="h2">${backnews.title}</h2>
		<p class="layui-text">来源:${backnews.newsfrom}&nbsp;&nbsp; ${backnews.createTime}</p> 
		<hr class="layui-bg-blue" style="width:690px">
		<div class="content" id="content">
			${backnews.content}
		</div>
	</div>
    <script>
    </script>
  </body>
</html>
