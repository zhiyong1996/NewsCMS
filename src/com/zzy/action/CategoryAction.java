package com.zzy.action;

import javax.annotation.Resource;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.Category;
import com.zzy.service.CategoryService;
import com.zzy.service.NewsService;

@SuppressWarnings("serial")
public class CategoryAction extends ActionSupport{
	@Resource NewsService newsService;
	@Resource CategoryService cService;
	private Integer cid;
	private String categoryName;
	private long createTime;
	
	private Category c;
	private String message;
	
	public String addCategory(){
		c = new Category();
		c.setName(categoryName);
		c.setCreateTime(System.currentTimeMillis());
		cService.save(c);
		message = "添加成功";
		return "addCategory";
	}
	
	public String delCategory(){
		c = cService.getById(cid);
		cService.delCategory(c);
		message = "删除成功";
		return "delCategory";
	}
	
	public String goUpdate(){
		c = cService.getById(cid);
		ActionContext act = ActionContext.getContext();
		act.put("updateC",c);
		return "go_Update";
	}
	
	public String updateCategory(){
		c = new Category();
		c.setName(categoryName);
		c.setCreateTime(System.currentTimeMillis());
		cService.saveOrUpdate(c);
		message = "更新成功";
		return "update_success";
	}
	
	
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}
	
}
