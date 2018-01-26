<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>${news.title}</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/index.css"/>
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


  </head>
  <style>
  	.txt{
  		padding-bottom: 30px;
  	}
  	.txt img{
  		max-width: 100%;
  	}
  	.from-time{
  		font-size: 12px;
  		color: #999;
  	}
  	.ctime{
  		margin-left: 20px;
  	}
  </style>
  <body>
        <!--顶部导航栏 navbar -->
	<nav class="navbar navbar-danger navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <a href="" class="navbar-brand"><img class="logo" src="Nimg/logo.png" alt="logo"></a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="javacript:;">新闻首页</a></li>
                <li><a href="javacript:;">登录</a></li>
                <li><a href="javacript:;">注册</a></li>
            </ul>
        </div>
    </nav>
    <!--顶部导航栏 navbar end-->

    <!--头部广告位-->
    <div class="container advertise-top">
        <div class="ad-logo"><small>广告</small></div>
    </div>
    <!--头部广告位 end-->
    
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
    		</div>
    		<!-- 新闻内容 end-->
    		<div class="col-md-4"></div>
    	</div>
    </div>
    <!-- 新闻主体 end -->
    
    <!--脚部广告位-->
    <div class="container advertise-top">
        <div class="ad-logo"><small>广告</small></div>
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
  </body>
</html>
