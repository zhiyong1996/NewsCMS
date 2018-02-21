package com.zzy.service;

import java.util.List;

import com.zzy.po.News;

public interface NewsService {
	public Integer save(News news);
	public void saveOrUpdate(News news);
	public News getById(Integer id);
	public void delNews(News news);
	public List<News> listNews();
	public List<News> pageNews(String hql,int offset,int length);
	public int getCount(String hql);
	public List<News> getByCreateId(String createId);
	
	public List<News> getByType(Integer typeId);
	public List<News> listByCategory(String hql,int offset,int length,Integer cid);
	public List<News> getByTitle(String keyword);
}
