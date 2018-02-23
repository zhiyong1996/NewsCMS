package com.zzy.po;

import java.util.HashSet;
import java.util.Set;

public class User {
	private Integer id;
	private String username;
	private String password;
	private String Email;
	private Avatar avatar;
	private Boolean isLock;   //是否锁定
	private String lastlogin;
	private Set<Comment> comments = new HashSet<Comment>();
	private Set<ReportMessage> reportMessage = new HashSet<ReportMessage>();
	
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
	
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public Avatar getAvatar() {
		return avatar;
	}
	public void setAvatar(Avatar avatar) {
		this.avatar = avatar;
	}
	
	public Boolean getIsLock() {
		return isLock;
	}
	public void setIsLock(Boolean isLock) {
		this.isLock = isLock;
	}
	public Set<Comment> getComments() {
		return comments;
	}
	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}
	public String getLastlogin() {
		return lastlogin;
	}
	public void setLastlogin(String lastlogin) {
		this.lastlogin = lastlogin;
	}
	public Set<ReportMessage> getReportMessage() {
		return reportMessage;
	}
	public void setReportMessage(Set<ReportMessage> reportMessage) {
		this.reportMessage = reportMessage;
	}
	
}
