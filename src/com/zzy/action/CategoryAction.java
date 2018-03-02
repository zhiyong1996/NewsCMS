package com.zzy.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.Category;
import com.zzy.service.CategoryService;
import com.zzy.service.NewsService;

@SuppressWarnings("serial")
public class CategoryAction extends ActionSupport{
	@Resource NewsService newsService; //新闻功能
	@Resource CategoryService cService; //分类功能
	private Integer cid; //客户端类型id
	private String categoryName; //类型名字
	private long createTime; //创建时间戳
	private int page;//分页查询当前页
	private int limit;//每页最大项目数
	
	private JSONObject pageC; //返回的json数据
	private List<Category> cSet; //从数据库获取的类型列表
	private Category c; //单个类型对象
	private String message; //返回的message
	
	public String go_listC(){ //路由到类型列表页
		return "listCView";
	}

	public String addCategory(){ //添加类型
		c = new Category();
		c.setName(categoryName);
		long createTime = System.currentTimeMillis();
		c.setCreateTime(createTime);
		c.setUpdateTime(createTime);
		cService.save(c);
		message = "添加成功";
		return "addCategory";
	}
	
	public String delCategory(){  //删除类型
		c = cService.getById(cid);
		cService.delCategory(c);
		message = "删除成功";
		return "delCategory";
	}
	
	public String updateCategory(){  //进行更新类型
		c = cService.getById(cid);
		c.setName(categoryName);
		c.setUpdateTime(System.currentTimeMillis());
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
		System.out.println(cSet.size());
		SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		pageC = new JSONObject();
		ArrayList arrData = new ArrayList();
		JSONObject data;
		for(Category c:cSet){
			data = new JSONObject();
			data.put("cid",c.getId());
			data.put("cName", c.getName());
			data.put("createTime",dateformat.format(c.getCreateTime()));
			data.put("updateTime",dateformat.format(c.getUpdateTime()));
			arrData.add(data);
			System.out.println(c.getId());
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
