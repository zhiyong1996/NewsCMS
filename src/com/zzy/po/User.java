package com.zzy.po;

import java.util.HashSet;
import java.util.Set;

public class User {
	private Integer id;
	private String username;
	private String password;
	private Avatar avatar;
	private Boolean lock;   //是否锁定
	private Set<Comment> comments = new HashSet<Comment>(); 
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public Avatar getAvatar() {
		return avatar;
	}
	public void setAvatar(Avatar avatar) {
		this.avatar = avatar;
	}
	
	public Boolean getLock() {
		return lock;
	}
	public void setLock(Boolean lock) {
		this.lock = lock;
	}
	public Set<Comment> getComments() {
		return comments;
	}
	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}
	
}
