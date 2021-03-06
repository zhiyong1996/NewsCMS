package com.zzy.action;

import java.util.Date;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.Avatar;
import com.zzy.po.User;
import com.zzy.service.AvatarService;
import com.zzy.service.UserService;

@SuppressWarnings("serial")
public class RegisterAction extends ActionSupport{
	private final static boolean HAS_USERNAME = true;
	private final static boolean NO_USERNAME = false;
	@Resource UserService uService;
	@Resource AvatarService avaService;
	private String username;
	private String password;
	private String passagain;
	private String email;
	
	private JSONObject backjson = new JSONObject();
	
	public String add_user(){
		if(getUsername().equals("")||getPassword().equals("")){
			ActionContext.getContext().put("msg", "账户创建异常");
			ActionContext.getContext().put("rs", false);
			return "register_rs";
		}else{
			User u = new User();
			u.setUsername(username);
			u.setName(username);
			u.setPassword(password);
			u.setSex(0);
			u.setEmail(email);
			u.setCreateTime(StaticParam.DateFormat2.format(new Date()));
			Avatar av = new Avatar();
			av.setImgName("user.jpg");
			av.setPath("/NewsCMS/Nimg/user.jpg");
			avaService.save(av);
			u.setAvatar(av);
			Integer uid = uService.save(u);
			if(uid instanceof Integer){
				ActionContext.getContext().put("msg", "帐号:["+username+"]创建成功");
				ActionContext.getContext().put("rs", true);
			}else{
				ActionContext.getContext().put("msg", "账户创建异常");
				ActionContext.getContext().put("rs", false);
			}
			return "register_rs";
		}
	}
	
	public String user_login(){
		return "user_login";
	}
	
	public String has_username(){
		User user = uService.getByUsername(username);
		if(user == null){
			System.out.println("帐号可用");
			backjson.put("has_name", NO_USERNAME);
			backjson.put("msg","账号可用");
		}else{
			System.out.println("已存在");
			backjson.put("has_name", HAS_USERNAME);	
			backjson.put("msg","账号已存在");
		}
		return "has_N";
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassagain() {
		return passagain;
	}

	public void setPassagain(String passagain) {
		this.passagain = passagain;
	}
	
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public JSONObject getBackjson() {
		return backjson;
	}

	public void setBackjson(JSONObject backjson) {
		this.backjson = backjson;
	}
	
	
}
