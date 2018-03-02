$(document).ready(function(e){
			function updateInfo(data){
				console.log(data);
				$(".name-wrap").find(".info-show").html(data.name);
				$("#name").val(data.name);
				
				var sex = "";
				$("input[name='sex']").prop({checked:false})
				if(data.sex === 0){
					sex = "未知";
				}else if(data.sex == 1){
					sex = "男";
					$("#male").prop({checked: true});
				}else {
					sex= "女";
					$("#female").prop({checked: true});
				}			
				$(".sex-wrap").find(".info-show").text(sex);
				
				$(".headline-wrap").find(".info-show").text(data.headline);
				$("#headline").val(data.headline);
				
				$(".email-wrap").find(".info-show").text(data.email);
				$("#email").val(data.email);
			}
			$("#edit-btn").on("click",function(e){
				$("#profile").addClass("edit");
			});
			$("#cancel-btn").on("click",function(e){
				$("#profile").removeClass("edit");
			});
			//上传头像 start
			$("#avatar-file").on("change",function(e){
				var formdata = new FormData();
				var fileObj = document.getElementById("avatar-file").files[0];
				var uid = $("#uid").val();
				if (typeof (fileObj) == "undefined" || fileObj.size <= 0) {
	                   alert("请选择图片");
	                   return;
	               }
				formdata.append("file",fileObj);
				formdata.append("uid",uid);
				$.ajax({
					type: "post",
					url: "upload/uploadUserImg",
					cache: false,//上传文件无需缓存
	                processData: false,//用于对data参数进行序列化处理 这里必须false
	                contentType: false, //必须
			        dataType: "json", 
			        data: formdata,
					success: function(data){
						console.log(data);
						alert("修改成功");
						$("#avatar-img").prop({src:data.imgUrl});
						$("#nav-avatar").prop({src:data.imgUrl});
					},
					error: function(data){
						alert("网络出错，请稍后尝试");
					}
				});
			});
			//头像上传 end
			
			$("#save-btn").on("click",function(){
				var name = $("#name").val();
				var email = $("#email").val();
				var headline = $("#headline").val();
				var sex = $("input[name='sex']:checked").val();
				sex = sex ? sex: 0;
				if(!sex){
					alert("请选择性别");
					return;
				}
				var uid = $("#uid").val();
				$.ajax({
					type: "post",
					url: "update_user_info",
					dataType: "json",
					data: {
						name: name,
						email: email,
						headline: headline,
						sex: sex,
						uid: uid
					},
					success: function(data){
						if(data.status){
							updateInfo(data);
							$("#cancel-btn").click();
							alert("更新成功");
						}
					},
					error: function(data){
						alert("网络出错，请稍后重试");
					}
					
				});
			})
			
		});