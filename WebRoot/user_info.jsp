<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Object admin = session.getAttribute("user");
if(admin == null){
	response.sendRedirect(path+"/index");
}
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>个人资料</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/index.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/mymodal.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/reset.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/user-info.css"/>
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
  </head>
  
  <body>
    <nav class="navbar navbar-danger navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <a href="index" class="navbar-brand"><img class="logo" src="Nimg/logo.png" alt="logo"></a>
            </div>
            <div>
		        <form class="navbar-form navbar-left" role="search" method="post" action="search">
		            <div class="form-group">
		                <input id="keyword" name="keyword" type="text" class="form-control" placeholder="Search" required>
		            </div>
		            <button id="submit_key" type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span>搜索</button>
		        </form>
		    </div>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="index">新闻首页</a></li>
                <s:if test="#session.user==null">
                	<li class="to-login"><a class="login-btn" >登录</a></li>
                	<li class="to-register"><a class="register-btn" >注册</a></li>
                </s:if>
                <s:else>
                	<li  class="nav-ava"><a href="user_info_page?username=${session.username}">
                		<s:if test="avatar_path==''">
								<img id="nav-avatar" src="Nimg/user.jpg">
							</s:if><s:else>
								<img id="nav-avatar" src="<s:property value="#session.user.Avatar.path"/>">
							</s:else>
                	</a></li>
                	<li><a href="user_info_page?username=${session.username}" class="user_name" >${session.username}</a></li>
                	<li><a href="javascript:;" id="quit" >退出</a></li>
                </s:else>
            </ul>
        </div>
    </nav>
    <!--顶部导航栏 navbar end-->
    
    <!-- 面包屑导航 -->
    <div class="container bread-nav">
		<ol class="breadcrumb">
			<li><a href="index">首页</a></li>
			<li class="active">个人资料</li>
		</ol>
	</div>
	<!-- 面包屑导航end -->
    
    <!-- 主体 -->
    <div class="container main-content">
    	<div class="tabs-left row">
    		<!--  选项卡导航   -->
		  	<ul id="myTab" class="nav nav-pills nav-stacked col-md-2">
				<li class="active">
					<a href="#profile" data-toggle="tab">个人资料</a>
				</li>
				<li><a href="#my-comment" data-toggle="tab">我的评论</a></li>
			</ul>
			
			<!-- 选项卡内容 -->
			<div id="myTabContent" class="tab-content col-md-8">
				<div class="tab-pane fade in active " id="profile">
					<div class="avatar-username-wrap clearfix">
						<div class="user-avatar left">
							<s:if test="avatar_path==''">
								<img class="avatar-img" id="avatar-img" src="Nimg/user.jpg">
							</s:if><s:else>
								<img class="avatar-img" id="avatar-img" src="${avatar_path}">
							</s:else>
							<div class="avatar-upload">
								<label for="avatar-file" class="ui-btn"><span class="glyphicon glyphicon-camera"></span>  更换头像</label>
								<form id="avatar-form">
									<input type="file" id="avatar-file" accept="image/png, image/jpeg, image/gif, image/jpg" style="display:none;"/>
								</form>
							</div>
						</div>
						<div class="left username-wrap">
							<h3 class="name">${user.username}</h3>
							<input type="hidden" id="uid" value="${user.id }"/>
							<p class="jointime">加入时间: 2017年1月12号 22:33:30</p>
						</div>
					</div>
					<div class="name-warp">
						<form class="info-item ">
							<h4 class="info-field">昵称</h4>
							<div class="info-content">
								<span class="info-show">${user.name}</span>
								<input type="text" id="name" class="col-md-1 form-control info-edit" name="name" value="${user.name}"/>
							</div>
						</form>
					</div>
					<div class="sex-warp">
						<form class="info-item ">
							<h4 class="info-field">性别</h4>
							<div class="info-content">
								<s:if test="user.sex==1">
									<span class="info-show">男</span>
									<div class="info-edit">
										<input class="info-edit" type="radio" id="male" name="sex" value="1" style="margin: 0 30px" checked/>男
										<input class="info-edit" type="radio" id="female" name="sex" value="2" style="margin: 0 30px"/>女
									</div>
								</s:if>
								<s:elseif test="user.sex==2">
									<span class="info-show">女</span>
									<div class="info-edit">
										<input class="info-edit" type="radio" id="male" name="sex" value="1" style="margin: 0 30px"/>男
										<input class="info-edit" type="radio" id="female" name="sex" value="2" style="margin: 0 30px" checked/>女
									</div>
								</s:elseif>
								<s:else>
									<span class="info-show">未知</span>
									<div class="info-edit">
										<input class="info-edit" type="radio" id="male" name="sex" value="1" style="margin: 0 30px"/>男
										<input class="info-edit" type="radio" id="female" name="sex" value="2" style="margin: 0 30px"/>女
									</div>
								</s:else>
							</div>
						</form>
					</div>
					<div class="headline-warp">
						<form class="info-item ">
							<h4 class="info-field">签名</h4>
							<div class="info-content">
								<span class="info-show">${user.headline}</span>
								<input type="text" id="headline" class="col-md-2 form-control info-edit" name="headline" value="${user.headline}"/>
							</div>
						</form>
					</div>
					<div class="email-warp">
						<form class="info-item ">
							<h4 class="info-field">邮箱</h4>
							<div class="info-content">
								<span class="info-show">${user.email}</span>
								<input type="email" id="email" class="col-md-2 form-control info-edit" name="email" value="${user.email}"/>
							</div>
						</form>
					</div>
					<div class="edit-btn">
						<div class="edit-btn-group">
							<button class="btn btn-primary info-show" id="edit-btn"><span class="glyphicon glyphicon-edit"></span>修改</button>
							<button class="btn btn-primary info-edit" id="save-btn"><span class="glyphicon glyphicon-ok"></span>保存</button>
							<button class="btn btn-default info-edit" id="cancel-btn"><span class="	glyphicon glyphicon-remove"></span>取消</button>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="my-comment">
					<p>iOS 是一个由苹果公司开发和发布的手机操作系统。最初是于 2007 年首次发布 iPhone、iPod Touch 和 Apple 
						TV。iOS 派生自 OS X，它们共享 Darwin 基础。OS X 操作系统是用在苹果电脑上，iOS 是苹果的移动版本。</p>
				</div>
			</div>
		</div>
    </div>
    <div class="foot">
        <div class="container">
            <p>@ 2017-2018 zzy版权所有 | 联系方式: 814793367@qq.com | <a href="javascript:;">意见反馈</a></p>
        </div>
    </div>
    <script src="Njs/login_quit.js"></script>
    <script src="Njs/user_update.js"></script>
	<script>
		$(document).ready(function(e){
			
		});
	</script>
  </body>
</html>
