<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>   
    <title>广告管理</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  <style>
  	body{
  		padding: 10px;
  	}
  	.site-block {
    padding: 20px;
    border: 1px solid #eee;
}
.site-text {
    position: relative;
}
  </style>
  <body>
  	<div class="ad-wrap">
  		<div class="title">
  			<fieldset class="layui-elem-field layui-field-title">
    			<legend>顶部广告位置</legend>
    		</fieldset>
  		</div>
  		<div class="ad-content" id="ad-top">
  			<div class="site-text site-block">
  			<form class="layui-form layui-form-pane" action="">
			  <div class="layui-form-item">
			    <label class="layui-form-label">广告描述</label>
			    <div class="layui-input-block">
			      <input type="text" name="top-ad-about" autocomplete="off" placeholder="广告标题或者相关描述,长度10-20" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">广告超链接</label>
			    <div class="layui-input-block">
			      <input type="text" name="top-ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item" pane="">
		          <label class="layui-form-label">状态</label>
		          <div class="layui-input-block">
		            <input type="checkbox" name="switch" lay-skin="switch" lay-text="ON|OFF" lay-filter="switchTest"><div class="layui-unselect layui-form-switch" lay-skin="_switch"><em></em><i></i></div>
		          </div>
	          </div>
	          <!-- 上传广告图 -->
	        <div class="layui-form-item">
	          <label class="layui-form-label">顶部广告图</label>
	          <div class="layui-input-block">
	            <div class="layui-upload">
				  <button type="button" class="layui-btn" id="upload-top-img">上传广告图</button>
				  <span>(图片分辨率为:1000x70)</span>
				  <div class="layui-upload-list">
				    <img class="layui-upload-img" id="top-img-pre" style="width: 1000px; height: 70px;">
				    <p id="demoText"></p>
				  </div>
				</div> 
	          </div>
	        </div>
	        <div class="layui-form-item">
			    <button class="layui-btn" lay-submit="" lay-filter="demo2">保存顶部广告</button>
			</div>
			 </form>
  			</div>
  		</div>
  	</div>
  	<div class="ad-wrap">
  		<div class="title">
  			<fieldset class="layui-elem-field layui-field-title">
	    		<legend>底部广告位置</legend>
	    	</fieldset>
  		</div>
  		<div class="ad-content" id="ad-bot">
  		<div class="site-text site-block">
  			<form class="layui-form layui-form-pane" action="">
			  <div class="layui-form-item">
			    <label class="layui-form-label">广告描述</label>
			    <div class="layui-input-block">
			      <input type="text" name="bot-ad-about" autocomplete="off" placeholder="广告标题或者相关描述,长度10-20" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">广告超链接</label>
			    <div class="layui-input-block">
			      <input type="text" name="bot-ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item" pane="">
		          <label class="layui-form-label">状态</label>
		          <div class="layui-input-block">
		            <input type="checkbox" name="switch" lay-skin="switch" lay-text="ON|OFF" lay-filter="switchTest"><div class="layui-unselect layui-form-switch" lay-skin="_switch"><em></em><i></i></div>
		          </div>
	          </div>
	          <!-- 上传广告图 -->
	        <div class="layui-form-item">
	          <label class="layui-form-label">底部广告图</label>
	          <div class="layui-input-block">
	            <div class="layui-upload">
				  <button type="button" class="layui-btn" id="upload-bot-img">上传广告图</button>
				  <span>(图片分辨率为:1000x70)</span>
				  <div class="layui-upload-list">
				    <img class="layui-upload-img" id="bot-img-pre" style="width: 1000px; height: 70px;">
				    <p id="demoText"></p>
				  </div>
				</div> 
	          </div>
	        </div>
	        <div class="layui-form-item">
			    <button class="layui-btn" lay-submit="" lay-filter="demo2">保存底部广告</button>
			  </div>
			 </form>
			 </div>
  		</div>
  	</div>
  	<div class="ad-wrap">
  		<div class="title">
  			<fieldset class="layui-elem-field layui-field-title">
	    		<legend>详情页侧栏广告位置</legend>
	    	</fieldset>
  		</div>
  		<div class="ad-content" id="ad-side"></div>
  	</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
<script>
layui.use(["form","upload"], function(){
	  var form = layui.form,
	  upload = layui.upload;
	  
	  //监听指定开关
	  form.on('switch(switchTest)', function(data){
	    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
	      offset: '6px'
	    });
	    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
	  });
	  
	//轮播图片上传
	  var upload_top = upload.render({
	    elem: '#upload-top-img'
	    ,url: 'upload/uploadNewsImg'
	    ,before: function(obj){
	      //预读本地文件示例，不支持ie8
	      obj.preview(function(index, file, result){
	        $('#top-img-pre').attr('src', result); //图片链接(base64)
	      });
	    }
	    ,done: function(res){
	      //如果上传失败
	      $('#top-img-pre').attr('src', res.data.src);
	      //上传成功
	    }
	    ,error: function(){
	      //演示失败状态，并实现重传
	      var demoText = $('#demoText');
	      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
	      demoText.find('.demo-reload').on('click', function(){
	        uploadInst.upload();
	      });
	    }
	  });
});
</script>
  </body>
</html>
