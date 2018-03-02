package com.zzy.dao.impl;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.UserDao;
import com.zzy.po.User;

public class UserDaoImpl extends HibernateDaoSupport implements UserDao{
	//UserDao

	@SuppressWarnings("unchecked")
	@Override
	public List<User> pageList(final String hql, final int offset, final int length) {
		@SuppressWarnings("rawtypes")
		List<User> rs = getHibernateTemplate().execute(new HibernateCallback(){

			@Override
			public Object doInHibernate(Session session) throws HibernateException{
				List<User> rs = session.createQuery(hql).setFirstResult(offset).setMaxResults(length).list();
				return rs;
			}
		});
		return rs;
	}

	@Override
	public User getById(Integer id) {
		return getHibernateTemplate().get(User.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> getByUsername(String username) {
		return (List<User>) getHibernateTemplate().find("from User u where u.username =? ",username);
	}

	@Override
	public Integer save(User u) {
		// TODO Auto-generated method stub
		return (Integer) getHibernateTemplate().save(u);
	}

	@Override
	public void saveOrUpdate(User u) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(u);
	}

	@Override
	public void delete(User u) {
		// TODO Auto-generated method stub
		getHibernateTemplate().delete(u);
	}

	@Override
	public Integer getCount(String hql) {
		// TODO Auto-generated method stub
		return null;
	}

}
