package com.zzy.po;

import java.util.HashSet;
import java.util.Set;

public class News {
	private Integer id;       //新闻主键id
	private String createId; //自建id,新闻创建设定
	private String title;     //新闻标题
	private String content;   //新闻内容
	private String newsfrom;  //新闻来源
	private long createTime;  //创建时间
	private long updateTime;  //更新时间
	private Category category;  //分类
	private boolean isShow;   //是否展示
	private Set<Comment> comments = new HashSet<Comment>(); //新闻评论
	private Set<NewsImg> newsimgs = new HashSet<NewsImg>(); //新闻图片
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCreateId() {
		return createId;
	}
	public void setCreateId(String createId) {
		this.createId = createId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getNewsfrom() {
		return newsfrom;
	}
	public void setNewsfrom(String newsfrom) {
		this.newsfrom = newsfrom;
	}
	public long getCreateTime() {
		return createTime;
	}
	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}
	public long getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(long updateTime) {
		this.updateTime = updateTime;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public Set<Comment> getComments() {
		return comments;
	}
	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}
	public Set<NewsImg> getNewsimgs() {
		return newsimgs;
	}
	public void setNewsimgs(Set<NewsImg> newsimgs) {
		this.newsimgs = newsimgs;
	}
	public boolean isShow() {
		return isShow;
	}
	public void setShow(boolean isShow) {
		this.isShow = isShow;
	}
	
	
}
