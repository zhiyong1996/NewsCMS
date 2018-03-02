<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>   
    <title>选择新闻位置</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body style="padding: 10px;">
  <fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;padding: 10px;">
  	<legend>请创建文章类型</legend>
  	<a class="layui-btn layui-btn-normal layui-btn-lg" href="go_add_news?newstype=0">新建普通新闻</a>
    <a class="layui-btn layui-btn layui-btn-lg" href="go_add_news?newstype=1">新建轮播新闻</a>
    <a class="layui-btn layui-btn-warm layui-btn-lg" href="go_add_news?newstype=2">新建热点新闻</a>
    </fieldset>
    <script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
  </body>
</html>
