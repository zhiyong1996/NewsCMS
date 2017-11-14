package com.zzy.dao;

import java.util.List;

import com.zzy.po.News;

public interface NewsDao {
	public void saveOrUpdate(News news);
	public void save(News news);
	public News getById(Integer id);
	public List<News> listNews();
	public void delNews(News news);
	public List<News> listPage(String hql,int offset,int length);
	public int getCount(String hql);
}
