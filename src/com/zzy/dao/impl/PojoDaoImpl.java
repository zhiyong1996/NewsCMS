package com.zzy.dao.impl;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.PojoDao;

public class PojoDaoImpl extends HibernateDaoSupport implements PojoDao{

	@Override
	public <O> Integer save(O obj) {
		return (Integer) getHibernateTemplate().save(obj);
	}

	@Override
	public <O> void saveOrUpdate(O obj) {
		getHibernateTemplate().saveOrUpdate(obj);
	}

	@Override
	public <O> void delete(O obj) {
		getHibernateTemplate().delete(obj);
	}

	@Override
	public Integer getCount(String hql) {
		return getHibernateTemplate().find(hql).size();
	}

}
