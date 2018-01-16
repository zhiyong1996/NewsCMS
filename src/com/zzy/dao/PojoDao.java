package com.zzy.dao;

public interface PojoDao {
	public <O> Integer save(O obj); 
	public <O> void saveOrUpdate(O obj); 
	public <O> void delete(O obj);
	public Integer getCount(String hql);
}
