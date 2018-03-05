<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册结果</title>
    
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/index.css"/>
    <script src="js/jquery-3.2.1.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
  </head>
  
  <body>
  	<div class="container" style="maring-top:100px;">
    	<div class="jumbotron">
  			<h1>News账户注册成功</h1>
			<p class="username">${msg}</p>
  			<p><a class="btn btn-primary btn-lg" href="load" role="button">现在就去登录</a></p>
		</div>
	</div>
  </body>
</html>
