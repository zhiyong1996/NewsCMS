package com.zzy.po;

public class Comment {
	private Integer id;
	private String content;
//	private User form;
//	private User to;
	private News news;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
//	public User getForm() {
//		return form;
//	}
//	public void setForm(User form) {
//		this.form = form;
//	}
//	public User getTo() {
//		return to;
//	}
//	public void setTo(User to) {
//		this.to = to;
//	}
	public News getNews() {
		return news;
	}
	public void setNews(News news) {
		this.news = news;
	}
	
	
}
