package com.zzy.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.PojoDao;

public class PojoDaoImpl extends HibernateDaoSupport implements PojoDao {

	@Override
	public <O> Integer save(O obj) {		
		return (Integer)getHibernateTemplate().save(obj);
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
	public <O> O getById(Integer id) {		
		return null;
	}

	@Override
	public <O> List<O> pageList(String hql, int offset, int length) {
		return null;
	}

	@Override
	public <O> Integer getCount(String hql) {		
		return null;
	}

}
