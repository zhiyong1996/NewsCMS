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
  	<div class="modal fade" tabindex="-1" role="dialog" id="myModal">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">Modal title</h4>
	      </div>
	      <div class="modal-body">
	        <p>One fine body&hellip;</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<!-- 登录模态框end -->

	<nav class="navbar navbar-danger navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <a href="" class="navbar-brand"><img class="logo" src="Nimg/logo.png" alt="logo"></a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="javacript:;">新闻首页</a></li>
                <s:if test="#session.user==null">
                	<li><button class="btn btn-default navbar-btn" data-href="javacript:;" data-toggle="modal" data-target="#myModal">登录</a></li>
                	<li><button class="btn btn-default navbar-btn" data-href="javacript:;">注册</a></li>
                </s:if>
                <s:else>
                	<li><button class="btn btn-default navbar-btn" data-href="javacript:;">${session.user}</a></li>
                	<li><button class="btn btn-default navbar-btn" data-href="javacript:;">退出</a></li>
                </s:else>
            </ul>
        </div>
    </nav>
    <!--顶部导航栏 navbar end-->

    <div class="container advertise-top">
        <div class="ad-logo"><small>广告</small></div>
    </div>
    <!--头部广告位 end-->

    <div class="container carousel">
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
                            <div class="keyword">
                                <span class="label label-danger">关键字</span>
                            </div>
                        </li>
	                	</s:iterator>
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