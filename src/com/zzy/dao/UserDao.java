package com.zzy.dao;

import com.zzy.po.User;

public interface UserDao {
	public Integer saveUser(User user);
	public void saveOrUpdateuser(User user);
}
