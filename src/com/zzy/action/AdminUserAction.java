package com.zzy.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.User;
import com.zzy.service.UserService;

@SuppressWarnings("serial")
public class AdminUserAction extends ActionSupport {
	@Resource UserService uService;
	//接收客户端参数
	private int limit;
	private int page;
	private Integer uid;
	private String reloadKey;
	private String reloadValue;
	
	//服务器返回数据
	private JSONObject json;
	private JSONObject search_json;
	private String message;
	private List<User> userSet;
	private User user;
	private String avatar_path;
	
	public String go_list_page(){
		return "go_list_page";
	}
	
	public String page_user(){
		if(reloadKey==null||reloadKey.equals("")){
			String hql = "from User";
			int offset = (page - 1) * limit;
			userSet = (List<User>) uService.pageUser(hql, offset, limit);
		}else{
			userSet = uService.listBySQL(reloadKey, reloadValue);
		}
		int count = userSet.size();
		json = new JSONObject();
		ArrayList<JSONObject> arrData = new ArrayList<JSONObject>();
		JSONObject data;
		for (User u : userSet) {
			// System.out.println(ns.getCategory().getName());
			if (u.getId() != null) {
				data = new JSONObject();
				data.put("id", u.getId());
				data.put("username", u.getUsername());
				data.put("name", u.getName());
				data.put("isLock", u.getIsLock());
				data.put("lastlogin", u.getLastlogin());
				arrData.add(data);
			} else {
				System.out.println("查询数据失败");
			}
		}
		message = "";
		json.put("code", 0);
		json.put("msg", message);
		json.put("count", count);
		json.put("data", arrData);
		return "page_user";
	}
	
	public String user_detail(){
		user = uService.getUserById(uid);
		avatar_path = user.getAvatar()==null? "Nimg/user.jpg":user.getAvatar().getPath();
		return "user_detail";
	}
	
	public String searchUser(){
		userSet = uService.listBySQL(reloadKey, reloadValue);
		search_json = new JSONObject();
		ArrayList<JSONObject> arrData = new ArrayList<JSONObject>();
		JSONObject data;
		for (User u : userSet) {
			data = new JSONObject();
			data.put("id", u.getId());
			data.put("username", u.getUsername());
			data.put("name", u.getName());
			data.put("isLock", u.getIsLock());
			data.put("lastlogin", u.getLastlogin());
			arrData.add(data);
		}
		message = "";
		search_json.put("code", 0);
		search_json.put("msg", message);
		search_json.put("count", userSet.size());
		search_json.put("data", arrData);
		return "searchUser";
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public JSONObject getJson() {
		return json;
	}

	public void setJson(JSONObject json) {
		this.json = json;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getAvatar_path() {
		return avatar_path;
	}

	public void setAvatar_path(String avatar_path) {
		this.avatar_path = avatar_path;
	}

	public String getReloadKey() {
		return reloadKey;
	}

	public void setReloadKey(String reloadKey) {
		this.reloadKey = reloadKey;
	}

	public String getReloadValue() {
		return reloadValue;
	}

	public void setReloadValue(String reloadValue) {
		this.reloadValue = reloadValue;
	}

	public JSONObject getSearch_json() {
		return search_json;
	}

	public void setSearch_json(JSONObject search_json) {
		this.search_json = search_json;
	}
	
	
}
