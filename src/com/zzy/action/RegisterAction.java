package com.zzy.action;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.zzy.service.UserService;

@SuppressWarnings("serial")
public class RegisterAction extends ActionSupport{
	private final static boolean HAS_USERNAME = true;
	private final static boolean NO_USERNAME = false;
	@Resource UserService uService;
	private String username;
	private String password;
	private String passagain;
	
	private JSONObject backjson = new JSONObject();
	
	public String sign_up(){
		return "";
	}
	
	public String sign_in(){
		return "sign_in";
	}
	
	public String has_username(){
		int size = uService.getUserByName(username).size();
		if(size>0){
			System.out.println("已存在");
			backjson.put("has_name", HAS_USERNAME);	
			backjson.put("msg","账号已存在");
		}else{
			System.out.println("不存在");
			backjson.put("has_name", NO_USERNAME);
			backjson.put("msg","账号可用");
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

	public JSONObject getBackjson() {
		return backjson;
	}

	public void setBackjson(JSONObject backjson) {
		this.backjson = backjson;
	}
	
	
}
