package com.zzy.action;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LoginAction extends ActionSupport{
	private String username;
	private String password;
	private String error;
	private Map<String,Object> session;
	
	public String login(){
		if(username.equals("admin")&&password.equals("123456")){
			session = ActionContext.getContext().getSession();
			session.put("admin", username);
			System.out.println("登录成功");
			return SUCCESS;
		}else{
			System.out.println("登录失败");
			return LOGIN;
		}
	}
	
	public String quit(){
		return "quit";
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
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	
	
}
