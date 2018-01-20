package com.zzy.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.News;
import com.zzy.service.NewsService;

@SuppressWarnings("serial")
public class UserAction extends ActionSupport{
	@Resource
	NewsService nService;
	List<News> ca_news ;
	List<News> hot_news ;
	
	public String loading_news(){
		
		ActionContext cx = ActionContext.getContext();
		
		String has_news = (String) cx.get("has_news");
		if(has_news==null||has_news.equals("")){
			ca_news = nService.getByType(StaticParam.CA_NEWS);
			hot_news = nService.getByType(StaticParam.HOT_NEWS);
			
			News n ;
			for(int i=0;i<ca_news.size();i++){
				n = ca_news.get(i);
				System.out.println(n.getTitle());
			};
			cx.put("has_news","true");
			cx.put("ca_news", ca_news);
		}
		return "loading_news";
	}
	public String show_index(){
		return "show_index";
	}
	public String detail_news(){
		return "detail_suc";
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
	
}
