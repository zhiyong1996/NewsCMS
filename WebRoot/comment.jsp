<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
    <title>评论</title>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/index.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/mymodal.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/detail-txt.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/reset.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/comment.css"/>
    <script src="js/jquery-3.2.1.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </head>
  <body>
  	<div class="modal-bg"></div>
  	<!-- 举报功能 -->
  	<div class="report-warp">
  		<div class="report-header clearfix">
  			<div class="report-title report-header-item">评论举报</div>
  			<div class="report-header-close" id="close-report"><span class="glyphicon glyphicon-remove modal-close"></span></div>
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
                	<li class="nav-ava"><a href="user_info_page?username=${session.username}">
                		<s:if test="avatar_path==''">
								<img id="nav-avatar" src="Nimg/user.jpg">
							</s:if><s:else>
								<img id="nav-avatar" src="<s:property value='#session.user.Avatar.path'/>">
							</s:else>
                	</a></li>
                	<li><a href="user_info_page?username=${session.username}" id="user_name" >${session.username}</a></li>
                	<input type="hidden" id="userid" value="<s:property value='#session.user.id'/>" />
                	<li><a href="javacript:;" id="quit" >退出</a></li>
                </s:else>
            </ul>
        </div>
    </nav>
    
    <!--头部广告位-->
    <div class="container advertise" id="ad-top">
    	<div class="ad-img">
    		<a href="javascript:;" class="ad-url"><img class="ad-img"/></a>
    	</div>
        <div class="ad-logo">
        	<small>广告</small>
        </div>
    </div>
    <!--头部广告位 end-->
    
    <!-- 面包屑导航 -->
    <div class="container">
		<ol class="breadcrumb">
			<li><a href="index">首页</a></li>
			<li><a href="show_detail?createId=${news.createId}">新闻阅览</a></li>
			<li class="active">评论查看</li>
		</ol>
	</div>
	<!-- end -->
	<!-- 内容 -->
	<div class="container">
		<div class="col-md-8 news-title"><h3>${news.title}<small class="small">[<a href="show_detail?createId=${news.createId}">查看原文</a>]</small></h3></div>
	</div>
	<div class="container main-content">
		<div class="row">
			<div class="col-md-8 comments-wrap">
				<div class="all-comments">
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
					        	</s:if><s:elseif test="!#session.user.id==#n.user.id">
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
				</div>
				<div class="comment-header">
		    		<h1 class="header-title left">网友评论</h1>
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
		    				<li class="user-avatar">
		    					<s:if test="avatar_path==''">
								<img id="nav-avatar" src="Nimg/user.jpg">
								</s:if><s:else>
									<img id="nav-avatar" src="<s:property value='#session.user.Avatar.path'/>">
								</s:else>
							</li>
		    				<li class="user-name"><span>${session.username}</span></li>
		    				<input type="hidden" id="userId" value="${session.user.id}"/>
		    			</ul>
	    			</s:else>
		    	</div>
			</div>	
			<div class="col-md-4">
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
        
    <!--脚部广告位-->
    <div class="container advertise" id="ad-bot">
    	<div class="ad-img">
    		<a href="javascript:;" class="ad-url"><img class="ad-img"/></a>
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
   			var uid = $("#userid").val();
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
   				var uid = $("#userid").val();
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
   	   					alert(data.msg);
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
