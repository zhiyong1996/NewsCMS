<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户详细资料</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  <style>
  	.data-show{
  		line-height: 48px;
  		padding-left: 15px;
  		display: inline-block;
  	}
  	.green{
  		color: #13ad13;
  	}
  	.red{
  		color: #FF5722;
  	}
  	.layui-form-item:first-of-type{
  		border-top: 1px solid #ccc;
  		border-radius: 3px 3px 0 0;
  	}
  	.layui-form-item{
  		border-bottom: 1px solid #ccc;
  		border-left: 1px solid #ccc;
  		border-right: 1px solid #ccc;
  		margin-bottom: 0;
  	}
  	.layui-form-item:last-of-type{
  		border-radius: 0 0 3px 3px;
  		padding: 10px 0;
  	}
  	.layui-form-label{
  		background: #f5f5f5;
  		line-height: 30px;
    	height: 30px;
    	font-weight: bold;
    	border-right: 1px solid #ccc;
  	}
  	.layui-form-item .layui-inline{margin-bottom:0;}
  	.layui-form-label{text-align: center;}
  </style>
  <body style="padding:30px">
      <div class="top" style="display: fixed;top: 0;left: 0;">
	  	<button class="layui-btn" onclick="history.go(-1)"><i class="fa fa-angle-double-left" aria-hidden="true"></i>  返回</button>
	  </div>
	  <div class="layui-fluid">
  		 <fieldset class="layui-elem-field layui-field-title" style="margin-top: 15px;">
	  	 	<legend>信息详情</legend>	
	  	 </fieldset>	
			<form class="layui-form" id="form">	
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">消息ID</label>
						<div class="layui-input-inline">
							<span class="data-show"><s:property value="rmsg.id"/></span>
							<input type="hidden" id="msgid" value="<s:property value="rmsg.id"/>" name="mid"/>
						</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label">举报原因:</label>
						<div class="layui-input-inline">
							<span class="data-show"><s:property value="rmsg.content"/></span>
						</div>
					</div>
				</div>
				<!-- item1 -->
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">时间:</label>
						<div class="layui-input-inline">
							<span class="data-show"><s:property value="rmsg.createTimeS"/></span>
						</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label">状态:</label>
						<div class="layui-input-inline">
							<s:if test="rmsg.handled==true">
								<span class="data-show green">已处理</span>
							</s:if><s:else>
								<span class="data-show red">未处理</span>
							</s:else>
						</div>
					</div>
				</div>
				<!-- item2 -->
				<div class="layui-form-item">
					<label class="layui-form-label">附加信息:</label>
					<div class="layui-input-block">
						<span class="data-show"><s:property value="rmsg.addition"/></span>
					</div>
				</div>
				<!-- item3 -->
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">评论ID</label>
						<div class="layui-input-inline">
							<span class="data-show"><s:property value="comment.id"/></span>
						</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label">评论者</label>
						<div class="layui-input-inline">
							<span class="data-show"><s:property value="com_ower.username"/></span>
						</div>
					</div>
				</div>
				<!-- item4 -->
				<div class="layui-form-item">
					<label class="layui-form-label">评论内容</label>
					<div class="layui-input-block">
						<span class="data-show"><s:property value="comment.content"/></span>
					</div>
				</div>
				<!-- item5 -->
				<div class="layui-form-item">
					<label class="layui-form-label">评论处理:</label>
					<div class="layui-input-block">	
						<span class="data-show">
							<s:if test="rmsg.handled==true">
								<s:property value="rmsg.handle_result"/>
							</s:if><s:else>
								<input type="radio" name="handle" value="隐藏" title="隐藏">
								<!--  <input type="radio" name="sex" value="删除" title="删除">-->
							</s:else>
						</span>
					</div>
				</div>
				<!-- item6 -->
				<div class="layui-form-item">
				    <div class="layui-input-block">
				    <s:if test="rmsg.handled==false">
						<button class="layui-btn" type="submit" lay-submit="" lay-filter="demo1" id="submit">提交处理</button>
					</s:if>
				    </div>
				</div>
				<!-- item7 -->
			</form>
			<!-- form end -->
		
		</div>
	  </div>
  <script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
  <script type="text/javascript">
  		layui.use(["form"],function(e){
  			var form = layui.form;
  			
  		  //监听提交
  		  $("#form").on('submit', function(e){
  			  e.preventDefault();
  		    var handleResult = $("input[name='handle']:checked").val();
  		    if(handleResult===undefined||handleResult===""||handleResult===null){
  		    	layer.msg("请选择处理结果");
  		    	return ;
  		    }
  		  	$.ajax({
	        	type: "post",
	        	url: "report/handle_result",
	        	dataType: "html",
	        	data: {
	        		msgid: $("#msgid").val(),
	        		handleResult: handleResult
	        	},
	        	success: function(data){     		
	        		console.log(data);
	        		layer.msg(data.msg);
	        		setTimeout(function(e){
	        			history.go(0);
	        		},2000);
	        	},
	        	error: function(){
	        		layer.msg("网络异常");
	        	}
	        });//ajax end
  		  });
  		});
  </script>
  </body>
</html>
