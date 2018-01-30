package com.zzy.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.Category;
import com.zzy.po.News;
import com.zzy.po.User;
import com.zzy.service.CategoryService;
import com.zzy.service.NewsService;
import com.zzy.service.UserService;

@SuppressWarnings("serial")
public class UserAction extends ActionSupport{
	@Resource NewsService nService;
	@Resource CategoryService cService;
	@Resource UserService uService;
	
	//服务器返回客户端数据
	private List<News> ca_news ;
	private List<News> hot_news ;
	private List<Category> clist;
	private News news ;
	private String createId;
	private JSONObject json;
	private Map<String ,Object> session;
	private String flag;
	
	//服务器接受客户端参数
	private String createTime;
	private String username;
	private String password;
	
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
			System.out.println("Ca-News:"+ca_n.get(i).getTitle()+";");
		}
		for(int i=0;i<hot_size;i++){
			hot_news.add(hot_n.get(i));
			System.out.println("Hot-News:"+hot_n.get(i).getTitle()+";");
		}
		cx.put("ca_news", ca_news);
		cx.put("hot_news", hot_news);
		flag = "true";
		clist = cService.allCategory();
		
		Map<String, Object> allNews = new HashMap<String, Object>(); 

		return "loading_news";
	}

	public String detail_news(){
		List<News> n = nService.getByCreateId(createId);
		news = n.get(0);
		createTime = StaticParam.DateFormat2.format(news.getCreateTime());
		return "detail_suc";
	}
	
	public String user_login(){
		User user = uService.getByUsername(username).get(0);
		json = new JSONObject();
		if(!(user.getClass()==null)){
			if(user.getPassword().equals(password)){
				session = ActionContext.getContext().getSession();
				session.put("user", username);
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
	
	
}
