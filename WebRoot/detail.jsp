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
    <link rel="stylesheet" type="text/css" href="Ncss/comment.css"/>
    <script src="js/jquery-3.2.1.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </head>
  <style>
  	.carousel{
  		width: 100%;
  	}
  	.advertise-side .carousel-inner .item{
  		width: 100%;
  	}
  </style>
  <body>
  	  	<div class="modal-bg"></div>
  	<!-- 举报功能 -->
  	<div class="report-warp">
  		<div class="report-header clearfix">
  			<div class="report-title report-header-item">评论举报</div>
  			<div class="report-header-close" id="close-report"> 关闭
  				<span class="glyphicon glyphicon-remove"></span>
  			</div>
		</div>
		<div class="report-content">
  			<form role="form" id="report-form">
  				<p>您为什么要举报该评论</p>
			    <div class="radio">
					<label>
						<input type="radio" name="report-type" id="re-type1" value="内容不适">内容不适
					</label>
				</div>
			    <div class="radio">
					<label>
						<input type="radio" name="report-type" id="re-type2" value="侮辱谩骂">侮辱谩骂
					</label>
				</div>
				<div class="radio">
					<label>
						<input type="radio" name="report-type" id="re-type3" value="其他">其他
					</label>
				</div>
			  <div class="form-group">
			    	<label for="state">举报说明(可选)</label>
			    	<input type="text" class="form-control" id="addition" placeholder="附加内容">
			  </div>
			  <div class="tip"></div>
			  <button type="submit" id="submit-report" class="btn btn-primary btn-block">提交</button>
			</form>
  		</div>
  	</div>
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
    <div class="container advertise no-padding" id="ad-top">
	    <s:iterator value="topAd" status="st" var="ad">
	    	<div class="ad-item">
		    	<div class="ad-img">
		    		<a href="<s:property value='#ad.url'/>" class="ad-url">
		    			<img class="ad-img" src="<s:property value='#ad.adimg.path'/>"/>
		    		</a>
		    	</div>
		    	<div class="ad-logo">
		        	<small>广告</small>
		        </div>
	        </div>
	    </s:iterator> 
    </div>
    <!--头部广告位 end-->	
    
    <!-- 面包屑导航 -->
    <div class="container no-padding">
		<ol class="breadcrumb">
			<li><a href="load">首页</a></li>
			<li class="active">新闻阅览</li>
		</ol>
	</div>
	<!-- 面包屑导航end -->
	
    <!-- 新闻主体 --> 
    <div class="container">
    	<div class="row">
    		<!-- 新闻内容 -->
    		<div class="news-wrap col-md-8 txt">
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
			    	<div id="adCarousel" class="carousel slide" data-ride=”carousel”> 
	                <!-- 轮播（Carousel）指标 -->
	                    <ol class="carousel-indicators">
	                        <s:iterator value="sideAd" status="st" var="ad">
	                        	<s:if test="#st.first">
		                     		<li data-target="#adCarousel" data-slide-to="<s:property value='#st.index'/>" class="active"></li>
		                     	</s:if>
		                     	<s:else>
		                     		<li data-target="#adCarousel" data-slide-to="<s:property value='#st.index'/>"></li>
		                     	</s:else>
		                	</s:iterator>
	                    </ol>
	                    <!-- 轮播（Carousel）项目 -->
	                    <div class="carousel-inner">
							<s:iterator value="sideAd" status="st" var="ad">     
							<s:if test="#st.first">
	                     		<div class="item active">
	                     			<a href="<s:property value='#ad.url'/>">
				      				  	<img class="ca_img" src="<s:property value='#ad.adimg.path'/>">
				      				  	<div class="carousel-caption"><s:property value="#ad.about"/></div>
			      				  	</a>
			    				</div>
		                    </s:if>
		                    <s:else>
	                     		<div class="item">
	                     			<a href="<s:property value='#ad.url'/>">
				      				  	<img class="ca_img" src="<s:property value='#ad.adimg.path'/>">
				      				  	<div class="carousel-caption"><s:property value="#ad.about"/></div>
			      				  	</a>
			    				</div>
		                    </s:else>               		
		                    </s:iterator>
	                    </div>
	                    <!-- 轮播（Carousel）导航 -->
	                    <a class="carousel-control left" href="#adCarousel" data-slide="prev">&lsaquo;</a>
	                    <a class="carousel-control right" href="#adCarousel" data-slide="next">&rsaquo;</a>
	                </div>
		    	</div>
			    <!--侧栏广告位 end-->
    		</div>
    	</div>
    </div>
    <!-- 新闻主体 end -->
    
    <!-- 新闻评论部分 -->
    <div class="container comment-warp no-padding">
    	<div class="row">
		    <div class="news-comment col-md-8 common-wrap">
		    	<h2 class="comment-title">网友评论</h2>
		    	<div class="all-comments">
		    	<s:if test="comment_count==0">
		    		<p class="no-comment">当前还没有评论</p>
		    	</s:if><s:else>
		    		
					<s:iterator value="news_com_json" status="st" var="n">   
						<div class="media comment-item">
						    <a class="media-left" href="javascript:;">
						        <img class="media-object comment-user-avatar" src="<s:property value='#n.user.Avatar.path'/>" alt="媒体对象">
						    </a>
						    <div class="media-body">
						        <h4 class="media-heading">
						        	<s:property value="#n.user.username"/>
						        	<small class="comment-time">发布于:<s:property value="#n.createTimeS"/></small>
						        	<s:if test="#session.user==null">
						        		<span class="report">
						        			<a href="javascript:;" class="report-btn" comid="<s:property value='#n.id'/>"><span class="glyphicon glyphicon-exclamation-sign"></span>  举报</a>
						        		</span>
						        	</s:if><s:elseif test="#session.user.id!=#n.user.id">
						        		<span class="report">
						        			<a href="javascript:;" class="report-btn" comid="<s:property value='#n.id'/>"><span class="glyphicon glyphicon-exclamation-sign"></span>  举报</a>
						        		</span>
						        	</s:elseif>
						        </h4>
								<div class="comment-item-content">
									<s:property value="#n.content"/>
								</div>
						    	
						    </div>
						</div>
					</s:iterator>
					</s:else>
				</div>
		    	<div class="comment-header">
		    		<h1 class="header-title left">发布评论</h1>
		    		<p class="comment-protocol left">文明上网理性发言，请遵守新闻评论服务协议</p>
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
    <div class="container advertise no-padding" id="ad-bot">
	    <s:iterator value="botAd" status="st" var="ad">
	    	<div class="ad-item">
		    	<div class="ad-img">
		    		<a href="<s:property value='#ad.url'/>" class="ad-url">
		    			<img class="ad-img" src="<s:property value='#ad.adimg.path'/>"/>
		    		</a>
		    	</div>
		    	<div class="ad-logo">
		        	<small>广告</small>
		        </div>
	        </div>
	    </s:iterator> 
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
    <script>
    $(document).ready(function(){
   		$(".comment-item").on("mouseover",function(e){
   			$(this).find(".report").show();
   		}).on("mouseleave",function(e){
   			$(this).find(".report").hide();
   		});
   		var comid;
   		var uid;
   		$("#comment-login").on("click",function(e){
   			$(".my-modal").fadeIn();
   		});
   		$("#submit-comment").on("click",function(e){
   			var comment = $("#comment").val();
   			console.log(comment)
   			if(comment ==="" ){
   				return ;
   			}
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
   						location.reload();
   					}else{
   						alert(data.msg);
   					}
   				},
   				error: function(data){
   					alert("网络异常");
   				}
   			});
   		});
   		
   		$(".report-btn").on("click",function(e){
   			var uid = $("#userId").val();
   			console.log(uid)
   			if(uid===undefined||uid===null||uid===""){
   				$(".my-modal").fadeIn();
   			}else{
   				$(".modal-bg").fadeIn();
   				$(".report-warp").fadeIn();
   				comid = $(this).attr("comid");
   			}
   		});
   		
   		$("#close-report").on("click",function(e){
   				$(".modal-bg").fadeOut();
				$(".report-warp").fadeOut();
   		});
   		
   		$("#report-form").on("submit",function(e){
   			e.preventDefault();
   			if(comid===undefined||comid===""||comid===null){
   				alert("请选择一个要举报的评论");
   				return;
   			}
   			var content = $("input[name='report-type']:checked").val();
   			if(content===undefined||content===""||content===null){
   				alert("请选择一个理由");
   				return;
   			}else{
   				var uid = $("#userId").val();
   				var addition = $("#addition").val();
   				$.ajax({
   	   				type: "post",
   	   				url: "submit_report",
   	   				dataType: "json",
   	   				data: {
   	   					uid: uid,
   	   					comid: comid,
   	   					content: content,
   	   					addition: addition
   	   				},
   	   				success:function(data){
	   	   				$(".modal-bg").fadeOut();
	   	   				$(".report-warp").fadeOut();
   	   					$("input[name='report-type']").prop({checked:false});
   	   					$("#addition").val("");
   	   				},
   	   				error:function(data){
   	   					alert("网络出错，稍后重试");
   	   				}
   	   			});
   			}
   			
   		});
   	});
    </script>
  </body>
</html>
