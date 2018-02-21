package com.zzy.dao.impl;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.AdImgDao;

@Transactional(readOnly = false)
public class AdImgDaoImpl extends HibernateDaoSupport implements AdImgDao {

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

}
