package com.zzy.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import javax.annotation.Resource;
import net.sf.json.JSONObject;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.imgUtil.ImgUtil;
import com.zzy.po.CaImg;
import com.zzy.po.Category;
import com.zzy.po.Comment;
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
	private String netList ; //网络图片路径，以字符串拼接的形式传递
	private Integer newstype; // 位置码,用于区分新闻所属位置
	private String caSrc;
	private String nids ;  //批量操作 id数组
	
	//新闻管理表格重载接收参数
	private String reloadkey;  //关键字
	private String reloadvalue; //关键值

	// 公共参数
	private int page;// 分页查询当前页
	private int limit;// 每页最大项目数
	private long createTime; // 更新操作参数

	// 服务器端数据
	private TreeSet<Comment> comSet ;  //评论集合
	private List<News> newsSet;// 新闻列表
	private News news; // 新闻对象
	private CaImg ci; //  轮播图像
	private String message; // 待用信息
	private JSONObject pageJson;// 返回的json数据
	private Map<Integer, Object> category; // 更新/添加新闻时查询的分类Map格式数据
	private Map<Integer, Object> newsposition; // 更新/添加新闻时查询的位置类型Map格式数据
	private Map<String, String> backnews = new HashMap<String, String>(); // 返回的新闻对象
	private List<Comment> commentList;
	private int commentSize;

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
			category.put(c.getId(), c.getName());
		}
		if (newstype == StaticParam.CA_NEWS) {
			return "go_add_ca";
		} else if (newstype == StaticParam.HOT_NEWS) {
			return "go_add_hot";
		} else if (newstype == StaticParam.COMMON_NEWS) {
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
		news.setCreateTimeS(StaticParam.DateFormat3.format(createTime));
		news.setUpdateTimeS(StaticParam.DateFormat3.format(createTime));
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
					ni.setSource("local");

					imgService.saveOrUpdate(ni);
				}
			}
		}
		if(!netList.equals("")&&!(netList==null)){
			String[] netList = this.netList.split(",");
			for(int i=0;i<netList.length;i++){
				System.out.println(netList[i]);
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
		//获取新闻分离作查询
		category = new HashMap<Integer, Object>();
		List<Category> allC = cService.allCategory();
		System.out.println(allC.size());
		for (Category c : allC) {
			category.put(c.getId(), c.getName());
		}
		
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
		if(nt == StaticParam.COMMON_NEWS){
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
		news.setUpdateTimeS(StaticParam.DateFormat3.format(updateTime));

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
		if(!netList.equals("")&&!(netList==null)){
			String[] netList = this.netList.split(",");
			for(int i=0;i<netList.length;i++){
				System.out.println(netList[i]);
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

	/* 获取新闻列表
	 * @param count 记录总数
	 * @param offset 每页首条记录的索引
	 * @newsSet 新闻集合
	 */
	@SuppressWarnings({})
	public String list_news() {	
		//计算值初始索引
		int offset = (page - 1) * limit;
		int count = 0;
		//ajax 获取新闻内容
		
		if((reloadkey==null||reloadkey.equals(""))){
			
			//如果重载key为空则为获取所有的新闻
			String sql = "SELECT * FROM news ORDER BY createTime DESC";
			newsSet = newsService.listBySQL(sql, offset, limit);
			String hql = "from News";
			count = newsService.getCount(hql);
			
		}else if(reloadkey.equals("category")){
			System.out.println(reloadkey+":"+reloadvalue);
			//如果重载key为category则为根据新闻类型获取新闻
			String sql = "SELECT * FROM news where category_id = "+reloadvalue+" ORDER BY createTime DESC";
			newsSet = newsService.listBySQL(sql, offset, limit);
			count = newsSet.size();
			
		}else if(reloadkey.equals("newsposition")){
			System.out.println(reloadkey+":"+reloadvalue);
			//如果重载key为newsposition则为根据新闻位置获取新闻
			String sql = "SELECT * FROM news where newstype = "+reloadvalue+" ORDER BY createTime DESC";
			newsSet = newsService.listBySQL(sql, offset, limit);
			count = newsSet.size();
			
		}else if(reloadkey.equals("title")){
			System.out.println(reloadkey+":"+reloadvalue);
			//如果重载key为title则为根据新闻标题模糊查询
			newsSet = newsService.getByTitle(reloadvalue);
			count = newsSet.size();
		}
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
				data.put("commentSize", ns.getComments().size());
				data.put("issue", ns.getIssue());
				data.put("createTime", StaticParam.DateFormat3.format(ns.getCreateTime()));
				data.put("updateTime", StaticParam.DateFormat3.format(ns.getUpdateTime()));
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
		backnews.put("createTime", StaticParam.DateFormat3.format(news.getCreateTime()));
		backnews.put("newsfrom", news.getNewsfrom());
		backnews.put("content", news.getContent());
		ActionContext act = ActionContext.getContext();
		act.put("preview", backnews);
		
		return "news_preview";
	}
	
	//查看新闻评论
	public String news_comment(){
		news = newsService.getById(newsid);
		TreeSet<Comment> ts = new TreeSet<Comment>();
		ts.addAll(news.getComments());
		commentSize = ts.size();
		commentList = new ArrayList<Comment>();
		for(Comment c:ts){
			commentList.add(c);
		}
		return "news_comment";
	}
	
	//根据分类查询新闻
	public String list_by_cate(){
		String hql = "SELECT * FROM news where category_id = "+cid;
		System.out.println(hql);
		int offset = (page - 1) * limit;
		newsSet = (List<News>) newsService.listBySQL(hql, offset, limit);
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
				data.put("createTime", StaticParam.DateFormat3.format(ns.getCreateTime()));
				data.put("updateTime", StaticParam.DateFormat3.format(ns.getUpdateTime()));
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
		return "list_by_cate";
	}

	//批量更新发布状态
	public String batch_handle(){
		System.out.println("nids:"+nids);
		String idArr[] = nids.split(",");
		for(int i=0;i<idArr.length;i++){	
			News n = newsService.getById(Integer.parseInt(idArr[i]));
			System.out.println(n);
			n.setIssue(issue);
			newsService.saveOrUpdate(n);
		}
		message = idArr.length+"条记录操作成功";
		return "batch_handle";
	}
	//批量删除
		public String batch_del(){
			System.out.println("nids:"+nids);
			String idArr[] = nids.split(",");
			for(int i=0;i<idArr.length;i++){	
				News n = newsService.getById(Integer.parseInt(idArr[i]));
				newsService.delNews(n);
			}
			message = idArr.length+"条记录操作成功";
			return "batch_del";
		}
	
	//ajax
	
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
	

	public String getReloadkey() {
		return reloadkey;
	}

	public void setReloadkey(String reloadkey) {
		this.reloadkey = reloadkey;
	}

	public String getReloadvalue() {
		return reloadvalue;
	}

	public void setReloadvalue(String reloadvalue) {
		this.reloadvalue = reloadvalue;
	}

	public String getNids() {
		return nids;
	}

	public void setNids(String nids) {
		this.nids = nids;
	}

	public Map<Integer, Object> getNewsposition() {
		return newsposition;
	}

	public void setNewsposition(Map<Integer, Object> newsposition) {
		this.newsposition = newsposition;
	}

	public String getNetList() {
		return netList;
	}

	public void setNetList(String netList) {
		this.netList = netList;
	}

	public TreeSet<Comment> getComSet() {
		return comSet;
	}

	public void setComSet(TreeSet<Comment> comSet) {
		this.comSet = comSet;
	}

	public List<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}

	public int getCommentSize() {
		return commentSize;
	}

	public void setCommentSize(int commentSize) {
		this.commentSize = commentSize;
	}

	public News getNews() {
		return news;
	}

	public void setNews(News news) {
		this.news = news;
	}
	
}
