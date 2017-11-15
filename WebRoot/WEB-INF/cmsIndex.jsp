<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>My JSP 'cmsIndex.jsp' starting page</title>    
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/layui/css/layui.css">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
  </head>
<style>
  .layui-layout-admin .layui-body{
    bottom: 0;
  }
</style>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">layui 后台布局</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="">控制台</a></li>
      <li class="layui-nav-item"><a href="">商品管理</a></li>
      <li class="layui-nav-item"><a href="">用户</a></li>
      <li class="layui-nav-item">
        <a href="javascript:;">其它系统</a>
        <dl class="layui-nav-child">
          <dd><a href="">邮件管理</a></dd>
          <dd><a href="">消息管理</a></dd>
          <dd><a href="">授权管理</a></dd>
        </dl>
      </li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
          <%=session.getAttribute("admin") %>
        </a>
        <dl class="layui-nav-child">
          <dd><a href="">基本资料</a></dd>
          <dd><a href="">安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="">退了</a></li>
    </ul>
  </div>

  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">新闻类型管理</a>
          <dl class="layui-nav-child">
            <dd><a href="go_addC" target="target">添加类型</a></dd>
            <dd><a href="go_listC" target="target">类型管理</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;">新闻管理</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:;" target="target">发布新闻</a></dd>
            <dd><a href="go_addNews" target="target">添加新闻</a></dd>
            <dd><a href="go_listNews" target="target">新闻管理</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item"><a href="" target="target">用户管理</a></li>
        <li class="layui-nav-item"><a href="" target="target">广告管理</a></li>
      </ul>
    </div>
  </div>

  <div class="layui-body">
    <iframe src="welcome.html" frameborder="0" width="100%" height="100%" name="target"></iframe>
  </div>

</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
<script>
//JavaScript代码区域
layui.use('element', function(){
  var element = layui.element;

});
</script>
  </body>
</html>
