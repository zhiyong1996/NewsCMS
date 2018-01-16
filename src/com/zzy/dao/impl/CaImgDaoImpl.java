package com.zzy.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.CaImgDao;
import com.zzy.dao.PojoDao;
import com.zzy.po.CaImg;

public class CaImgDaoImpl extends HibernateDaoSupport implements PojoDao,CaImgDao{

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
	public CaImg getById(Integer id) {		
		return null;
	}

	@Override
	public  List<CaImg> pageList(String hql, int offset, int length) {
		return null;
	}

	@Override
	public Integer getCount(String hql) {		
		return null;
	}

}
