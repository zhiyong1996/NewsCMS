package com.zzy.dao;

import java.util.List;

import com.zzy.po.User;

public interface UserDao {
	public Integer save(User u); 
	public void saveOrUpdate(User u); 
	public void delete(User u);
	public Integer getCount(String hql);
	public User getById(Integer id);
	
	public List<User> pageList(final String hql, final int offset, final int length);
	public List<User> getByUsername(String username);
	public List<User> listBySQL(String sql,int offset,int limit);
}
