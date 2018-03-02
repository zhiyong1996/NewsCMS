package com.zzy.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.Category;
import com.zzy.po.Comment;
import com.zzy.po.News;
import com.zzy.po.ReportMessage;
import com.zzy.po.User;
import com.zzy.service.CategoryService;
import com.zzy.service.CommentService;
import com.zzy.service.NewsService;
import com.zzy.service.ReportService;
import com.zzy.service.UserService;

@SuppressWarnings("serial")
public class UserAction extends ActionSupport{
	@Resource NewsService nService;
	@Resource CategoryService cService;
	@Resource UserService uService;
	@Resource CommentService comService;
	@Resource ReportService rmsgService;
	
	//服务器返回客户端数据
	private List<News> search_news;
	private int size;
	private List<News> ca_news ;
	private List<News> hot_news ;
	private List<Category> clist;
	private News news ;
	private String createId;
	private JSONObject json; //通用json
	private JSONObject com_json; //添加评论json
	private List<Comment> news_com_json;
	private Map<String ,Object> session;
	private Map<String ,Object> comNews;
	private String flag;
	private int comment_count;
	private User user;
	private String avatar_path;

	//服务器接受客户端参数
	private String createTime;
	private String username;
	private String password;
	private String headline;
	private String email;
	private Integer sex;
	private Integer uid;
	private String name;
	
	//举报信息
	private String content;
	private String addition;
	private Integer comid;
	
	private String keyword;
	//评论
	private String comment;
	private Integer newsId;
	private Integer userId;
	
	public String loading_news(){
		
		ActionContext cx = ActionContext.getContext();
		List<News> ca_n = nService.getByType(StaticParam.CA_NEWS);
		List<News> hot_n = nService.getByType(StaticParam.HOT_NEWS);
		int ca_size = ca_n.size()>=5? StaticParam.CA_NEWS_MAX:ca_n.size();//判断获取到的新闻数量是否大于5，大于5则限定为5
		int hot_size = hot_n.size()>=5? StaticParam.HOT_NEWS_MAX:hot_n.size();//判断获取到的新闻数量是否大于5，大于5则限定为5
		
		ca_news = new ArrayList<News>();//初始化一个list对象存放新闻
		hot_news = new ArrayList<News>();//初始化一个list对象存放新闻
		
		for(int i=0;i<ca_size;i++){
			ca_news.add(ca_n.get(i));
			//System.out.println("Ca-News:"+ca_n.get(i).getTitle()+";");
		}
		for(int i=0;i<hot_size;i++){
			hot_news.add(hot_n.get(i));
			//System.out.println("Hot-News:"+hot_n.get(i).getTitle()+";");
		}
		cx.put("ca_news", ca_news);
		cx.put("hot_news", hot_news);
		flag = "true";
		clist = cService.allCategory();
		comNews = new HashMap<String,Object>();
		for(Category c : clist){ //遍历新闻类别,循环获取该分类下的新闻
			Set<News> ns = c.getNewss();
			if(ns.size()>0){
				TreeSet<News> tn = new TreeSet<News>();//对set集合进行排序
				tn.addAll(ns);			
				int size = tn.size()>=StaticParam.CA_NEWS_MAX? StaticParam.CA_NEWS_MAX:tn.size();//限定集合大小
				System.out.println(c.getName()+"新闻有"+size);
				int sum = 0;   //需要获取前5个新闻对象,设定一个标志
				Iterator<News> it = tn.iterator();
				List<News> n = new ArrayList<News>();
				while(it.hasNext()){
					if(sum<=size){
						News single = it.next();
						if(single.getNewstype()==StaticParam.COMMON_NEWS){
						  n.add(single);
						}
					}else{
						break;
					}
				}
				if(n.size()>0){
					comNews.put(c.getName(), n);
				}
			}
		}
		return "loading_news";
	}

	public String detail_news(){
		news = nService.getByCreateId(createId);
		comment_count = news.getComments().size();
		createTime = StaticParam.DateFormat2.format(news.getCreateTime());
		return "detail_suc";
	}
	
	public String user_login(){
		User user = uService.getByUsername(username);
		
		json = new JSONObject();
		if(!(user == null)){
			user.setLastlogin(StaticParam.DateFormat2.format(new Date()));
			uService.saveOrUpdate(user);
			if(user.getPassword().equals(password)){
				session = ActionContext.getContext().getSession();
				session.put("username", username);
				session.put("user", user);
				json.put("code", 0);
				json.put("tip", "匹配成功");
			}else{
				json.put("code", 1);
				json.put("tip", "密码错误");
			}
		}else{
			json.put("code", 1);
			json.put("tip", "用户不存在");
		}
		return "u_login";
	}
	
	public String user_quit(){
		json = new JSONObject();
		json.put("code", 0);
		session = ActionContext.getContext().getSession();
		session.remove("user");
		return "u_quit";
	}
	
	public String search_news(){
		search_news = nService.getByTitle(keyword);
		System.out.println(keyword);
		size = search_news.size();
		return "user_search";
	}
	
	public String add_com(){
		News n = nService.getById(newsId);
		User u = uService.getUserById(userId);
		System.out.println(comment+"|"+userId+"|"+newsId+"|"+u);
		long tamp = System.currentTimeMillis();
		String time = StaticParam.DateFormat2.format(tamp);
		Comment c = new Comment();
		c.setContent(comment);
		c.setNews(n);
		c.setUser(u);
		c.setShowed(true);
		c.setCreateTime(tamp);
		c.setCreateTimeS(time);
		Integer comId = comService.save(c);
		com_json = new JSONObject();
		com_json.put("code", 0);
		com_json.put("msg", "评论成功");
		com_json.put("commentId",comId);
		return "add_com";
	}
	
	public String get_news_com(){
		news = nService.getByCreateId(createId);
		TreeSet<Comment> ts = new TreeSet<Comment>();
		ts.addAll(news.getComments());
		//Set<Comment> coms = news.getComments();
		news_com_json = new ArrayList<Comment>();
		for(Comment c : ts){
			if(c.getShowed()){
				news_com_json.add(c);
			}
			System.out.println(StaticParam.DateFormat2.format(c.getCreateTime()));
		}
		return "get_n_c";
	}
		
	public String user_info_page(){
		user = uService.getByUsername(username);
		avatar_path = user.getAvatar()==null? "" : user.getAvatar().getPath();
		return "user_info_page";
	}

	public String update_user_info(){
		user = uService.getUserById(uid);
		if(name.equals("")==false){
			user.setName(name);
		}
		System.out.println(user+name+headline+email+sex);
		user.setEmail(email);
		user.setHeadline(headline);
		user.setSex(sex);
		uService.saveOrUpdate(user);
		System.out.println("更新用户资料成功");
		json = new JSONObject();
		json.put("status", true);
		json.put("sex", sex);
		json.put("name", name);
		json.put("email",email);
		json.put("headline",headline);
		
		return "update_user_info";
	}
	
	public String submit_report(){
		System.out.println(uid+comid+content);
		User user = uService.getUserById(uid);
		Comment comment = comService.getById(comid);
		ReportMessage rsg = new ReportMessage();
		long ct = System.currentTimeMillis();
		//设置基本信息
		rsg.setAddition(addition);
		rsg.setChecked(false);
		rsg.setHandled(false);
		rsg.setHandle_result("未处理");
		rsg.setContent(content);
		rsg.setCreateTime(ct);
		rsg.setCreateTimeS(StaticParam.DateFormat2.format(ct));
		//设置关联
		rsg.setComment(comment);		
		rsg.setReporter(user);
		
		Integer rs = rmsgService.save(rsg);
		json = new JSONObject();
		if(rs>0){
			json.put("code", 0);
			json.put("msg", "举报成功");
		}else{
			json.put("msg", "举报失败，稍后尝试");
		}
		return "submit_report";
	}
	
	public List<News> getCa_news() {
		return ca_news;
	}
	public void setCa_news(List<News> ca_news) {
		this.ca_news = ca_news;
	}
	public List<News> getHot_news() {
		return hot_news;
	}
	public void setHot_news(List<News> hot_news) {
		this.hot_news = hot_news;
	}

	public String getCreateId() {
		return createId;
	}

	public void setCreateId(String createId) {
		this.createId = createId;
	}

	public News getNews() {
		return news;
	}

	public void setNews(News news) {
		this.news = news;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public JSONObject getJson() {
		return json;
	}

	public void setJson(JSONObject json) {
		this.json = json;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public List<Category> getClist() {
		return clist;
	}

	public void setClist(List<Category> clist) {
		this.clist = clist;
	}

	public List<News> getSearch_news() {
		return search_news;
	}

	public void setSearchNews(List<News> search_news) {
		this.search_news = search_news;
	}
	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public JSONObject getCom_json() {
		return com_json;
	}

	public void setCom_json(JSONObject com_json) {
		this.com_json = com_json;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Integer getNewsId() {
		return newsId;
	}

	public void setNewsId(Integer newsId) {
		this.newsId = newsId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public List<Comment> getNews_com_json() {
		return news_com_json;
	}

	public void setNews_com_json(List<Comment> news_com_json) {
		this.news_com_json = news_com_json;
	}

	public int getComment_count() {
		return comment_count;
	}

	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}

	public Map<String, Object> getComNews() {
		return comNews;
	}

	public void setComNews(Map<String, Object> comNews) {
		this.comNews = comNews;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public String getHeadline() {
		return headline;
	}

	public void setHeadline(String headline) {
		this.headline = headline;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatar_path() {
		return avatar_path;
	}

	public void setAvatar_path(String avatar_path) {
		this.avatar_path = avatar_path;
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

	public Integer getComid() {
		return comid;
	}

	public void setComid(Integer comid) {
		this.comid = comid;
	}

	
	
}
