<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>新闻资料</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  <style>
  	.data-show{
  		line-height: 38px;
  	}
  	.b{font-weight:bold;}
  	.red{color:red;}
  	.green{color:#03CA04;}
  </style>
  <body style="padding:30px">
     <div class="top" style="display: fixed;top: 0;left: 0;">
  	<button class="layui-btn" onclick="history.go(-1)"><i class="fa fa-angle-double-left" aria-hidden="true"></i>  返回</button>
  </div>
  	<div class="layui-fluid">
 		 <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  	 	<legend>该新闻有<s:property value='commentSize'/>条评论</legend>
	</fieldset>
	<div class="layui-fiulid">
		<table class="comment-table layui-table" lay-even>
		<thead>
			<th>评论ID</th>
			<th>评论人</th>
			<th>时间</th>
			<th>内容</th>
			<th>是否显示</th>
		</thead>
		<s:iterator value="commentList" var="comment" status="st">
			<tr>
				<td><s:property value='#comment.id'/></td>
				<td><s:property value='#comment.user.username'/></td>
				<td><s:property value='#comment.createTimeS'/></td>
				<td><s:property value='#comment.content'/></td>
				<td>
					<s:if test="#comment.showed">
						<span class="green b"><s:property value='#comment.showed'/></span>
					</s:if><s:else>
						<span class="red b"><s:property value='#comment.showed'/></span>
					</s:else>				
				</td>
			</tr>
		</s:iterator>
		</table>
	</div>
    </div>    
	<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script> 
	<script>
	layui.use('table', function(){
	  var table = layui.table;
	});
	</script>
  </body>
</html>
