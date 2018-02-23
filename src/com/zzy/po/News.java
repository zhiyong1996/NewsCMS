package com.zzy.po;

import java.util.HashSet;
import java.util.Set;


public class News implements Comparable<News>{
	private Integer id; // 新闻主键id
	private String createId; // 自建id,新闻创建设定
	private String title; // 新闻标题
	private String content; // 新闻内容
	private String newsfrom; // 新闻来源
	private long createTime; // 创建时间戳
	private String createTimeS; // 创建时间S
	private long updateTime; // 更新时间戳
	private String updateTimeS; // 更新时间
	private Boolean issue; // 是否展示

	private CaImg caimg; // 轮播新闻图
	private Integer newstype; // 新闻位置，一般有3个位置,轮播位(需要预览图),热点和普通新闻,无需预览图，用数字0,1,2表示

	private Category category; // 分类
	private Set<Comment> comments = new HashSet<Comment>(); // 新闻评论
	private Set<NewsImg> newsimgs = new HashSet<NewsImg>(); // 新闻图片
	
	@Override
	public int compareTo(News n) {
		int result = (int) (n.createTime - this.createTime);
		return result;
	}

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

	public Boolean getIssue() {
		return issue;
	}

	public void setIssue(Boolean issue) {
		this.issue = issue;
	}

	public CaImg getCaimg() {
		return caimg;
	}

	public void setCaimg(CaImg caimg) {
		this.caimg = caimg;
	}

	public int getNewstype() {
		return newstype;
	}

	public void setNewstype(Integer newstype) {
		this.newstype = newstype;
	}

	public String getCreateTimeS() {
		return createTimeS;
	}

	public void setCreateTimeS(String createTimeS) {
		this.createTimeS = createTimeS;
	}

	public String getUpdateTimeS() {
		return updateTimeS;
	}

	public void setUpdateTimeS(String updateTimeS) {
		this.updateTimeS = updateTimeS;
	}


	
}
