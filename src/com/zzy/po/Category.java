package com.zzy.po;

import java.util.HashSet;
import java.util.Set;

public class Category {
	private Integer id;
	private String name;
	private long createTime;
	private Set<News> newss = new HashSet<News>();
	private boolean used; //是否启用
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Set<News> getNewss() {
		return newss;
	}
	public void setNewss(Set<News> newss) {
		this.newss = newss;
	}
	public long getCreateTime() {
		return createTime;
	}
	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}
	public boolean isUsed() {
		return used;
	}
	public void setUsed(boolean used) {
		this.used = used;
	}
	
	
}
