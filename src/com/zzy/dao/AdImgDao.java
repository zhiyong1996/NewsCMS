package com.zzy.dao;

public interface AdImgDao {
	public <O> Integer save(O obj); 
	public <O> void saveOrUpdate(O obj); 
	public <O> void delete(O obj);
}
