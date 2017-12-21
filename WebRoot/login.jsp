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
    <script>
    	if(window!=top){
    		top.location.href = location.href;
    	}
    </script>
  </head>
  <style>
  	html,body{
  		height: 100%;
  		
  	}
  	
  	.container{
  		position: relative;
  		height: 100%;
  		background: url(img/login_bg.jpg);
  		/*margin-top: 100px;*/
  		
  	}
  	.header{
  		padding: 12px 30px;
  		background-image: linear-gradient(to top, #e6e9f0 0%, #eef1f5 100%);
  		box-shadow: 0 6px 15px rgba(36,37,38,0.08);
  	}
  	.login-box{
  		position: absolute;
  		top: 40%;
  		left: 50%;
  		transform: translate(-50%,-50%);
  		padding: 30px 18px;
    	width: 300px;
    	background: rgba(255,255,255,.9);
    	box-shadow: 0 6px 15px rgba(36,37,38,0.08);
  	}
  	.login-title{
  		padding: 10px 0;
  	}
  	.layui-input-block{
  		margin-left: 0;
  	}
  </style>
  <body>
    <div class="container">
    	<header class="header">
    		<h1><small>欢迎使用</small>NewsCMS</h1>
    	</header>
   		<div class="login-box">
   			<h2 class="login-title">登录NewsCMS</h2>
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
    <script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
  </body>
</html>
