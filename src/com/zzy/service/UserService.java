package com.zzy.service;

import java.util.List;

import com.zzy.po.User;

public interface UserService {
	public Integer save(User user);
	public void saveOrUpdate(User user);
	public User getUserById(Integer id);
	public void delUser(User user);
	public List<User> listUser();
	public List<User> pageUser(String hql,int offset,int length);
	public int getCount(String hql);
	public User getByUsername(String name);
}
