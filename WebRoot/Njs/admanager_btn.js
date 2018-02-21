		function switchEdit(elem,status){
			if(status){
				//编辑栏的三个按钮
				elem.find("#edit-btn").addClass("layui-btn-disabled");
				elem.find("#cancel-edit").removeClass("layui-btn-disabled");
				elem.find(".save-btn").removeClass("layui-btn-disabled");
				//内容区域的按钮和input
				elem.find(".upload-btn").removeClass("layui-btn-disabled");
				elem.find(".input-switch").removeClass("layui-disabled");
				//背景和边框
				elem.find(".lock-bg").fadeOut();
				elem.addClass("active-edit");
				elem.find(".lock-button").css("border-bottom-color","#009688");
				
			}else{
				//编辑栏的三个按钮
				elem.find("#edit-btn").removeClass("layui-btn-disabled");
				elem.find("#cancel-edit").addClass("layui-btn-disabled");
				elem.find(".save-btn").addClass("layui-btn-disabled");
				//内容区域的按钮和input
				elem.find(".upload-btn").addClass("layui-btn-disabled");
				elem.find(".input-switch").addClass("layui-disabled");
				//背景和边框
				elem.find(".lock-bg").fadeIn();
				elem.removeClass("active-edit");
				elem.find(".lock-button").css("border-color","#e6e6e6");
			}
		}

//锁定切换
	  $(".top-field").on("click","#edit-btn",function(e){		  
		  switchEdit($(".top-field"),true);

	  }).on("click","#cancel-edit",function(e){
		  switchEdit($(".top-field"),false);
		  
	  }).on("click","#save-top",function(e){
		  var $ad = $(".top-field");
		  var ad_about = $ad.find("input[name='ad-about']").val();
		  var ad_url = $ad.find("input[name='ad-url']").val();
		  var ad_img = $ad.find(".layui-upload-img").prop("src");
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
				  switchEdit($ad,false);
			  },
			  error: function(e){
				  layer.msg("网络出错");
			  }
			  
		  })
	  });
/*****************************bot**************************************************/
	  $(".bot-field").on("click","#edit-btn",function(e){
		  switchEdit($(".bot-field"),true);
	  }).on("click","#cancel-edit",function(e){
		  switchEdit($(".bot-field"),false);

	  }).on("click","#save-bot",function(e){
		  var $ad = $(".bot-field");
		  var ad_about = $ad.find("input[name='ad-about']").val();
		  var ad_url = $ad.find("input[name='ad-url']").val();
		  var ad_img = $ad.find(".layui-upload-img").prop("src");

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
				  switchEdit($(".bot-field"),false);
			  },
			  error: function(e){
				  layer.msg("网络出错");
			  }
			  
		  })
	  });
	  //side/////////////////////////////////////////////////////////////////////////////////
	  $(".side-field").on("click","#edit-btn",function(e){
		  switchEdit($(".side-field"),true);
	  }).on("click","#cancel-edit",function(e){
		  switchEdit($(".side-field"),false);

	  }).on("click","#save-side",function(e){
		  var $ad = $(".side-field");
		  var ad_about = $ad.find("input[name='ad-about']").val();
		  var ad_url = $ad.find("input[name='ad-url']").val();
		  var ad_img = $ad.find(".layui-upload-img").prop("src");

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
				  switchEdit($(".side-field"),false);
			  },
			  error: function(e){
				  layer.msg("网络出错");
			  }
			  
		  })
	  });