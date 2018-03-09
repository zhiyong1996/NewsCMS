<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">   
    <title>My JSP 'addNewsSuc.jsp' starting page</title>
  </head>
  
  <body>
    <div>添加新闻成功</div>
    <a href="select_news">返回创建新闻页面</a>
  </body>
</html>
