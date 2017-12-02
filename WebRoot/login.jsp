<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  <style>
  	
  </style>
  <body>
    <div class="layui-container">
    	<div class="layui-row">
    		<div class="layui-col-md4 layui-col-md-offset4 login">
    			<form class="layui-form" method="post" action="login/loginAction">
    				<div class="layui-form-item">
    					<div class="layui-input-block">
    						<input id="username" name="username" type="text" required  lay-verify="required" maxlength="30" placeholder="用户名" autocomplete="off" class="layui-input">
    					</div>
    				</div>
    				<div class="layui-form-item">
    					<div class="layui-input-block">
    						<input id="password" name="password" type="password" required  lay-verify="required" maxlength="30" placeholder="密码" autocomplete="off" class="layui-input">
    					</div>
    				</div>
    				<div class="layui-form-item">
    					<div class="layui-input-block">
    						<input class="layui-btn" type="submit" value="登录">
    					</div>
    				</div>
    			</form>
    		</div>
    	</div>
    </div>
    <script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
  </body>
</html>
