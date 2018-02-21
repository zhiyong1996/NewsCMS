package com.zzy.service;

public interface AdImgService {
	public <O> Integer save(O obj); 
	public <O> void saveOrUpdate(O obj); 
	public <O> void delete(O obj);
}
