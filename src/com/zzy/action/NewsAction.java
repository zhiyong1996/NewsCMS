package com.zzy.action;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.imgUtil.ImgUtil;
import com.zzy.po.Category;
import com.zzy.po.News;
import com.zzy.service.CategoryService;
import com.zzy.service.NewsService;

@SuppressWarnings("serial")
public class NewsAction extends ActionSupport{
	@Resource CategoryService cService;
	@Resource NewsService newsService;
	
	//日期格式化
	private static SimpleDateFormat DateFormat1 = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	private static SimpleDateFormat DateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//从客户端接受的数据
	private String title;	 //新闻标题
	private String content;	 //新闻内容
	private String newsfrom; //新闻来源
	private Integer newsid;  //新闻id
	private Integer cid;     //分类id
	private String createId; // 创建空白新闻区分字段
	private Boolean issue;    //是否展示
	private String pathList ; //新闻内容图片路径，以字符串拼接的形式传递
	
	//公共参数
	private int page;//分页查询当前页
	private int limit;//每页最大项目数
	private long createTime; //更新操作参数
	
	//服务器端数据
	private String status = "success";
	private List<News> newsSet;//新闻列表
	private News news;         //新闻对象
	private String message;    //待用信息
	private JSONObject pageJson;//返回的json数据
	private Map<Integer,Object> category;  //更新/添加新闻时查询的分类Map格式数据
	private Map<String, String> backnews  = new HashMap<String,String>();       //返回的新闻对象
	
	public String go_index(){
		return "index";
	}
	
	public String go_addN(){
		category = new HashMap<Integer, Object>();
		List<Category> allC = cService.allCategory();
		for(Category c:allC){
			if(c.getId() ==1 ){
				continue;
			}else{
				category.put(c.getId(), c.getName());
			}
		}
		//创建空白新闻
		news = new News();
		String createId = DateFormat1.format(new Date()).toString();
		news.setCreateId(createId);
		news.setTitle("NewTitle");
		news.setContent("");
		news.setNewsfrom("New");
		news.setCategory(cService.getById(1));
		news.setIssue(false);
		long createTime = System.currentTimeMillis();
		news.setCreateTime(createTime);
		news.setUpdateTime(createTime);
		newsService.save(news);
		
		ActionContext act = ActionContext.getContext();
		
		act.put("update", news);
		
		return "go_update";
		
	}
	public String go_listN(){
		return "listNView";
	}

	//定向到更新新闻页面
	public String goUpdate(){
		category = new HashMap<Integer, Object>();
		List<Category> allC = cService.allCategory();
		for(Category c:allC){
			category.put(c.getId(), c.getName());
		}
		news = newsService.getById(newsid);
		ActionContext act = ActionContext.getContext();
		act.put("update", news);
		return "go_update";
	}
	//更新新闻操作
	public String updateNews(){
		if(!pathList.equals("")){
			String[] imgList = pathList.split(",");           //暂存图片路径数组
			System.out.println("*******"+imgList[0]);
			String[] targetArr = new String[imgList.length];  //新图片路径数组
			String fileName;
			String new_src ;
			
			for(int i=0;i<imgList.length;i++){

				fileName = imgList[i].substring(imgList[i].lastIndexOf("/")+1);
				new_src = ImgUtil.moveFile(newsid, imgList[i], fileName);
				targetArr[i] = new_src;
			}
			
			for(int i=0;i<targetArr.length;i++){
				if(!targetArr[i].equals("")){
					 System.out.println(targetArr[i]);
					content.replace(imgList[i], targetArr[i]);}
			}
		}
		
		news = newsService.getById(newsid);
		news.setTitle(title);
		news.setContent(content);
		news.setNewsfrom(newsfrom);
		news.setCategory(cService.getById(cid));
		long updateTime = System.currentTimeMillis();
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
	@SuppressWarnings({ })
	public String listNews(){
		String hql = "from News";
		int count = newsService.getCount(hql);
		int offset = (page-1)*limit;
		newsSet = (List<News>)newsService.pageNews(hql,offset,limit);
		SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		pageJson = new JSONObject();
		ArrayList<JSONObject> arrData = new ArrayList<JSONObject>();
		JSONObject data;
		for(News ns:newsSet){
			//System.out.println(ns.getCategory().getName());
			if(ns.getId() != null){
				data = new JSONObject();
				data.put("id",ns.getId());
				data.put("createid",ns.getCreateId());
				data.put("title", ns.getTitle());
				data.put("newsfrom",ns.getNewsfrom());
				data.put("category", ns.getCategory().getName());
				data.put("issue", ns.getIssue());
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
	//更新发布(issue)状态
	public String issueN(){
		news = (News)newsService.getById(newsid);
		news.setIssue(issue);
		newsService.saveOrUpdate(news);
		return "issue_success";
	}
	
	//预览新闻
	public String newsPreview(){
		news = (News)newsService.getById(newsid);

		backnews.put("title", news.getTitle());
		backnews.put("createTime",DateFormat2.format(news.getCreateTime()));
		backnews.put("newsfrom", news.getNewsfrom());
		backnews.put("content", news.getContent());
		
		ActionContext act = ActionContext.getContext();
		act.put("preview", backnews);
		return "preview";
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
	public Map<Integer, Object> getCategory() {
		return category;
	}
	public void setCategory(Map<Integer, Object> category) {
		this.category = category;
	}
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public String getCreateId() {
		return createId;
	}

	public void setCreateId(String createId) {
		this.createId = createId;
	}

	public Boolean getIssue() {
		return issue;
	}

	public void setIssue(Boolean issue) {
		this.issue = issue;
	}

	public Map<String, String> getBacknews() {
		return backnews;
	}

	public void setBacknews(Map<String, String> backnews) {
		this.backnews = backnews;
	}

	public String getPathList() {
		return pathList;
	}

	public void setPathList(String pathList) {
		this.pathList = pathList;
	}
	
	
}
