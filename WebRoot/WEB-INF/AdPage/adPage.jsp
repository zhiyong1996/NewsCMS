<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
  <head>   
    <title>广告管理</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/Ncss/adPage.css"/>
  </head>
  <body>
  	<div class="ad-wrap">
		<fieldset class="layui-elem-field top-field">
	 		<legend>顶部广告位置</legend>
	  		<div class="lock-button">
	  			<button class="layui-btn" id="edit-btn"><i class="layui-icon">&#xe642;</i>编辑</button>
	  			<button class="layui-btn layui-btn-disabled layui-btn-danger" id="cancel-edit"><i class="layui-icon">&#x1006;</i>取消编辑</button>
	  			<button class="layui-btn layui-btn-normal layui-btn-disabled save-btn" id="save-top"><i class="layui-icon">&#xe605;</i>保存</button>
	  		</div>
	  		<div class="ad-content" id="ad-top">
				<div class="lock-bg"></div>
	  			<form class="layui-form" action="">
				  <div class="layui-form-item">
				    <label class="layui-form-label">广告描述</label>
				    <div class="layui-input-block">
					    <s:if test="t_ad==null">
					      <input type="text" name="ad-about"  lay-verify="required" placeholder="广告标题或者相关描述,长度10-20" class="layui-input layui-disabled input-switch">
					    </s:if>
					    <s:else>
					      <input type="text" name="ad-about"  lay-verify="required" placeholder="广告标题或者相关描述,长度10-20" class="layui-input layui-disabled input-switch" value="${t_ad.about}">
					    </s:else>
				    </div>
				  </div>
				  <div class="layui-form-item">
				    <label class="layui-form-label">广告超链接</label>
				    <div class="layui-input-block">
				    <s:if test="t_ad==null">
				      <input type="text" name="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input layui-disabled input-switch">
				    </s:if>
				    <s:else>
				      <input type="text" name="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input layui-disabled input-switch"  value="${t_ad.url}">
				    </s:else>
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
					  	<s:if test="t_ad==null">
					  		<img class="layui-upload-img top-bot-pre" id="top-img-pre">
					  	</s:if>
					  	<s:else>
					  		<img class="layui-upload-img top-bot-pre" id="top-img-pre" src="${t_ad.adimg.path}">
					  	</s:else>
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
	  			<button class="layui-btn layui-btn-normal layui-btn-disabled save-btn" id="save-bot"><i class="layui-icon">&#xe605;</i>保存</button>
	  		</div>
  		<div class="ad-content" id="ad-bot">
  			<div class="lock-bg"></div>
			<div class="site-text site-block">
				<form class="layui-form" action="">
			 <div class="layui-form-item">
			 	<label class="layui-form-label">广告描述</label>
			 	<div class="layui-input-block">
				   <s:if test="b_ad==null">
				      <input type="text" name="ad-about"  lay-verify="required" placeholder="广告标题或者相关描述,长度10-20" class="layui-input layui-disabled input-switch">
				    </s:if>
				    <s:else>
				      <input type="text" name="ad-about"  lay-verify="required" placeholder="广告标题或者相关描述,长度10-20" class="layui-input layui-disabled input-switch" value="${t_ad.about}">
				    </s:else>
			 	</div>
			 </div>
			 <div class="layui-form-item">
			 	<label class="layui-form-label">广告超链接</label>
			 	<div class="layui-input-block">
			   		<s:if test="b_ad==null">
				      <input type="text" name="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input layui-disabled input-switch">
				    </s:if>
				    <s:else>
				      <input type="text" name="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input layui-disabled input-switch"  value="${b_ad.url}">
				    </s:else>
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
			    <s:if test="b_ad==null">
			  		<img class="layui-upload-img top-bot-pre" id="bot-img-pre">
			  	</s:if>
			  	<s:else>
			  		
			  		<img class="layui-upload-img top-bot-pre" id="bot-img-pre" src="${b_ad.adimg.path}">
			  	</s:else>
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
	  		<button class="layui-btn layui-btn-normal layui-btn-disabled save-btn" id="save-side"><i class="layui-icon">&#xe605;</i>保存</button>
	  	</div>
  		<div class="ad-content" id="ad-bot">
  			<div class="lock-bg"></div>
			<div class="site-text site-block">
				<form class="layui-form" action="">
			 <div class="layui-form-item">
			   <label class="layui-form-label">广告描述</label>
			   <div class="layui-input-block">
			     <s:if test="s_ad==null">
				      <input type="text" name="ad-about"  lay-verify="required" placeholder="广告标题或者相关描述,长度10-20" class="layui-input layui-disabled input-switch">
				    </s:if>
				    <s:else>
				      <input type="text" name="ad-about"  lay-verify="required" placeholder="广告标题或者相关描述,长度10-20" class="layui-input layui-disabled input-switch" value="${s_ad.about}">
				    </s:else>
			   </div>
			 </div>
			 <div class="layui-form-item">
			 	<label class="layui-form-label">广告超链接</label>
			   	<div class="layui-input-block">
					<s:if test="s_ad==null">
				      <input type="text" name="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input layui-disabled input-switch">
				    </s:if>
				    <s:else>
				      <input type="text" name="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input layui-disabled input-switch"  value="${s_ad.url}">
				    </s:else>
			 	</div>
			 </div>
			       <!-- 上传广告图 -->
			     <div class="layui-form-item">
			       <label class="layui-form-label">侧栏广告图</label>
			       <div class="layui-input-block">
			         <div class="layui-upload">
			  <button type="button" class="layui-btn layui-btn-normal layui-btn-disabled upload-btn" id="upload-side-img"/><i class="layui-icon">&#xe681;</i>上传广告图</button>
			  <span class="tips">(推荐图片分辨率为:200x200,400x400)</span>
			  <div class="layui-upload-list">
			    <s:if test="s_ad==null">
			  		<img class="layui-upload-img side-pre" id="side-img-pre">
			  	</s:if>
			  	<s:else>
			  		<img class="layui-upload-img side-pre" id="side-img-pre" src="${s_ad.adimg.path}">
			  	</s:else>
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
<script src="<%=request.getContextPath() %>/Njs/admanager_btn.js"></script>
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
	    	  upload_top.upload();
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
	    	  upload_bot.upload();
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
	        $('#side-img-pre').attr('src', result); //图片链接(base64)
	      });
	    }
	    ,done: function(res){
	      //如果上传失败
	      $('#side-img-pre').attr('src', res.data.src);
	      //上传成功
	    }
	    ,error: function(){
	      //演示失败状态，并实现重传
	      var demoText = $('#demoText');
	      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
	      demoText.find('.demo-reload').on('click', function(){
	    	  upload_side.upload();
	      });
	    }
	  });
});
</script>
  </body>
</html>
