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
  html{overflow-y:scroll;}
  	body{
  		padding: 10px;
  	}
  	.layui-btn{
  		border: 1px solid #009688;
  		box-sizing: border-box;
  	}
  	.layui-btn.layui-btn-disabled{
  		border: 1px solid #e6e6e6;
  	}
  	.layui-btn-danger{
  		border: 1px solid #FF5722;
  		box-sizing: border-box;
  	}

	.layui-btn-danger.layui-btn-disabled{
		background: #FBFBFB;
		border: 1px solid #e6e6e6
	}
	.layui-btn-normal{
		border: 1px solid #1E9FFF;
	}
	.layui-btn-normal.layui-btn-disabled{
		background: #FBFBFB;
		border: 1px solid #e6e6e6;
	}
	.ad-wrap{

	}
	.save-btn{
		display: none;
	}
	.ad-content{
		position:relative;
		padding: 10 10px;
		
	}
	.lock-bg{
		position: absolute;
		top: 0;
		bottom: 0;
		left: 0;
		right: 0;
		width: 100%;
		height: 100%;
		padding-bottom: 15px;
		background: rgba(167,167,167,.2);
		z-index: 999;
	}
	.lock-button{
		padding: 10px 10px;
    	border-bottom: 1px solid #e6e6e6;
	}
	.active-edit{
		border-color: #009688;
	}
	.layui-field{
		/*transition: all 1s;*/
	}
	.layui-form-item{
		padding: 5px 2px;
	}
	.side-pre{
		width: 200px;
		height: 200px;
	}
	.top-bot-pre{
		width: 100%;
		height: 70px;
	}
	.tips{
		color: #a5a5a5;
	}
  </style>
  <body>
  	<div class="ad-wrap">
		<fieldset class="layui-elem-field top-field">
	 		<legend>顶部广告位置</legend>
	  		<div class="lock-button">
	  			<button class="layui-btn" id="edit-btn"><i class="layui-icon">&#xe642;</i>编辑</button>
	  			<button class="layui-btn layui-btn-disabled layui-btn-danger" id="cancel-edit"><i class="layui-icon">&#x1006;</i>取消编辑</button>
	  			<button class="layui-btn layui-btn-normal layui-btn-disabled" id="save-top"><i class="layui-icon">&#xe605;</i>保存</button>
	  		</div>
	  		<div class="ad-content" id="ad-top">
				<div class="lock-bg"></div>
	  			<form class="layui-form" action="">
				  <div class="layui-form-item">
				    <label class="layui-form-label">广告描述</label>
				    <div class="layui-input-block">
				      <input type="text" name="ad-about"  lay-verify="required" placeholder="广告标题或者相关描述,长度10-20" class="layui-input layui-disabled input-switch">
				    </div>
				  </div>
				  <div class="layui-form-item">
				    <label class="layui-form-label">广告超链接</label>
				    <div class="layui-input-block">
				      <input type="text" name="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input layui-disabled input-switch">
				    </div>
				  </div>
		          <!-- 上传广告图 -->
		        <div class="layui-form-item">
		          <label class="layui-form-label">顶部广告图</label>
		          <div class="layui-input-block">
		            <div class="layui-upload">
					  <button type="button" class="layui-btn  layui-btn-normal layui-btn-disabled upload-btn" id="upload-top-img"/><i class="layui-icon">&#xe681;</i>上传广告图</button>
					  <span class="tips">(推荐图片分辨率为:1000x70)</span>
					  <div class="layui-upload-list">
					    <img class="layui-upload-img top-bot-pre" id="top-img-pre">
					    <p id="demoText"></p>
					  </div>
					</div> 
		          </div>
		        </div>
				 </form>
  			</fieldset>
  		</div>
  	</div>
  	<div class="ad-wrap">
		<fieldset class="layui-elem-field bot-field">
    		<legend>底部广告位置</legend>
    	<div class="lock-button">
	  			<button class="layui-btn" id="edit-btn"><i class="layui-icon">&#xe642;</i>编辑</button>
	  			<button class="layui-btn layui-btn-danger layui-btn-disabled" id="cancel-edit"><i class="layui-icon">&#x1006;</i>取消编辑</button>
	  			<button class="layui-btn layui-btn-normal layui-btn-disabled" id="save-bot"><i class="layui-icon">&#xe605;</i>保存</button>
	  		</div>
  		<div class="ad-content" id="ad-bot">
  			<div class="lock-bg"></div>
			<div class="site-text site-block">
				<form class="layui-form" action="">
			 <div class="layui-form-item">
			   <label class="layui-form-label">广告描述</label>
			   <div class="layui-input-block">
			     <input type="text" name="ad-about" autocomplete="off" placeholder="广告标题或者相关描述,长度10-20" class="layui-disabled layui-input input-switch">
			   </div>
			 </div>
			 <div class="layui-form-item">
			   <label class="layui-form-label">广告超链接</label>
			   <div class="layui-input-block">
			     <input type="text" name="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-disabled layui-input input-switch">
			   </div>
			 </div>
			       <!-- 上传广告图 -->
			     <div class="layui-form-item">
			       <label class="layui-form-label">底部广告图</label>
			       <div class="layui-input-block">
			         <div class="layui-upload">
			  <button type="button" class="layui-btn layui-btn-normal layui-btn-disabled  upload-btn" id="upload-bot-img"/><i class="layui-icon">&#xe681;</i>上传广告图</button>
			  <span class="tips">(推荐图片分辨率为:1000x70)</span>
			  <div class="layui-upload-list">
			    <img class="layui-upload-img top-bot-pre" id="bot-img-pre">
			    <p id="demoText"></p>
			  </div>
			</div> 
			       </div>
			     </div>
			</form>
			</div>
  		</div>
  		</fieldset>
  	</div>
  	<div class="ad-wrap">
  		<fieldset class="layui-elem-field side-field">
    		<legend>侧栏广告位置</legend>
    	<div class="lock-button">
	  		<button class="layui-btn" id="edit-btn"><i class="layui-icon">&#xe642;</i>编辑</button>
	  		<button class="layui-btn layui-btn-danger layui-btn-disabled" id="cancel-edit"><i class="layui-icon">&#x1006;</i>取消编辑</button>
	  		<button class="layui-btn layui-btn-normal layui-btn-disabled" id="save-side"><i class="layui-icon">&#xe605;</i>保存</button>
	  	</div>
  		<div class="ad-content" id="ad-bot">
  			<div class="lock-bg"></div>
			<div class="site-text site-block">
				<form class="layui-form" action="">
			 <div class="layui-form-item">
			   <label class="layui-form-label">广告描述</label>
			   <div class="layui-input-block">
			     <input type="text" name="ad-about" autocomplete="off" placeholder="广告标题或者相关描述,长度10-20" class="layui-disabled layui-input input-switch">
			   </div>
			 </div>
			 <div class="layui-form-item">
			   <label class="layui-form-label">广告超链接</label>
			   <div class="layui-input-block">
			     <input type="text" name="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-disabled layui-input input-switch">
			   </div>
			 </div>
			       <!-- 上传广告图 -->
			     <div class="layui-form-item">
			       <label class="layui-form-label">底部广告图</label>
			       <div class="layui-input-block">
			         <div class="layui-upload">
			  <button type="button" class="layui-btn layui-btn-normal layui-btn-disabled upload-btn" id="upload-side-img"/><i class="layui-icon">&#xe681;</i>上传广告图</button
			  <span class="tips">(推荐图片分辨率为:200x200,400x400)</span>
			  <div class="layui-upload-list">
			    <img class="layui-upload-img side-pre" id="side-img-pre">
			    <p id="demoText"></p>
			  </div>
			</div> 
			       </div>
			     </div>
			</form>
			</div>
  		</div>
  		</fieldset>
  	</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
<script src="<%=request.getContextPath() %>/Njs/btnEvent.js"></script>
<script>
layui.use(["form","upload"], function(){
	  var form = layui.form,
	  $ = layui.jquery,
	  upload = layui.upload;
	  
	  //监听指定开关
	  form.on('switch(switchTest)', function(data){
	    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
	      offset: '6px'
	    });
	    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
	  });
	  
	//广告图片上传
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
	//底部广告图片上传
	  var upload_bot = upload.render({
	    elem: '#upload-bot-img'
	    ,url: 'upload/uploadNewsImg'
	    ,before: function(obj){
	      //预读本地文件示例，不支持ie8
	      obj.preview(function(index, file, result){
	        $('#bot-img-pre').attr('src', result); //图片链接(base64)
	      });
	    }
	    ,done: function(res){
	      //如果上传失败
	      $('#bot-img-pre').attr('src', res.data.src);
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
	//侧栏广告图片上传
	  var upload_side = upload.render({
	    elem: '#upload-side-img'
	    ,url: 'upload/uploadNewsImg'
	    ,before: function(obj){
	      //预读本地文件示例，不支持ie8
	      obj.preview(function(index, file, result){
	        $('#bot-img-pre').attr('src', result); //图片链接(base64)
	      });
	    }
	    ,done: function(res){
	      //如果上传失败
	      $('#bot-img-pre').attr('src', res.data.src);
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
