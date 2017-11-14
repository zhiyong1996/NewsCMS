package com.zzy.action;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.News;
import com.zzy.service.NewsService;

@SuppressWarnings("serial")
public class NewsAction extends ActionSupport{
	@Resource NewsService newsService;
	//从客户端接受的数据
	private String title;	//新闻标题
	private String content;	//新闻内容
	private String newsfrom; //新闻来源
	private Integer newsid; //新闻id
	//公共参数
	private int page;//分页查询当前页
	private int limit;//每页最大项目数
	private long createTime; //更新操作参数
	//服务器端数据
	private String status = "success";
	private List<News> newsSet;//新闻列表
	private News news;
	private String message;
	private JSONObject pageJson;//返回的json数据
	
	//添加新闻
	public String addNews() throws Exception{
		news = new News();
		news.setTitle(title);
		news.setContent(content);
		news.setNewsfrom(newsfrom);
		long createTime = System.currentTimeMillis();
		news.setCreateTime(createTime);
		news.setUpdateTime(createTime);
		newsService.save(news);
		message = "新闻添加成功";
		return "addnews";
	}
	//定向到更新新闻页面
	public String goUpdate(){
		news = newsService.getById(newsid);
		ActionContext act = ActionContext.getContext();
		act.put("update", news);
		return "go_update";
	}
	//更新新闻操作
	public String updateNews(){
		news = new News();
		news.setId(newsid);
		news.setTitle(title);
		news.setContent(content);
		news.setNewsfrom(newsfrom);
		long updateTime = System.currentTimeMillis();
		news.setCreateTime(this.createTime);
		news.setUpdateTime(updateTime);
		newsService.saveOrUpdate(news);
		message = "新闻更新成功";
		return "update_success";
	}
	
	/*获取新闻列表
	 * @param count 记录总数
	 * @param offset 每页首条记录的索引
	 * @newsSet 新闻集合
	**/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String listNews(){
		String hql = "from News";
		int count = newsService.getCount(hql);
		int offset = (page-1)*limit;
		newsSet = (List<News>)newsService.pageNews(hql,offset,limit);
		SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		pageJson = new JSONObject();
		ArrayList arrData = new ArrayList();
		JSONObject data;
		for(News ns:newsSet){
			if(ns.getId() != null){
				data = new JSONObject();
				data.put("id",ns.getId());
				data.put("title", ns.getTitle());
				data.put("newsfrom",ns.getNewsfrom());
				data.put("createTime",dateformat.format(ns.getCreateTime()));
				data.put("updateTime",dateformat.format(ns.getUpdateTime()));
				arrData.add(data);
			}else{
				System.out.println("查询数据失败");
			}
		}
		message = "";
		pageJson.put("code", 0);
		pageJson.put("msg", message);
		pageJson.put("count", count);
		pageJson.put("data", arrData);
		//System.out.println("pageJson"+pageJson.toString());
		return "pageJson";
	}
	//删除新闻
	public String delNews(){
		news = (News)newsService.getById(newsid);
		newsService.delNews(news);
		message = "新闻删除成功";
		return "delNews";
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
	public Integer getNewsid() {
		return newsid;
	}
	public void setNewsid(Integer newsid) {
		this.newsid = newsid;
	}

	public String getResult(){
		return status;
	}
	public List<News> getNewsSet() {
		return newsSet;
	}
	public void setNewsSet(List<News> newsSet) {
		this.newsSet = newsSet;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public JSONObject getPageJson() {
		return pageJson;
	}
	public long getCreateTime() {
		return createTime;
	}
	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}
	
	
}
