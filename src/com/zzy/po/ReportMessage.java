package com.zzy.po;

public class ReportMessage implements Comparable<ReportMessage>{
	private Integer id;
	private String content;//举报原因
	private String addition; //附加内容
	
	private User reporter; //举报者
	private Comment comment; //评论主体
	
	private long createTime; //  消息创建时间戳
	private String createTimeS; //消息创建时间
	private boolean checked;  //是否查看
	private boolean handled;  //是否处理
	private String handle_result; //处理结果
	
	@Override
	public int compareTo(ReportMessage re) {
		int result = (int) (re.createTime - this.createTime);
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
	public boolean getHandled() {
		return handled;
	}
	public void setHandled(boolean handled) {
		this.handled = handled;
	}

	public String getHandle_result() {
		return handle_result;
	}

	public void setHandle_result(String handle_result) {
		this.handle_result = handle_result;
	}

	
	
	
}
