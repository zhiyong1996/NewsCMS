package com.zzy.action;

import java.io.IOException;
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
import com.zzy.po.CaImg;
import com.zzy.po.Category;
import com.zzy.po.News;
import com.zzy.po.NewsImg;
import com.zzy.service.CaImgService;
import com.zzy.service.CategoryService;
import com.zzy.service.ImageService;
import com.zzy.service.NewsService;

@SuppressWarnings("serial")
public class NewsAction extends ActionSupport {
	@Resource CategoryService cService;
	@Resource NewsService newsService;
	@Resource ImageService imgService;
	@Resource CaImgService caService;

	// 从客户端接受的数据
	private String title; // 新闻标题
	private String content; // 新闻内容
	private String newsfrom; // 新闻来源
	private Integer newsid; // 新闻id
	private Integer cid; // 分类id
	private String createId; // 创建空白新闻区分字段
	private Boolean issue; // 是否展示
	private String pathList; // 本地上传的图片路径，以字符串拼接的形式传递
	// private String allpath ; //所有图片路径，以字符串拼接的形式传递
	private Integer newstype; // 位置码,用于区分新闻所属位置
	private String caSrc;

	// 公共参数
	private int page;// 分页查询当前页
	private int limit;// 每页最大项目数
	private long createTime; // 更新操作参数

	// 服务器端数据
	private String status = "success";
	private List<News> newsSet;// 新闻列表
	private News news; // 新闻对象
	private CaImg ci; //  轮播图像
	private String message; // 待用信息
	private JSONObject pageJson;// 返回的json数据
	private Map<Integer, Object> category; // 更新/添加新闻时查询的分类Map格式数据
	private Map<String, String> backnews = new HashMap<String, String>(); // 返回的新闻对象

	public String go_index() {
		return "index";
	}

	public String select_news() {
		return "select_news";
	}

	public String go_add_news() {
		category = new HashMap<Integer, Object>();
		List<Category> allC = cService.allCategory();
		for (Category c : allC) {
			if (c.getId() == 1) {
				continue;
			} else {
				category.put(c.getId(), c.getName());
			}
		}
		if (newstype == StaticParam.CA_NEWS) {
			return "go_add_ca";
		} else if (newstype == StaticParam.HOT_NEWS) {
			return "go_add_hot";
		} else if (newstype == StaticParam.COMMENT_NEWS) {
			return "go_add_com";
		} else {
			return "select_news";
		}
	}

	public String add_news() throws Exception {
		news = new News();
		String createId = StaticParam.DateFormat1.format(new Date()).toString();
		news.setCreateId(createId);
		news.setTitle(title);
		news.setContent(content);
		news.setNewsfrom(newsfrom);
		news.setCategory(cService.getById(cid));
		news.setIssue(false);
		long createTime = System.currentTimeMillis();
		news.setCreateTime(createTime);
		news.setUpdateTime(createTime);
		news.setNewstype(newstype);
		Integer nid = newsService.save(news);
		
		//移动新闻内容里面的图片
		if (!pathList.equals("")) {

			String[] imgList = pathList.split(","); // 旧的图片路径由客户端传递字符串切割
			String[] targetArr = new String[imgList.length];
			String fileName;
			String new_src;

			for (int i = 0; i < imgList.length; i++) { // 循环遍历旧的图片路径,对图片进行移动

				fileName = imgList[i].substring(imgList[i].lastIndexOf("/") + 1);// 通过字符串截取文件名
				new_src = ImgUtil.moveFile(nid, imgList[i], fileName); // 调用静态类方法移动文件，如果文件已存在则返回空字符串，否则返回新路径
				targetArr[i] = new_src;
				if (!targetArr[i].equals("")) { // 如果新路径不为空,则为新的图片,新建图片对象保存数据库。
					setContent(getContent().replace(imgList[i], targetArr[i]));// 循环将图片引用替换成新路径
					imgList[i] = targetArr[i]; // 同时更新路径到旧数组

					NewsImg ni = new NewsImg();
					ni.setName(fileName);
					ni.setPath(imgList[i]);
					ni.setNews(news);

					imgService.saveOrUpdate(ni);
				}
			}
		}
		//移动轮播图片
		if(newstype == StaticParam.CA_NEWS){
			String fileName = caSrc.substring(caSrc.lastIndexOf("/")+1);
			String new_src = ImgUtil.moveFile(nid, caSrc, fileName);
			caSrc = new_src;
			ci = new CaImg();
			ci.setImgName(fileName);
			ci.setPath(new_src);
			ci.setNews(newsService.getById(nid));
			caService.save(ci);
			news.setCaimg(ci);
			newsService.saveOrUpdate(news);
		}
		
		return "add_news_suc";

	}

	public String go_list_news() {
		return "list_news";
	}

	// 定向到更新新闻页面
	public String go_update() {
		category = new HashMap<Integer, Object>();
		List<Category> allC = cService.allCategory();
		for (Category c : allC) {
			category.put(c.getId(), c.getName());
		}
		news = newsService.getById(newsid);
		ActionContext act = ActionContext.getContext();
		act.put("update", news);
		Integer nt = news.getNewstype();
		if(nt == StaticParam.COMMENT_NEWS){
			return "go_update_com";
		}else if(nt == StaticParam.CA_NEWS){//如果是轮播新闻单独获取轮播图片
			String caSrc = news.getCaimg().getPath();
			act.put("caSrc", caSrc);
			return "go_update_ca";
		}else{
			return "go_update_hot";
		}
	}

	// 更新新闻操作
	public String update_news() throws IOException {

		news = newsService.getById(newsid);
		news.setTitle(title);
		news.setNewsfrom(newsfrom);
		news.setCategory(cService.getById(cid));
		long updateTime = System.currentTimeMillis();
		news.setUpdateTime(updateTime);

		if (!pathList.equals("")) {

			String[] imgList = pathList.split(","); // 旧的图片路径由客户端传递字符串切割
			String[] targetArr = new String[imgList.length];
			String fileName;
			String new_src;

			for (int i = 0; i < imgList.length; i++) { // 循环遍历旧的图片路径,对图片进行移动

				fileName = imgList[i].substring(imgList[i].lastIndexOf("/") + 1);// 通过字符串截取文件名
				new_src = ImgUtil.moveFile(newsid, imgList[i], fileName); // 调用静态类方法移动文件，如果文件已存在则返回空字符串，否则返回新路径
				targetArr[i] = new_src;
				if (!targetArr[i].equals("")) { // 如果新路径不为空,则为新的图片,新建图片对象保存数据库。
					setContent(getContent().replace(imgList[i], targetArr[i]));// 循环将图片引用替换成新路径
					imgList[i] = targetArr[i]; // 同时更新路径到旧数组

					NewsImg ni = new NewsImg();
					ni.setName(fileName);
					ni.setPath(imgList[i]);
					ni.setNews(news);

					imgService.saveOrUpdate(ni);
				}
			}
		}
		
		//移动轮播图片
		if(newstype == StaticParam.CA_NEWS){
			String fileName = caSrc.substring(caSrc.lastIndexOf("/")+1);
			String new_src = ImgUtil.moveFile(newsid, caSrc, fileName);
			if(new_src.equals("")){   //如果返回的新链接为空，则表示图片已经存在,则caimg的path数据不需要变化
				new_src = caSrc;
			}
			ci = news.getCaimg();
			ci.setImgName(fileName);
			ci.setPath(new_src);
			caService.saveOrUpdate(ci);
			news.setCaimg(ci);
			newsService.saveOrUpdate(news);
		}
		news.setContent(content);
		newsService.saveOrUpdate(news);

		message = "新闻更新成功";
		return "update_success";
	}

	/*
	 * 获取新闻列表
	 * 
	 * @param count 记录总数
	 * 
	 * @param offset 每页首条记录的索引
	 * 
	 * @newsSet 新闻集合
	 */
	@SuppressWarnings({})
	public String list_news() {
		String hql = "from News";
		int count = newsService.getCount(hql);
		int offset = (page - 1) * limit;
		newsSet = (List<News>) newsService.pageNews(hql, offset, limit);
		pageJson = new JSONObject();
		ArrayList<JSONObject> arrData = new ArrayList<JSONObject>();
		JSONObject data;
		for (News ns : newsSet) {
			// System.out.println(ns.getCategory().getName());
			if (ns.getId() != null) {
				data = new JSONObject();
				data.put("id", ns.getId());
				data.put("createid", ns.getCreateId());
				data.put("title", ns.getTitle());
				data.put("newsfrom", ns.getNewsfrom());
				data.put("newstype", StaticParam.getPositionType(ns.getNewstype()));
				data.put("category", ns.getCategory().getName());
				data.put("issue", ns.getIssue());
				data.put("createTime", StaticParam.DateFormat2.format(ns.getCreateTime()));
				data.put("updateTime", StaticParam.DateFormat2.format(ns.getUpdateTime()));
				arrData.add(data);
			} else {
				System.out.println("查询数据失败");
			}
		}
		message = "";
		pageJson.put("code", 0);
		pageJson.put("msg", message);
		pageJson.put("count", count);
		pageJson.put("data", arrData);
		// System.out.println("pageJson"+pageJson.toString());
		return "page_json";
	}

	// 删除新闻
	public String del_news() {
		news = (News) newsService.getById(newsid);
		newsService.delNews(news);
		message = "新闻删除成功";
		return "del_news";
	}

	// 更新发布(issue)状态
	public String issue_news() {
		news = (News) newsService.getById(newsid);
		news.setIssue(issue);
		newsService.saveOrUpdate(news);
		return "issue_success";
	}

	// 预览新闻
	public String news_preview() {
		news = (News) newsService.getById(newsid);

		backnews.put("title", news.getTitle());
		backnews.put("createTime", StaticParam.DateFormat2.format(news.getCreateTime()));
		backnews.put("newsfrom", news.getNewsfrom());
		backnews.put("content", news.getContent());

		ActionContext act = ActionContext.getContext();
		act.put("preview", backnews);
		
		return "news_preview";
	}
	
	//根据分类查询新闻
	public String list_news_cate(){
		String hql = "from News n where n.category_id = ?";
		
		int offset = (page - 1) * limit;
		newsSet = (List<News>) newsService.listByCategory(hql, offset, offset, cid);
		int count = newsSet.size();
		pageJson = new JSONObject();
		ArrayList<JSONObject> arrData = new ArrayList<JSONObject>();
		JSONObject data;
		for (News ns : newsSet) {
			// System.out.println(ns.getCategory().getName());
			if (ns.getId() != null) {
				data = new JSONObject();
				data.put("id", ns.getId());
				data.put("createid", ns.getCreateId());
				data.put("title", ns.getTitle());
				data.put("newsfrom", ns.getNewsfrom());
				data.put("newstype", StaticParam.getPositionType(ns.getNewstype()));
				data.put("category", ns.getCategory().getName());
				data.put("issue", ns.getIssue());
				data.put("createTime", StaticParam.DateFormat2.format(ns.getCreateTime()));
				data.put("updateTime", StaticParam.DateFormat2.format(ns.getUpdateTime()));
				arrData.add(data);
			} else {
				System.out.println("查询数据失败");
			}
		}
		message = "";
		pageJson.put("code", 0);
		pageJson.put("msg", message);
		pageJson.put("count", count);
		pageJson.put("data", arrData);
		return "";
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

	public String getResult() {
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

	public Integer getNewstype() {
		return newstype;
	}

	public void setNewstype(Integer newstype) {
		this.newstype = newstype;
	}

	public String getCaSrc() {
		return caSrc;
	}

	public void setCaSrc(String caSrc) {
		this.caSrc = caSrc;
	}

	// public String getAllpath() {
	// return allpath;
	// }
	//
	// public void setAllpath(String allpath) {
	// this.allpath = allpath;
	// }
	//

}
