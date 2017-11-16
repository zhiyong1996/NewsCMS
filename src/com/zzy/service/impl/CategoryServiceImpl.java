package com.zzy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.CategoryDao;
import com.zzy.po.Category;
import com.zzy.service.CategoryService;

@Transactional(readOnly=false)
public class CategoryServiceImpl implements CategoryService{
	@Resource CategoryDao categoryDao;
	@Override
	public void save(Category c) {
		categoryDao.saveOrUpdate(c);
	}

	@Override
	public void saveOrUpdate(Category c) {
		categoryDao.saveOrUpdate(c);
	}

	@Override
	public Category getById(Integer cid) {
		return categoryDao.findById(cid);
	}

	@Override
	public void delCategory(Category c) {
		categoryDao.delCategory(c);
	}

	@Override
	public List<Category> pageCategory(String hql, int offset, int length) {
		return categoryDao.pageCategory(hql, offset, length);
	}

	@Override
	public List<Category> allCategory() {
		// TODO Auto-generated method stub
		return categoryDao.allCategory();
	}

}
