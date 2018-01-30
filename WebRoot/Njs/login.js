$(document).ready(function(){
	$(".login-btn").on("click",function(e){
		$(".my-modal").fadeIn();
	});
	$(".modal-close").on("click",function(e){
		$(".my-modal").fadeOut();
	});
	$(".register-btn").click(function(e){
		location.href = location.origin+"/NewsCMS/register.jsp";
	});
	$("#login-form").on("submit",function(e){
		e.preventDefault();
		$("#username").val();
		$("#password").val();
		$.ajax({
			url: "user_login"
			,type: "post"
			,datatype: "json"
			,data:{
				username: $("#username").val(),
				password: $("#password").val()
			}
			,success:function(data){
				if(data.code>0){
					$("tip").txt(data.tip);
				}else{
					location.reload();
				}
			}
			,error:function(){
				alert("网络异常,请稍后尝试");
			}
		});
	})
});
    	
