package com.zzy.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.Comment;
import com.zzy.po.ReportMessage;
import com.zzy.po.User;
import com.zzy.service.CommentService;
import com.zzy.service.ReportService;

@SuppressWarnings("serial")
public class ReportMessageAction extends ActionSupport{
	@Resource ReportService rService;
	@Resource CommentService comService;
	
	//客户端传递数据
	private int limit;
	private int page;
	private Integer msgid;
	private String handleResult; //处理结果
	
	//服务器返回数据
	private List<ReportMessage> rmsgList;
	private JSONObject json;
	private ReportMessage rmsg;
	private User com_ower;
	private Comment comment;
	
	public String go_list(){
		return "go_list";
	}
	
	public String list_report_msg(){
		String hql = "from ReportMessage order by createTime desc";
		int offset = (page - 1) * limit;
		int count = rService.all().size();
		rmsgList = rService.listData(hql, offset, limit);
		json = new JSONObject();
		ArrayList<JSONObject> arrData = new ArrayList<JSONObject>();
		JSONObject data;
		for (ReportMessage rs : rmsgList) {
			// System.out.println(ns.getCategory().getName());
			data = new JSONObject();
			data.put("id",rs.getId());
			data.put("reporter", rs.getReporter().getUsername());
			data.put("content", rs.getContent());
			data.put("addition", rs.getAddition());
			data.put("checked", rs.getChecked()?"已读":"未读");
			data.put("handled", rs.getHandled()?"已处理":"未处理");
			data.put("createTimeS", rs.getCreateTimeS());
			arrData.add(data);
		}
		String message = "";
		json.put("code", 0);
		json.put("msg", message);
		json.put("count", count);
		json.put("data", arrData);
		return "list_report_msg";
	}
	
	//详情
	public String msg_detail(){
		rmsg = rService.getById(msgid);
		rmsg.setChecked(true);
		rService.saveOrUpdate(rmsg);
		comment = rmsg.getComment();
		if(!(comment == null)){
			com_ower = comment.getUser();
		}
		return "msg_detail";
	}
	//提交处理结果
	public String handle_result(){
		json = new JSONObject();
		System.out.print(handleResult);
		if(!handleResult.equals("")&&!(handleResult==null)){
			rmsg = rService.getById(msgid);
			
			rmsg.setHandle_result(handleResult);
			rmsg.setHandled(true);
			if(handleResult.equals("删除")){		
				comService.delCom(rmsg.getComment());
			}else if(handleResult.equals("隐藏")){
				rmsg.setHandle_result(handleResult);
				rmsg.setHandled(true);
				Comment c = rmsg.getComment();
				c.setShowed(false);
				comService.saveOrUpdate(c);
				rService.saveOrUpdate(rmsg);
			}	
			json.put("code", 0);
			json.put("msg", "处理成功");
		}else{
			json.put("code", 1);
			json.put("msg", "异常");
		}
		return "handle_result";
	}
	//删除单条
	public String del_single(){
		rmsg = rService.getById(msgid);
		rService.delete(rmsg);
		json = new JSONObject();
		json.put("code", 0);
		json.put("msg", "删除成功");
		return "del_single";
	}
	
	//批量更新
	public String batch_handle(){
		return "batch_handle";
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

	public List<ReportMessage> getRmsgList() {
		return rmsgList;
	}

	public void setRmsgList(List<ReportMessage> rmsgList) {
		this.rmsgList = rmsgList;
	}

	public JSONObject getJson() {
		return json;
	}

	public void setJson(JSONObject json) {
		this.json = json;
	}

	public Integer getMsgid() {
		return msgid;
	}

	public void setMsgid(Integer msgid) {
		this.msgid = msgid;
	}

	public ReportMessage getRmsg() {
		return rmsg;
	}

	public void setRmsg(ReportMessage rmsg) {
		this.rmsg = rmsg;
	}

	public User getCom_ower() {
		return com_ower;
	}

	public void setCom_ower(User com_ower) {
		this.com_ower = com_ower;
	}

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public String getHandleResult() {
		return handleResult;
	}

	public void setHandleResult(String handleResult) {
		this.handleResult = handleResult;
	}

	
	
}
