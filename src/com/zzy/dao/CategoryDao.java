package com.zzy.dao;
import java.util.List;

import com.zzy.po.Category;

public interface CategoryDao {
	public void saveOrUpdate(Category c);
	public void saveCategory(Category c);
	public void delCategory(Category c);
	public Category findById(Integer cid);
	public List<Category> pageCategory(String hql,int offset,int length);
}
