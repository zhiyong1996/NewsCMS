//锁定切换
	  $(".top-field").on("click","#edit-btn",function(e){
		  var $ad = $(".top-field");
		  
		  $(this).addClass("layui-btn-disabled");
		  $("#cancel-edit").removeClass("layui-btn-disabled");
		  
		  $ad.addClass("active-edit");
		  $ad.find(".input-switch").removeClass("layui-disabled");
		  $ad.find("input[type='checkbox']").removeProp("disabled");
		  $ad.find(".save-btn").slideDown();
	  }).on("click","#cancel-edit",function(e){
		  var $ad = $(".top-field");
		  $(this).addClass("layui-btn-disabled");
		  $("#edit-btn").removeClass("layui-btn-disabled");
		  
		  $ad.removeClass("active-edit");
		  $ad.find(".input-switch").addClass("layui-disabled");
		  $ad.find("input[type='checkbox']").prop({disabled: true});
		  $ad.find(".save-btn").slideUp();
	  });
	  //bot
	  $(".bot-field").on("click","#edit-btn",function(e){
		  var $ad = $(".bot-field");
		  $(this).addClass("layui-btn-disabled");
		  $ad.find("#cancel-edit").removeClass("layui-btn-disabled");
		  
		  $ad.addClass("active-edit");
		  $ad.find(".input-switch").removeClass("layui-disabled");
		  $ad.find("input[type='checkbox']").removeProp("disabled");
		  $ad.find(".save-btn").slideDown();
	  }).on("click","#cancel-edit",function(e){
		  var $ad = $(".bot-field");
		  $(this).addClass("layui-btn-disabled");
		  $ad.find("#edit-btn").removeClass("layui-btn-disabled");

		  $ad.removeClass("active-edit");
		  $ad.find(".input-switch").addClass("layui-disabled");
		  $ad.find("input[type='checkbox']").prop({disabled: true});
		  $ad.find(".save-btn").slideUp();
	  });
	  //side
	  $(".side-field").on("click","#edit-btn",function(e){
		  var $ad = $(".side-field");
		  $(this).addClass("layui-btn-disabled");
		  $ad.find("#cancel-edit").removeClass("layui-btn-disabled");
		  
		  $ad.addClass("active-edit");
		  $ad.find(".input-switch").removeClass("layui-disabled");
		  $ad.find("input[type='checkbox']").removeProp("disabled");
		  $ad.find(".save-btn").slideDown();
	  }).on("click","#cancel-edit",function(e){
		  var $ad = $(".side-field");
		  $(this).addClass("layui-btn-disabled");
		  $ad.find("#edit-btn").removeClass("layui-btn-disabled");

		  $ad.removeClass("active-edit");
		  $ad.find(".input-switch").addClass("layui-disabled");
		  $ad.find("input[type='checkbox']").prop({disabled: true});
		  $ad.find(".save-btn").slideUp();
	  });