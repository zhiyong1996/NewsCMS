package com.zzy.dao;
import java.util.List;

import com.zzy.po.Category;
import com.zzy.po.News;

public interface CategoryDao {
	public void saveOrUpdate(Category c);
	public Integer saveCategory(Category c);
	public void delCategory(Category c);
	public Category findById(Integer cid);
	public List<Category> pageCategory(String hql,int offset,int length);
	public List<Category> allCategory();
	public List<News> listNewsByCategory(Category c);
}
