<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>updateAd.jsp</title>
<meta http-equiv="pragma" content="no-cache">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/Ncss/adPage.css"/>
</head>

<body style="padding: 20px;">
	<div class="ad-content" id="ad-bot">
		<form class="layui-form" id="bot-form">
			<s:if test="b_ad==null">
				<input type="hidden" value="0" id="ad-id"/>
			</s:if><s:else>
				<input type="hidden" value="${b_ad.id}" id="ad-id"/>
			</s:else>
			<div class="layui-form-item">
				<label class="layui-form-label">广告单位</label>
				<div class="layui-input-block">
					<s:if test="b_ad==null">
						<input type="text" name="ad-company" id="ad-company" lay-verify="required" placeholder="广告单位或者个人" class="layui-input input-switch">
					</s:if>
					<s:else>
						<input type="text" name="ad-company" id="ad-company" lay-verify="required" placeholder="广告单位或者个人" class="layui-input input-switch" value="${b_ad.company}">
					</s:else>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">广告描述</label>
				<div class="layui-input-block">
					<s:if test="b_ad==null">
						<input type="text" name="ad-about" id="ad-about" lay-verify="required" placeholder="广告标题或者相关描述,长度10-20" class="layui-input input-switch">
					</s:if>
					<s:else>
						<input type="text" name="ad-about" id="ad-about" lay-verify="required" placeholder="广告标题或者相关描述,长度10-20" class="layui-input input-switch" value="${b_ad.about}">
					</s:else>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">广告超链接</label>
				<div class="layui-input-block">
					<s:if test="b_ad==null">
						<input type="text" name="ad-url" id="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input input-switch">
					</s:if>
					<s:else>
						<input type="text" name="ad-url" id="ad-url" lay-verify="required" placeholder="请输入一个有效的链接" autocomplete="off" class="layui-input input-switch" value="${b_ad.url}">
					</s:else>
				</div>
			</div>
			<!-- 上传广告图 -->
			<div class="layui-form-item">
				<label class="layui-form-label">底部广告图</label>
				<div class="layui-input-block">
					<div class="layui-upload">
						<button type="button" class="layui-btn  layui-btn-normal upload-btn" id="upload-bot-img" />
						<i class="layui-icon">&#xe681;</i>上传广告图
						</button>
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
			<div class="layui-form-item">
				<label class="layui-form-label"></label>
				<div class="layui-input-block">
					<button type="submit" class="layui-btn layui-btn-normal">保存</button>
					<button type="button" class="layui-btn layui-btn-default" id="closeIframe">取消</button>
				</div>
			</div>
		</form>
		</fieldset>
	</div>
	</div>
	<script type="text/javascript" src="<%=request.getContextPath()%>/layui/layui.js"></script>
	<script>
	layui.use(['form','upload'],function(){
		var form = layui.form,
		  $ = layui.jquery,
		  upload = layui.upload;
		
	//广告图片上传
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
	});
		var index = parent.layer.getFrameIndex(window.name);
		//关闭iframe
		$('#closeIframe').click(function(){
		    parent.$("#bot-hide").val(0);
		    parent.layer.close(index);
		});
		$("#bot-form").on("submit",function(e){
			e.preventDefault();
			var id = $("#ad-id").val();
			var company = $("#ad-company").val();
			var about = $("#ad-about").val();
			var url = $("#ad-url").val();
			var img = $("#bot-img-pre").prop("src");
			if(img===undefined||img===""){
				layer.msg("请选择图片");
				return ;
			}
			$.ajax({
				type: "post",
				dataType: "json",
				url: "ad/ad_update",
				data: {
					ad_id: id,
					ad_company: company,
					ad_about: about,
					ad_url: url,
					ad_img_url: img,
					ad_type: 1
				},
				success: function(data){
					if(data.status){
						parent.$("#bot-hide").val(1);
					    parent.layer.close(index);
					}else{
						layer.msg("保存出错");
					}
				},
				error:function(data){
					layer.msg("网络出错,稍后尝试");
				}
			});
		});
	</script>
</body>
</html>
