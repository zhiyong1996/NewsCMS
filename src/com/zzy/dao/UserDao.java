package com.zzy.dao;

import com.zzy.po.User;

public interface UserDao {
	public void saveUser(User user);
	public void saveOrUpdateuser(User user);
}
