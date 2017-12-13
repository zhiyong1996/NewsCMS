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
  
  <body style="padding:30px;">
  <div class="layui-container">
  
  <div class="layui-row">
      <form class="layui-form" action="" method="post">
        <div class="layui-form-item">
          <input type="hidden" value="${update.createId}" id="createId" name="createId"/>
          <label class="layui-form-label">新闻标题</label>
          <div class="layui-input-block">
            <input id="title" type="text" name="title" value="${update.title}" required  lay-verify="required" maxlength="15" placeholder="请输入标题" autocomplete="off" class="layui-input">
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">新闻类型</label>
          <div class="layui-input-block">
            <s:select name="catagery" lay-filter="test" list="category" listKey="key" listValue="value" headerKey="-1" headerValue="请选择分类" emptyOption="true" value="%{#update.category.id}"></s:select>
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
	<!-- <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
	  		<legend>选择新闻图片</legend>
		</fieldset>
	
		<div class="layui-upload">
		  <button type="button" class="layui-btn" id="newsImg"><i class="layui-icon"></i>上传图片</button>
		  <div class="layui-upload-list">
		    <img class="layui-upload-img" id="preview">
		    <p id="demoText"></p>
		  </div>
		</div> -->
	</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
<script type="text/javascript">
console.log("category:"+"${update.category.id}"+"${update.category.name}");
(function(){
	var content = $("#demo").val(unescape("${update.content}"));
})();
layui.use(["form","layedit","upload"], function(){
	  var form = layui.form,
	  layedit = layui.layedit;
	  //upload = layui.upload;
	  //设置图片上传接口
	  layedit.set({
		  uploadImage: {
		    url: 'upload/uploadNewsImg' //接口url
		    ,type: 'post' //默认post
		  }
		});
	  
	  var edit = layedit.build('demo'); //建立编辑器
	  var cid = -1;
	  form.on("select(test)", function(data){
		  cid = data.value;
		}); 
		
	  var sub = document.getElementById("submit");
	  sub.addEventListener("click",function(e){
		  e.preventDefault();
		  
		  var newsid = "${update.id}"
		  	,title = $("#title").val()
		 	,newsfrom = $("#newsfrom").val()
		  	,content = escape(layedit.getContent(edit));//获取正文内容转码
			console.log(parseInt(cid))
		  	if(title==""||newsfrom==""||content==""||parseInt(cid)<1){
		  		layer.msg("请选择新闻分类");
		  		return;
	  	}
		 
		 $.ajax({
				type:"post",
				url:"news/updateNews",
				dataType:"html",
				data:{
					newsid: newsid,
					title: title,
					cid: cid,
					content: content,
					newsfrom: newsfrom,
				},
				success:function(data){
					layer.msg("ID："+ newsid + "更新成功,3秒后自动跳转");
					setTimeout(function(){
						location.href = location.origin+"/NewsCMS/news/go_listN"
						},3000);
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
