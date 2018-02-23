package com.zzy.po;

public class ReportMessage {
	private Integer id;
	private String content;//举报原因
	private String addition; //附加内容
	
	private User reporter; //举报者
	private Comment comment; //评论主体
	
	private long createTime; //  消息创建时间戳
	private String createTimeS; //消息创建时间
	private boolean checked;  //是否查看
	
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
	public String getAddition() {
		return addition;
	}
	public void setAddition(String addition) {
		this.addition = addition;
	}
	public User getReporter() {
		return reporter;
	}
	public void setReporter(User reporter) {
		this.reporter = reporter;
	}
	public Comment getComment() {
		return comment;
	}
	public void setComment(Comment comment) {
		this.comment = comment;
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
	public boolean getChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
	
}
