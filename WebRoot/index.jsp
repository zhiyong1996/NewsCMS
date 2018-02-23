<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>新闻首页</title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/index.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/mymodal.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/reset.css"/>
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
  </head>
  <script>
   var flag = ${flag == null};
  	if(flag){
  		location.href = location.origin+"/NewsCMS/index";
  	}
  </script>
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
                	<li><a href="javascript:;" class="user_name" >${session.username}</a></li>
                	<li><a href="javascript:;" id="quit" >退出</a></li>
                </s:else>
            </ul>
        </div>
    </nav>
    <!--顶部导航栏 navbar end-->
	
    <div class="container advertise" id="ad-top">
    	<div class="ad-img">
    		<a href="javascript:;" id="ad-url"><img id="ad-img"/></a>
    	</div>
        <div class="ad-logo">
        	<small>广告</small>
        </div>
    </div>
    <!--头部广告位 end-->

    <div class="container">
        <div class="row">
            <div class="col-md-8 left">
                <!--轮播-->
                <div id="myCarousel" class="carousel slide">
                <!-- 轮播（Carousel）指标 -->
                    <ol class="carousel-indicators">
                        <s:iterator value="#ca_news" status="st" var="n">
                        	<s:if test="#st.first">
	                     		<li data-target="#myCarousel" data-slide-to="<s:property value='#st.index'/>" class="active"></li>
	                     	</s:if>
	                     	<s:else>
	                     		<li data-target="#myCarousel" data-slide-to="<s:property value='#st.index'/>'/>"></li>
	                     	</s:else>
	                	</s:iterator>
                    </ol>
                    <!-- 轮播（Carousel）项目 -->
                    <div class="carousel-inner">
						<s:iterator value="#ca_news" status="st" var="n">     
						<s:if test="#st.first">
                     		<div class="item active">
                     			<a href="show_detail?createId=<s:property value='#n.createId'/>">
			      				  	<img class="ca_img" src="<s:property value='#n.caimg.path'/>" alt="<s:property value='#n.title'/>">
			      				  	<input type="hidden" value="<s:property value='#st.index'/>">
			      				  	<div class="carousel-caption"><s:property value="#n.title"/></div>
		      				  	</a>
		    				</div>
	                    </s:if>
	                    <s:else>
                     		<div class="item">
                     			<a href="show_detail?createId=<s:property value='#n.createId'/>">
			      				  	<img class="ca_img" src="<s:property value='#n.caimg.path'/>" alt="<s:property value='#n.title'/>">
			      				  	<input type="hidden" value="<s:property value='#st.index'/>">
			      				  	<div class="carousel-caption"><s:property value="#n.title"/></div>
		      				  	</a>
		    				</div>
	                    </s:else>               		
	                    </s:iterator>
                    </div>
                    <!-- 轮播（Carousel）导航 -->
                    <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                    <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
                </div>
                <!--轮播end-->
            </div>

            <div class="col-md-4 col-sm-6 col-xs-12 right">
                <div class="hot-news">
                    <span class="glyphicon glyphicon-play"></span><span class="hot-title">&nbsp;&nbsp;&nbsp;&nbsp;热点新闻</span>
                </div>
                <div class="hot-news-content">
                    <ul class="hot-items">
                    	<s:iterator value="#hot_news" status="st" var="n">
							<li class="hot-item">
								<a href="show_detail?createId=<s:property value='#n.createId'/>">
                            		<p class="hot-item-title"><s:property value="#n.title"/></p>
                            	</a>
                        	</li>
	                	</s:iterator>
                    </ul>
                </div>
            </div>
        
    </div>
    <!--轮播 位置新闻 end-->

    <!--分类显示新闻-->
    <div class="container category">
        <div class="row">
        	<s:iterator value="comNews" var="all" status="st">
        		<div class="catetory-item panel panel-default col-md-5 col-sm-6 col-xs-12">
	                <div class="cateName panel-heading">
	                    <p class="cateN"><s:property value="#all.key"/></p>
	                </div>
	                <ul class="newss panel-body">
		        		<s:iterator value="#all.value" status="s" var="news">
		        			<li class="newsItem"><a href="show_detail?createId=<s:property value='#news.createId'/>"><s:property value="#news.title"/></a></li>
		        		</s:iterator>
	        		</ul>
	        	</div>
        	</s:iterator>
        </div>
    </div>
    <!--分类 end-->

    <!--脚部广告位-->
    <div class="container advertise" id="ad-bot">
    	<div class="ad-img">
    		<a href="javascript:;" id="ad-url"><img id="ad-img"/></a>
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
