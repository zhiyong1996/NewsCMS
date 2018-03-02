$(document).ready(function(){
	function renderAd(elem,data){
		if(elem){
			console.log(data.url+"\n"+data.img)
			elem.find(".ad-url").prop({href: data["url"]});
			elem.find(".ad-img").prop({src: data["img"]});
			elem.find(".ad-title").html(data["about"]);
			elem.css("display","block");
		}else
			return;
	}
	$.ajax({
		method: "post",
		dataType: "json",
		url: "get_ad",
		success: function(data){
			console.log(data);
			for(let ad in data){
				var elem = $("#ad-"+ad);
				renderAd(elem,data[ad]);
			}
		},
		error: function(e){
			console.error("网络异常,广告获取失败");
		}
	});
});