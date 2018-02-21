package com.zzy.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.AdDao;
import com.zzy.po.BottomAd;
import com.zzy.po.SideAd;
import com.zzy.po.TopAd;

@Transactional(readOnly = false)
public class AdDaoImpl extends HibernateDaoSupport implements AdDao{

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
		return getHibernateTemplate().find(hql).size();
	}

	@SuppressWarnings("unchecked")
	@Override
	public <O> List<O> listAd(String hql) {
		// TODO Auto-generated method stub
		return (List<O>) getHibernateTemplate().find("from "+hql);
	}

}
