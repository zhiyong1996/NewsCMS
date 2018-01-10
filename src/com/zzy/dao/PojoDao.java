package com.zzy.dao;

import java.util.List;

public interface PojoDao {
	public <O> Integer save(O obj); 
	public <O> void saveOrUpdate(O obj); 
	public <O> void delete(O obj);
	public <O> O getById(Integer id);
	public <O> List<O> pageList(final String hql, final int offset, final int length);
	public <O> Integer getCount(String hql);
}
