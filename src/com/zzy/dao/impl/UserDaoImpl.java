package com.zzy.dao.impl;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.UserDao;
import com.zzy.po.User;

public class UserDaoImpl extends HibernateDaoSupport implements UserDao {

	@Override
	public Integer saveUser(User user) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void saveOrUpdateuser(User user) {
		// TODO Auto-generated method stub
		
	}

}
