<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Object admin = session.getAttribute("user");
if(admin == null){
	response.sendRedirect(path+"/load");
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
    <script src="js/jquery-3.2.1.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
  </head>
  
  <body>
    <nav class="navbar navbar-danger navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <a href="load" class="navbar-brand"><img class="logo" src="Nimg/logo.png" alt="logo"></a>
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
                <li><a href="load">新闻首页</a></li>
                <s:if test="#session.user==null">
                	<li class="to-login"><a class="login-btn" >登录</a></li>
                	<li class="to-register"><a class="register-btn" >注册</a></li>
                </s:if>
                <s:else>
                	<li  class="nav-ava">
                		<a href="user_info_page?username=${session.username}">
							<img id="nav-avatar" src="<s:property value="#session.user.Avatar.path"/>">
                		</a>
                	</li>
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
			<li><a href="load">首页</a></li>
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
				<li><a href="#changePass" data-toggle="tab">更改密码</a></li>
			</ul>
			
			<!-- 选项卡内容 -->
			<div id="myTabContent" class="tab-content col-md-8">
				<div class="tab-pane fade in active " id="profile">
					<div class="avatar-username-wrap clearfix">
						<div class="user-avatar left">
								<img class="avatar-img" id="avatar-img" src="<s:property value='#session.user.Avatar.path'/>">
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
					<div class="name-wrap">
						<form class="info-item ">
							<h4 class="info-field">昵称</h4>
							<div class="info-content">
								<span class="info-show">${user.name}</span>
								<input type="text" id="name" class="col-md-1 form-control info-edit" name="name" value="${user.name}"/>
							</div>
						</form>
					</div>
					<div class="sex-wrap">
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
					<div class="headline-wrap">
						<form class="info-item ">
							<h4 class="info-field">签名</h4>
							<div class="info-content">
								<span class="info-show">${user.headline}</span>
								<input type="text" id="headline" class="col-md-2 form-control info-edit" name="headline" value="${user.headline}"/>
							</div>
						</form>
					</div>
					<div class="email-wrap">
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
					<h3>我的评论:</h3>
					<s:if test="size>0">
						<s:iterator value="my_comment" var="my_c" status="st">
							<div class="comment-item">
							<p class="comment-news-title">
								新闻:<a href="show_detail?createId=<s:property value='#my_c.news.createId'/>"><s:property value='#my_c.news.title'/></a>
							</p>
							<p class="comment-content">
								评论内容:<s:property value="#my_c.content"/>
							</p>
						</div>
						</s:iterator>
					</s:if>			
					<s:else>
						<h4>你还没有评论过新闻</h4>
					</s:else>
					<div class="comments">
						<s:property value="my_comment.count"/>
						<s:iterator value="my_comment" var="my_c" status="st">
							<div class="comment-item">
							<p class="comment-news-title">
								新闻:<a href="show_detail?createId=<s:property value='#my_c.news.createId'/>"><s:property value='#my_c.news.title'/></a>
							</p>
							<p class="comment-content">
								评论内容:<s:property value="#my_c.content"/>
							</p>
						</div>
						</s:iterator>
						
					</div>
				</div>
				<div class="tab-pane fade" id="changePass">
					<form class="form-horizontal" role="form" id="pass-form">
					  <div class="form-group">
					    <label class="col-sm-3 control-label">原密码</label>
					    <div class="col-sm-5">
					      <input type="password" class="form-control" id="oldPass" placeholder="请输入密码">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="inputPassword" class="col-sm-3 control-label">新密码</label>
					    <div class="col-sm-5">
					      <input type="password" class="form-control" id="newPass" placeholder="请输入密码">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="inputPassword" class="col-sm-3 control-label">再次输入新密码</label>
					    <div class="col-sm-5">
					      <input type="password" class="form-control" id="newPassAgain" placeholder="请输入密码">
					    </div>
					  </div>
					  <span class="help-block col-sm-offset-3 text-danger" id="help" style="color:red;"></span>
					  <div class="form-group">
					    <div class="col-sm-offset-3 col-sm-10">
					      <button type="submit" class="btn btn-default">提交</button>
					    </div>
					  </div>
					</form>
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
			var uid = $("#uid").val();
			$("#pass-form").on("submit",function(e){
				e.preventDefault();
				var oldpass = $("#oldPass").val();
				var newpass = $("#newPass").val();
				var newpassagain = $("#newPassAgain").val();
				if(newpass!=newpassagain){
					$("#help").text("两次密码不一致");
					return;
				}else if(newpass.length<6||newpassagain.length<6){
					$("#help").text("密码长度小于6");
					return;
				}
				$.ajax({
					type: "post",
					dataType: "json",
					url: "update_password",
					data:{
						password: oldpass,
						newpassword: newpass,
						uid: uid
					},
					success:function(data){
						if(data.code>0){
							$("#help").text(data.msg);
						}else{
							alert("修改成功,请重新登录");
							history.go(0);
						}
					},
					error: function(e){
						console.log(e);
						alert("网络出错，请稍候尝试");
					}
				});
			});
		});
	</script>
  </body>
</html>
