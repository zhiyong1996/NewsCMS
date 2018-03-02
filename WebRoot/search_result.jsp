<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>查询结果</title>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/index.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/mymodal.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/detail-txt.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/reset.css"/>
    <script src="js/jquery-3.2.1.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </head>
  <style>
  	.search-wrap{
  		padding: 10px;
  		min-height: 440px;
  	}
  	.time{
  		font-size: 13px;
  		color: #9c9c9c;
  	}
  </style>
  <body>
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
                	<li  class="nav-ava"><a href="user_info_page?username=${session.username}">
						<img id="nav-avatar" src="<s:property value='#session.user.Avatar.path'/>">
                	</a></li>
                	<li><a href="user_info_page?username=${session.username}" id="user_name" >${session.username}</a></li>
                	<li><a href="javascript:;" id="quit" >退出</a></li>
                </s:else>
            </ul>
        </div>
    </nav>
    <!--顶部导航栏 navbar end-->
	
    <!--头部广告位-->
    <div class="container advertise" id="ad-top">
    	<div class="ad-img">
    		<a href="javascript:;" class="ad-url"><img class="ad-‫img"/></a>
    	</div>
        <div class="ad-logo">
        	<small>广告</small>
        </div>
    </div>
    <!--头部广告位 end-->
    
    <div class="container">
		<ol class="breadcrumb">
			<li><a href="load">首页</a></li>
			<li class="active">新闻搜索</li>
		</ol>
	</div>
	
	<!-- 主体 -->
	<div class="container search-wrap">
		<div class="col-md-8">
			<h3>站内搜索: ${keyword}</h3>
			<hr/>
			<p class="result-count">当前有${size}条相关新闻</p>
			<div class="result-list">
				<s:iterator value="search_news" status="s" var="n">
					<div class="result-list-item">
						<h4 class="news-title"><a href="show_detail?createId=<s:property value='#n.createId'/>"><s:property value="#n.title"/></a></h4>
						<p class='time'><s:property value="#n.createTimeS"/></p>
					</div>
				</s:iterator>
			</div>
		</div>
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
	<!-- 主体end -->
	
	<!--脚部广告位-->
    <div class="container advertise" id="ad-bot">
    	<div class="ad-img">
    		<a href="javascript:;" class="ad-url"><img class="ad-‫img"/></a>
    	</div>
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
  </body>
</html>
