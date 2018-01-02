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
    
    <title>添加新闻</title>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body style="padding:30px;">
  <div class="layui-container">
  <div class="layui-row">
      <form class="layui-form" action="" method="post">
      	<input type="hidden" value="2017/12/2/10:37" id="newsHide" name="newsHide"/>
        <div class="layui-form-item">
          <label class="layui-form-label">新闻标题</label>
          <div class="layui-input-block">
            <input id="title" type="text" name="title" required  lay-verify="required" maxlength="30" placeholder="请输入标题" autocomplete="off" class="layui-input">
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">新闻类型</label>
          <div class="layui-input-block">
            <s:select name="catagery" id="catagery" lay-filter="test" list="category" listKey="key" listValue="value" headerKey="-1" headerValue="请选择分类" emptyOption="true"></s:select>
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">来源</label>
          <div class="layui-input-block">
            <input id="newsfrom" type="text" name="newsfrom" required  lay-verify="required" maxlength="15" placeholder="新闻来源" autocomplete="off" class="layui-input">
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
layui.use(["form","layedit","upload"], function(){
	  var form = layui.form,
	  layedit = layui.layedit;
	  //upload = layui.upload;
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
		  
		 var title = $("#title").val(),
		 	newsfrom = $("#newsfrom").val(),
		  	content = escape(layedit.getContent(edit));//获取正文内容转码
			console.log(cid);
		  	if(parseInt(cid)<1||title==""||newsform==""){
		  		layer.msg("请选择新闻分类");
		  		return;
		  	}
		  		
		 
		 $.ajax({
				type:"post",
				url:"news/addNews",
				dataType:"html",
				data:{
					title: title,
					cid: cid,
					newsfrom: newsfrom,
					content: content
				},
				success:function(data){
					layer.msg("添加成功,3秒后自动跳转新闻列表");
					setTimeout(function(){
						location.href = location.origin+"/NewsCMS/news/go_listN"
						},3000);
				},
				error:function(){
					layer.msg("网络出错");
				}
			});//ajax
	  });//eventListener
	});
</script>
  </body>
</html>
