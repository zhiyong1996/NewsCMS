package com.zzy.dao.impl;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.AvaDao;
import com.zzy.po.Avatar;

public class AvaDaoImpl extends HibernateDaoSupport implements AvaDao {

	@Override
	public Integer save(Avatar av) {
		// TODO Auto-generated method stub
		return (Integer) getHibernateTemplate().save(av);
	}

	@Override
	public void saveOrUpdate(Avatar av) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(av);
	}

	@Override
	public void delete(Avatar av) {
		// TODO Auto-generated method stub
		getHibernateTemplate().delete(av);
	}

	@Override
	public Avatar getById(Integer id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(Avatar.class, id);
	}

}
