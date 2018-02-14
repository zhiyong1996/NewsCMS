//锁定切换
	  $(".top-field").on("click","#edit-btn",function(e){
		  var $ad = $(".top-field");		  
		  $(this).addClass("layui-btn-disabled");
		  $ad.find("#cancel-edit").removeClass("layui-btn-disabled");
		  
		  $ad.find(".lock-bg").fadeOut();
		  $ad.find(".upload-btn").removeClass("layui-btn-disabled");
		  
		  $ad.addClass("active-edit");
		  $ad.find(".input-switch").removeClass("layui-disabled");
		  $ad.find("input[type='checkbox']").removeProp("disabled");
		  $ad.find(".save-btn").slideDown();
	  }).on("click","#cancel-edit",function(e){
		  var $ad = $(".top-field");
		  $(this).addClass("layui-btn-disabled");
		  $("#edit-btn").removeClass("layui-btn-disabled");
		  $ad.find(".lock-bg").fadeIn();
		  $ad.find(".upload-btn").addClass("layui-btn-disabled");
		  $ad.removeClass("active-edit");
		  $ad.find(".input-switch").addClass("layui-disabled");
		  $ad.find("input[type='checkbox']").prop({disabled: true});
		  $ad.find(".save-btn").slideUp();
	  }).on("click","#save-top",function(e){
		  var $ad = $(".top-field");
		  var ad_about = $ad.find("input[name='ad-about']").val();
		  var ad_url = $ad.find("input[name='ad-url']").val();
		  var ad_img = $ad.find(".layui-upload-img").prop("src");
		  alert(ad_about);
		  if(ad_about === ""||ad_url===""||ad_img===""){
			  layer.msg("请填写完整信息");
			  return ;
		  }
		  $.ajax({
			  type: "post",
			  url: "ad/ad_update",
			  dataType: "html",
			  data: {
				  ad_type: 0,
				  ad_about: ad_about,
				  ad_img_url: ad_img,
				  ad_url: ad_url
			  },
			  success: function(data){
				  if(!data.code>0)
				  layer.msg("保存成功");
			  },
			  error: function(e){
				  layer.msg("网络出错");
			  }
			  
		  })
	  });
/*****************************bot**************************************************/
	  $(".bot-field").on("click","#edit-btn",function(e){
		  var $ad = $(".bot-field");
		  $(this).addClass("layui-btn-disabled");
		  $ad.find("#cancel-edit").removeClass("layui-btn-disabled");
		  $ad.find(".lock-bg").fadeOut();
		  $ad.find(".upload-btn").removeClass("layui-btn-disabled");
		  $ad.addClass("active-edit");
		  $ad.find(".input-switch").removeClass("layui-disabled");
		  $ad.find("input[type='checkbox']").removeProp("disabled");
		  $ad.find(".save-btn").slideDown();
	  }).on("click","#cancel-edit",function(e){
		  var $ad = $(".bot-field");
		  $(this).addClass("layui-btn-disabled");
		  $ad.find("#edit-btn").removeClass("layui-btn-disabled");
		  $ad.find(".lock-bg").fadeIn();
		  $ad.find(".upload-btn").addClass("layui-btn-disabled");
		  $ad.removeClass("active-edit");
		  $ad.find(".input-switch").addClass("layui-disabled");
		  $ad.find("input[type='checkbox']").prop({disabled: true});
		  $ad.find(".save-btn").slideUp();
	  }).on("click","#save-bot",function(e){
		  var $ad = $(".bot-field");
		  var ad_about = $ad.find("input[name='ad-about']").val();
		  var ad_url = $ad.find("input[name='ad-url']").val();
		  var ad_img = $ad.find(".layui-upload-img").prop("src");
		  alert(ad_about);
		  if(ad_about === ""||ad_url===""||ad_img===""){
			  layer.msg("请填写完整信息");
			  return ;
		  }
		  $.ajax({
			  type: "post",
			  url: "ad/ad_update",
			  dataType: "html",
			  data: {
				  ad_type: 1,
				  ad_about: ad_about,
				  ad_img_url: ad_img,
				  ad_url: ad_url
			  },
			  success: function(data){
				  if(!data.code>0)
				  layer.msg("保存成功");
			  },
			  error: function(e){
				  layer.msg("网络出错");
			  }
			  
		  })
	  });
	  //side/////////////////////////////////////////////////////////////////////////////////
	  $(".side-field").on("click","#edit-btn",function(e){
		  var $ad = $(".side-field");
		  $(this).addClass("layui-btn-disabled");
		  $ad.find("#cancel-edit").removeClass("layui-btn-disabled");
		  $ad.find(".lock-bg").fadeOut();
		  $ad.find(".upload-btn").removeClass("layui-btn-disabled");
		  $ad.addClass("active-edit");
		  $ad.find(".input-switch").removeClass("layui-disabled");
		  $ad.find("input[type='checkbox']").removeProp("disabled");
		  $ad.find(".save-btn").slideDown();
	  }).on("click","#cancel-edit",function(e){
		  var $ad = $(".side-field");
		  $(this).addClass("layui-btn-disabled");
		  $ad.find("#edit-btn").removeClass("layui-btn-disabled");
		  $ad.find(".lock-bg").fadeIn();
		  $ad.find(".upload-btn").addClass("layui-btn-disabled");
		  $ad.removeClass("active-edit");
		  $ad.find(".input-switch").addClass("layui-disabled");
		  $ad.find("input[type='checkbox']").prop({disabled: true});
		  $ad.find(".save-btn").slideUp();
	  }).on("click","#save-side",function(e){
		  var $ad = $(".side-field");
		  var ad_about = $ad.find("input[name='ad-about']").val();
		  var ad_url = $ad.find("input[name='ad-url']").val();
		  var ad_img = $ad.find(".layui-upload-img").prop("src");
		  alert(ad_about);
		  if(ad_about === ""||ad_url===""||ad_img===""){
			  layer.msg("请填写完整信息");
			  return ;
		  }
		  $.ajax({
			  type: "post",
			  url: "ad/ad_update",
			  dataType: "html",
			  data: {
				  ad_type: 2,
				  ad_about: ad_about,
				  ad_img_url: ad_img,
				  ad_url: ad_url
			  },
			  success: function(data){
				  if(!data.code>0)
				  layer.msg("保存成功");
			  },
			  error: function(e){
				  layer.msg("网络出错");
			  }
			  
		  })
	  });