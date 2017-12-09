package com.zzy.service;

import java.util.List;

import com.zzy.po.NewsImg;

public interface ImageService {
	public void save(NewsImg newsImg);
	public void saveOrUpdate(NewsImg newsImg);
	public NewsImg getNewsImgById(Integer id);
	public void delNewsImg(NewsImg newsImg);
	public List<NewsImg> listNewsImg();
	public List<NewsImg> pageNewsImg(String hql,int offset,int length);
	public int getCount(String hql);
}
