$(function() {

	var username_pass = false
	   ,password_pass = false
	   ,passagain_pass = false
	   ,email_pass = false
	   ,err_msg = "";
	
	var can_use ;
	
	//表单信息的三种状态
	const common = 0,
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

    $("#username").on("change", function(e) {
        var value = this.value;

        var gf_dom = $($(this).parent()).parent();
        if (value == "" || value == undefined) {
        	show_msg(gf_dom,error,"用户名不能为空");
        	username_pass = false;
            return;
        } else if(value.trim().length<6 || value.trim().length>12){
        	show_msg(gf_dom,error,"长度应该为6-12位字符串");
        	username_pass = false;
            return;
        }
        else {
            $.ajax({
                 url: 'register/has_username',
                 type: 'post',
                 dataType: 'html',
                 data: {
                     username: value
                 },
                 success: function(data) {
                	 if(data.has_name){
                		 show_msg(gf_dom,error,"帐号已被使用");
                		 username_pass = false;
                	 }else{
                		 show_msg(gf_dom,success,"帐号可使用");
                		 can_use = value;
                		 username_pass = true;
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
    		password_pass = false;
    		show_msg(gf_dom,error,"密码不能为空");
    		$("#passagain").val("").change();
    	}else if(!value.match(/^[a-z0-9_-]{6,12}$/)){
    		password_pass = false;
    		show_msg(gf_dom,error,"密码格式不正确");
    		$("#passagain").change();
    	}else{
    		show_msg(gf_dom,success,"");
    		password_pass = true;
    		$("#passagain").change();
    	}
    })
    $("#passagain").on("change",function(e){
    	var value = this.value;
    	var gf_dom = $($(this).parent()).parent();
    	if(value == "" || value == undefined){
    		passagain_pass = false;
    		show_msg(gf_dom,error,"密码不能为空");
    	}else if(this.value !== $("#password").val()){
    		passagain_pass = false;
    		show_msg(gf_dom,error,"密码不一致");
    	}else{
    		show_msg(gf_dom,success,"");
    		passagain_pass = true;
    	}
    });

    $("#email").on("change",function(e){
    	var value = this.value;
    	var gf_dom = $($(this).parent()).parent();
    	if(value == "" || value == undefined){
    		email_pass = false;
    		show_msg(gf_dom,error,"邮箱不能为空");
    	}
    	else if(!value.match(/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/)){
    		email_pass = false;
    		show_msg(gf_dom,error,"邮箱格式不正确");
    	}else{
    		show_msg(gf_dom,success,"");
    		email_pass = true;
    	}
    });
    
    $("#form").submit(function(e){
    	//e.preventDefault();
    	console.log("start");
    	$("#username").change();
    	console.log("username change");
    	$("#password").change();
    	console.log("ps change");
    	$("#passagain").change();
    	$("#email").change();
    	if(!(username_pass && password_pass && passagain_pass && email_pass)){
    		return false;
    	}
    });

});
