<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户详细资料</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  <style>
  	.data-show{
  		line-height: 38px;
  	}
  </style>
  <body style="padding:30px">
      <div class="top" style="display: fixed;top: 0;left: 0;">
	  	<button class="layui-btn" onclick="history.go(-1)"><i class="fa fa-angle-double-left" aria-hidden="true"></i>  返回</button>
	  </div>
	  <div class="layui-fluid">
  		 <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
	  	 	<legend>用户详细资料</legend>
		</fieldset>
		<div class="layui-form">
			<div class="layui-form-item">
				<label class="layui-form-label">头像:</label>
				<div class="layui-input-block">
					<img class="avatar-img" style="width: 160px" src="${avatar_path}"/>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">用户名:</label>
				<div class="layui-input-block">
					<span class="data-show">${user.username}</span>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">昵称:</label>
				<div class="layui-input-block">
					<span class="data-show">${user.name}</span>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">签名:</label>
				<div class="layui-input-block">
					<span class="data-show">${user.headline}</span>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">email:</label>
				<div class="layui-input-block">
					<span class="data-show">${user.email}</span>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">加入时间:</label>
				<div class="layui-input-block">
					<span class="data-show">${user.createTime}</span>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">最后登录:</label>
				<div class="layui-input-block">
					<span class="data-show">${user.lastlogin}</span>
				</div>
			</div>
		</div>
	  </div>
  </body>
</html>
