<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册成功</title>
    
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/index.css"/>
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
  </head>
  
  <body>
    <div class="jumbotron">
  		<h1>News账户</h1>
  		
		<%
			Map rs = ActionContext.getContext();
			if(rs.get("rs")==true){
		%>
		<p>${msg}</p>
  		<p><a class="btn btn-primary btn-lg" href="#" role="button">现在就去登录</a></p>
  		<%}else{ %>
  		<p>${msg}</p>
  		<%} %>
	</div>
  </body>
</html>
