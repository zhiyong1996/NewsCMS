package com.zzy.dao.impl;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.AdDao;
import com.zzy.dao.PojoDao;
import com.zzy.po.BottomAd;
import com.zzy.po.SideAd;
import com.zzy.po.TopAd;

public class AdDaoImpl extends HibernateDaoSupport implements AdDao,PojoDao{

	@Override
	public void show() {
		// TODO Auto-generated method stub
	}

	@Override
	public TopAd getTopById(Integer id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(TopAd.class, id);
	}

	@Override
	public BottomAd getBotById(Integer id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(BottomAd.class, id);
	}

	@Override
	public SideAd getSideById(Integer id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(SideAd.class, id);
	}

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
	public Integer getCount(String hql) {
		// TODO Auto-generated method stub
		return null;
	}

}
