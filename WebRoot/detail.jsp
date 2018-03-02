<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>${news.title}</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/index.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/mymodal.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/detail-txt.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/reset.css"/>
    <script src="js/jquery-3.2.1.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </head>
  <body>
  	<!-- 登陆模态框 -->
  	<div class="my-modal">
  		<div class="modal-wrap">
	  		<div class="my-modal-content">
	  			<div class="my-modal-header">
	  				<span class="glyphicon glyphicon-remove modal-close"></span>
	  				<h4>登录</h4>
	  			</div>
	  			<div class="my-modal-body">
	  				<form role="form" id="login-form">
					  <div class="form-group">
					    <input type="text" name="username" class="form-control" id="username" placeholder="请输入用户名">
					  </div>
					  <div class="form-group">
					    <input type="password" name="password" class="form-control" id="password" placeholder="请输入密码">
					  </div>
					  <div class="tip"></div>
					  <button type="submit" class="btn btn-primary btn-block">提交</button>
					</form>
					<p class="prompt-box">
						没有帐号?<span class="to-register register-btn">注册</span>
					</p>
	  			</div>
	  		</div>
  		</div>
  	</div>
        <!--顶部导航栏 navbar -->
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
								<img id="nav-avatar" src="<s:property value='#session.user.Avatar.path'/>">
							</s:else>
                	</a></li>
                	<li><a href="user_info_page?username=${session.username}" id="user_name" >${session.username}</a></li>
                	<li><a href="javacript:;" id="quit" >退出</a></li>
                </s:else>
            </ul>
        </div>
    </nav>
    <!--顶部导航栏 navbar end-->
	
    <!--头部广告位-->
    <div class="container advertise" id="ad-top">
    	<div class="ad-img">
    		<a href="javascript:;" class="ad-url"><img class="ad-img"/></a>
    	</div>
    	<!--<span class="ad-title"></span>-->
        <div class="ad-logo">
        	<small>广告</small>
        </div>
    </div>
    <!--头部广告位 end-->
    
    <!-- 面包屑导航 -->
    <div class="container">
		<ol class="breadcrumb">
			<li><a href="index">首页</a></li>
			<li class="active">新闻阅览</li>
		</ol>
	</div>
	<!-- 面包屑导航end -->
	
    <!-- 新闻主体 --> 
    <div class="container">
    	<div class="row">
    		<!-- 新闻内容 -->
    		<div class="col-md-8 txt">
    			<h2>${news.title}</h2>
    			<p class="from-time"><span class="from">来源: ${news.newsfrom}</span><span class="ctime">${createTime}</span></p> 
    			<hr/>
    			<div class="content" id="content">
    				${news.content}
    			</div>
    			<div class="news-end">
    				<h4 class="end">THE END</h4>
    			</div>
    		</div>
    		<!-- 新闻内容 end-->
    		<div class="col-md-4">
    			<!--侧栏广告位-->
			    <div class="advertise advertise-side" id="ad-side">
			    	<div class="ad-img">
			    		<a href="javascript:;" class="ad-url"><img class="ad-img"/></a>
			    	</div>
			    	<span class="ad-title"></span>
			        <div class="ad-logo">
			        	<small>广告</small>
			        </div>
			    </div>
			    <!--侧栏广告位 end-->
    		</div>
    	</div>
    </div>
    <!-- 新闻主体 end -->
    
    <!-- 新闻评论部分 -->
    <div class="container comment-warp">
    	<div class="row">
		    <div class="news-comment col-md-8">
		    	<div class="comment-header">
		    		<h1 class="header-title left">网友评论</h1>
		    		<p class="comment-protocol left">文明上网理性发言，请遵守新闻评论服务协议</p>
		    		<p class="comment-count right">
		    			<s:if test="comment_count==0">
		    				${comment_count}条评论
		    			</s:if><s:else>
		    				<a href="get_news_comment?createId=${news.createId}">${comment_count}条评论</a>
		    			</s:else>		
		    		</p>
		    	</div>
		    	<div class="comment-area clearfix">
		    		<div class="comment-left left">
		    			<textarea class="comment-content" id="comment"></textarea>
		    		</div>
		    		<s:if test="#session.user==null">
		    			<span class="submit-btn" id="comment-login">
		    				登录
		    			</span>
	    			</s:if><s:else>
	    				<span class="submit-btn" id="submit-comment">
		    				发表评论
		    			</span>
	    			</s:else>
		    	</div>
		    	<div class="comment-user">
		    		<s:if test="#session.user==null">
		    			<ul></ul>
		    		</s:if>
		    		<s:else>
		    			<ul>
		    				<li class="user-avatar"><img src="<s:property value='#session.user.Avatar.path'/>" class="avatar" alt="头像"></li>
		    				<li class="user-name"><span>${session.username}</span></li>
		    				<input type="hidden" id="userId" value="${session.user.id}"/>
		    				<li class="slide">|</li>
		    			</ul>
	    			</s:else>
		    	</div>
		    </div>
	    	<div class="col-md-4">
	    	
	    	</div>
	    </div>
	</div>
    <!-- 评论结束 -->
    
    <!--脚部广告位-->
    <div class="container advertise" id="ad-bot">
    	<div class="ad-img">
    		<a href="javascript:;" class="ad-url"><img class="ad-img"/></a>
    	</div>
    	<!--<span class="ad-title"></span>-->
        <div class="ad-logo">
        	<small>广告</small>
        </div>
    </div>
    <!--脚部广告位 end-->
    
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-5">
                    <div class="footer-logo">
                        <a href="javascript:;"><img src="Nimg/logoko.png" alt="logo"></a>
                    </div>
                </div>
                <div class="col-md-5 footer-cate">
                    <ul>
                        <li>时政</li>
                        <li>经济</li>
                        <li>军事</li>
                        <li>社会</li>
                        <li>国际</li>
                        <li>健康</li>
                    </ul>
                </div>
            </div>

        </div>
    </footer>
    <div class="foot">
        <div class="container">
            <p>@ 2017-2018 zzy版权所有 | 联系方式: 814793367@qq.com | <a href="javascript:;">意见反馈</a></p>
        </div>
    </div>
    <script src="Njs/login_quit.js"></script>
    <script src="Njs/get_ad.js"></script>
    <script>
    	$(document).ready(function(){
    		$("#comment-login").on("click",function(e){
    			$(".my-modal").fadeIn();
    		});
    		$("#submit-comment").on("click",function(e){
    			var comment = $("#comment").val();
    			console.log(comment)
    			$.ajax({
    				type: "post",
    				url: "add_com",
    				datatype: "json",
    				data: {
    					newsId: ${news.id},
    					userId: $("#userId").val(),
    					comment: comment
    				},
    				success: function(data){
    					if(data.code==0){
    						alert(data.msg);
    					}else{
    						alert(data.msg);
    					}
    				},
    				error: function(data){
    					alert("网络异常");
    				}
    			});
    		});	
    	});
    </script>
  </body>
</html>
