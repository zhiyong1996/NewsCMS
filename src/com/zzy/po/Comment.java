package com.zzy.po;

import java.util.HashSet;
import java.util.Set;

public class Comment implements Comparable<Comment>{
	private Integer id;
	private String content;//评论内容
	private News news; //评论的新闻
	private User user; //评论人
	private long createTime; //评论创建时间戳
	private String createTimeS; //评论日期
	private boolean showed;  //是否显示
	private Set<ReportMessage> reportMessage = new HashSet<ReportMessage>();
	
	@Override
	public int compareTo(Comment com) {
		int result = (int) (com.createTime - this.createTime);
		return result;
	}
	
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
	public News getNews() {
		return news;
	}
	public void setNews(News news) {
		this.news = news;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public long getCreateTime() {
		return createTime;
	}
	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}
	public String getCreateTimeS() {
		return createTimeS;
	}
	public void setCreateTimeS(String createTimeS) {
		this.createTimeS = createTimeS;
	}
	public Set<ReportMessage> getReportMessage() {
		return reportMessage;
	}
	public void setReportMessage(Set<ReportMessage> reportMessage) {
		this.reportMessage = reportMessage;
	}

	public boolean getShowed() {
		return showed;
	}

	public void setShowed(boolean showed) {
		this.showed = showed;
	}
	
	
}
