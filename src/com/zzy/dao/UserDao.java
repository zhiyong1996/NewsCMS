package com.zzy.dao;

import java.util.List;

import com.zzy.po.User;

public interface UserDao {
	public User getById(Integer id);
	public List<User> pageList(final String hql, final int offset, final int length);
	public List<User> getUserByName(String name);
}
