<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>NewsPreview</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/Normalize.css">

  <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
  </head>
  <style>
  	#content{
  		width:690px;
  		font-size: 18px;
  	}
  </style>
  <body style="padding:30px;">
    <div class="main">
    	<h2>${backnews.title}</h2>
    	<p>来源:${backnews.newsfrom}&nbsp;&nbsp; ${backnews.createTime}</p> 
    	<hr/>
    	<div class="content" id="content">
    		
    	</div>
    </div>
    <script>
    	$("#content").html(unescape("${backnews.content}"));
    </script>
  </body>
</html>
