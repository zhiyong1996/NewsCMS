package com.zzy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.PojoDao;
import com.zzy.dao.UserDao;
import com.zzy.po.User;
import com.zzy.service.UserService;

@Transactional(readOnly = false)
public class UserServiceImpl implements UserService {
	@Resource UserDao userDao;
	@Resource PojoDao pojoDao;
	
	@Override
	public Integer save(User user) {
		return pojoDao.save(user);
	}

	@Override
	public void saveOrUpdate(User user) {
		pojoDao.saveOrUpdate(user);
	}

	@Override
	public User getUserById(Integer id) {
		return userDao.getById(id);
	}

	@Override
	public void delUser(User user) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<User> listUser() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> pageUser(String hql, int offset, int length) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getCount(String hql) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public User getByUsername(String name) {
		List<User> users = userDao.getByUsername(name);
		if(users.size()>0){
			return users.get(0);
		}
		return null;
	}

}
