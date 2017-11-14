package com.zzy.service;

import java.util.List;

import com.zzy.po.Category;

public interface CategoryService {
	public void save(Category c);
	public void saveOrUpdate(Category c);
	public Category getById(Integer cid);
	public void delCategory(Category c);
	public List<Category> pageCategory(String hql,int offset,int length);
}
