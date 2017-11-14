<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>更新新闻</title>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body>
  <div class="layui-container">
  <div class="layui-row">
      <form class="layui-form" action="" method="post">
        <div class="layui-form-item">
          <label class="layui-form-label">新闻标题</label>
          <div class="layui-input-block">
            <input id="title" type="text" name="title" value="${update.title}" required  lay-verify="required" maxlength="15" placeholder="请输入标题" autocomplete="off" class="layui-input">
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">新闻类型</label>
          <div class="layui-input-block">
            <select name="catagery" lay-verify="required">
              <option value=""></option>
              <option value="0">政治</option>
              <option value="1">军事</option>
              <option value="2">金融</option>
              <option value="3">社会</option>
              <option value="4">科技</option>
            </select>
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">来源</label>
          <div class="layui-input-block">
            <input id="newsfrom" type="text" name="newsfrom" value="${update.newsfrom}" required  lay-verify="required" maxlength="15" placeholder="作者" autocomplete="off" class="layui-input">
          </div>
        </div>
        <div class="layui-form-item">
        	<label class="layui-form-label">正文</label>
        	<div class="layui-input-block">
        		<textarea id="demo" style="display: none;"></textarea>
        	</div>
        </div>
        <div class="layui-form-item">
          <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" id="submit">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
          </div>
        </div>
      </form>
    </div>
	</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
<script type="text/javascript">
(function(){
	var content = $("#demo").val(unescape("${update.content}"));
})();
layui.use(["form","layedit"], function(){
	  var form = layui.form,
	  layedit = layui.layedit;
	  var edit = layedit.build('demo'); //建立编辑器
		
	  var sub = document.getElementById("submit");
	  sub.addEventListener("click",function(e){
		  e.preventDefault();
		  
		 var title = document.getElementById("title").value,
		 	newsfrom = document.getElementById("newsfrom").value,
		  	content = escape(layedit.getContent(edit));//获取正文内容转码

		  	if(title==""||newsfrom==""||content=="")
		  		return;
		 
		 $.ajax({
				type:"post",
				url:"updateNews",
				dataType:"html",
				data:{
					newsid: "${update.id}",
					title: title,
					content: content,
					newsfrom: newsfrom,
					createTime: "${update.createTime}"
				},
				success:function(data){
					layer.msg("ID："+ data.id + "更新成功");
					location.href = location.origin+"/NewsCMS/NewsPage/listNews.jsp";
				},
				error:function(){
					layer.msg("网络出错");
				}
			});
	  });
	});
</script>
  </body>
</html>
