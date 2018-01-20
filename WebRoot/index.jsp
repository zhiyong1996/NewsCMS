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
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
  </head>
  
  <body>
    <!--顶部导航栏 navbar -->
	<nav class="navbar navbar-danger navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <a href="" class="navbar-brand"><img class="logo" src="News/Nimg/logo.png" alt="logo"></a>
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

    <!--轮播 位置新闻-->
    <div class="container carousel">
        <div class="row">

            <div class="col-md-8 left">
                <!--轮播-->
                <div id="myCarousel" class="carousel slide">
                <!-- 轮播（Carousel）指标 -->
                    <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                        <li data-target="#myCarousel" data-slide-to="2"></li>
                    </ol>
                    <!-- 轮播（Carousel）项目 -->
                    <div class="carousel-inner">
                        <% 
                        	List<Object> list = ActionContext.getContext().get("ca_news");
                        	for(int i=0;i<list.size();i++){
                        %>
                        <div class="item">
                        	111111111
                        </div>
                        <%} %>
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
                        <li class="hot-item">
                            <p class="hot-item-title"><a href="">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></p>
                            <div class="keyword">
                                <span class="label label-danger">关键字</span>
                            </div>
                        </li>
                        <li class="hot-item">
                            <p class="hot-item-title"><a href="">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></p>
                            <div class="keyword">
                                <span class="label label-danger">关键字</span>
                            </div>
                        </li>
                        <li class="hot-item">
                            <p class="hot-item-title"><a href="">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></p>
                            <div class="keyword">
                                <span class="label label-danger">关键字</span>
                            </div>
                        </li>
                        <li class="hot-item">
                            <p class="hot-item-title"><a href="">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></p>
                            <div class="keyword">
                                <span class="label label-danger">关键字</span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!--轮播 位置新闻 end-->

    <!--分类显示新闻-->
    <div class="container category">
        <div class="row">
            <div class="catetory-item panel panel-default col-md-5 col-sm-6 col-xs-12">
                <div class="cateName panel-heading">
                    <p class="cateN">时政</p>
                </div>
                <ul class="newss panel-body">
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                </ul>
            </div>
            <div class="catetory-item panel panel-default col-md-5 col-sm-6 col-xs-12">
                <div class="cateName panel-heading">
                    <p class="cateN">经济</p>
                </div>
                <ul class="newss panel-body">
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                </ul>
            </div>
            <div class="catetory-item panel panel-default col-md-5 col-sm-6 col-xs-12">
                <div class="cateName panel-heading">
                    <p class="cateN">军事</p>
                </div>
                <ul class="newss panel-body">
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                </ul>
            </div>
            <div class="catetory-item panel panel-default col-md-5 col-sm-6 col-xs-12">
                <div class="cateName panel-heading">
                    <p class="cateN">社会</p>
                </div>
                <ul class="newss panel-body">
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                </ul>
            </div>
            <div class="catetory-item panel panel-default col-md-5 col-sm-6 col-xs-12">
                <div class="cateName panel-heading">
                    <p class="cateN">国际</p>
                </div>
                <ul class="newss panel-body">
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                </ul>
            </div>
            <div class="catetory-item panel panel-default col-md-5 col-sm-6 col-xs-12">
                <div class="cateName panel-heading">
                    <p class="cateN">健康</p>
                </div>
                <ul class="newss panel-body">
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                    <li class="newsItem"><a href="javascript:;">宜家涉嫌巨额逃税遭欧盟调查 逃税额可达10亿欧元</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!--分类 end-->

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
                        <a href="javascript:;"><img src="News/Nimg/logoko.png" alt="logo"></a>
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
