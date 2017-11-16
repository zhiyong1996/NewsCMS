package com.zzy.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.Category;
import com.zzy.po.News;
import com.zzy.service.CategoryService;
import com.zzy.service.NewsService;

@SuppressWarnings("serial")
public class CategoryAction extends ActionSupport{
	@Resource NewsService newsService;
	@Resource CategoryService cService;
	private Integer cid;
	private String categoryName;
	private long createTime;
	private int limit;
	private int page;
	
	private JSONObject pageC;
	private List<Category> cSet;
	private Category c;
	private String message;
	
	public String go_addC(){
		return "addCView";
	}
	public String go_listC(){
		return "listCView";
	}

	
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
		c.setId(cid);
		c.setName(categoryName);
		c.setCreateTime(createTime);
		cService.saveOrUpdate(c);
		message = "更新成功";
		return "update_success";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String pageCategory(){
		String hql = "from Category";
		int count = newsService.getCount(hql);
		int offset = (page-1)*limit;
		cSet = (List<Category>)cService.pageCategory(hql,offset,limit);
		SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		pageC = new JSONObject();
		ArrayList arrData = new ArrayList();
		JSONObject data;
		for(Category c:cSet){
			if(c.getId() != null){
				data = new JSONObject();
				data.put("cid",c.getId());
				data.put("cName", c.getName());
				data.put("createTime",dateformat.format(c.getCreateTime()));
				arrData.add(data);
				System.out.println(c.getId());
			}else{
				System.out.println("查询数据失败");
			}
		}
		message = "";
		pageC.put("code", 0);
		pageC.put("msg", message);
		pageC.put("count", count);
		pageC.put("data", arrData);
		System.out.println("pageC"+pageC.toString());
		return "pageC";
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

	public JSONObject getPageC() {
		return pageC;
	}

	public void setPageC(JSONObject pageC) {
		this.pageC = pageC;
	}

	public List<Category> getcSet() {
		return cSet;
	}

	public void setcSet(List<Category> cSet) {
		this.cSet = cSet;
	}
	
}
