$(function() {

	var username_pass = false
	   ,password_pass = false
	   ,passagain_pass = false
	   ,email_pass = false
	   ,err_msg = "";
	
	//表单信息的三种状态
	var common = 0,
		error = 1,
		success = 2;
	
	//根据不同状态显示不同信息
    function show_msg(JQobj, status, msg) {
    	var tip  = JQobj.find(".tip");
        if(status === success){
        	JQobj.removeClass('has-success has-feedback has-error my-error');
        	JQobj.addClass('has-success has-feedback');
        	tip.html(msg);
        }else if(status === error){
        	JQobj.removeClass('has-success has-feedback has-error my-error');
        	JQobj.addClass('has-error has-feedback my-error');
        	tip.html(msg);
        }else if(status === common){
        	JQobj.removeClass('has-success has-feedback has-error my-error');
        	tip.html(msg);
        }
    }

    function check_value(type,value){
    	//非空验证
    	if(value == "" || value.trim() == ""){
    		err_msg = type+"不能为空";
    		return false;
    	}else if(value.length){}
    }

    $("#username").on("change", function(e) {
        var value = this.value;
        
        var gf_dom = $($(this).parent()).parent();
        if (value == "" || value == undefined) {
        	show_msg(gf_dom,common,"");
            return;
        } else {
            $.ajax({
                 url: 'register/has_username',
                 type: 'post',
                 dataType: 'html',
                 data: {
                     username: value
                 },
                 success: function(data) {
                	 console.log(data);
                	 if(data.has_name){
                		 show_msg(gf_dom,error,"帐号已被可用");
                	 }else{
                		 show_msg(gf_dom,success,"帐号可使用");
                	 }
                 },
                 error: function() {
                     console.log("网络出错")
                 }
             });
        }
    })
    $("#password").on("change",function(e){
    	var value = this.value;
    	var gf_dom = $($(this).parent()).parent();
    	
    	if(value == "" || value == undefined){
    		show_msg(gf_dom,common,"");
    		$("#passagain").val("").change();
    	}else if(!value.match(/^[a-z0-9_-]{6,12}$/)){
    		show_msg(gf_dom,error,"密码格式不正确");
    		$("#passagain").change();
    	}else{
    		show_msg(gf_dom,success,"");
    		$("#passagain").change();
    	}
    })
    $("#passagain").on("change",function(e){
    	var value = this.value;
    	var gf_dom = $($(this).parent()).parent();
    	if(value == "" || value == undefined){
    		show_msg(gf_dom,common,"");
    	}else if(this.value !== $("#password").val()){
    		show_msg(gf_dom,error,"密码不一致");
    	}else{
    		show_msg(gf_dom,success,"");
    	}
    });

    $("#email").on("change",function(e){
    	var value = this.value;
    	var gf_dom = $($(this).parent()).parent();
    	if(value == "" || value == undefined){
    		show_msg(gf_dom,common,"");
    	}
    	else if(!value.match(/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/)){
    		show_msg(gf_dom,error,"邮箱格式不正确");
    	}else{
    		show_msg(gf_dom,success,"");
    	}
    });
    
    $("#form").on("submit",function(e){
    	e.preventDefault();
    	var formData = new FormData(this);
    	console.log(typeof formData)
    	
    });

});
