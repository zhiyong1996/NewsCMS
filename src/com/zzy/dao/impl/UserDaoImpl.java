package com.zzy.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
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

	@Override
	public List<User> listBySQL(final String sql, final int offset, final int limit) {
		@SuppressWarnings({ "rawtypes", "unchecked" })
		List<User> rs = getHibernateTemplate().execute(new HibernateCallback(){
			@Override
			public Object doInHibernate(Session session) throws HibernateException{
				SQLQuery query = session.createSQLQuery(sql);
				query.setFirstResult(offset);
				query.setMaxResults(limit);
				query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
				query.addEntity(User.class);
				System.out.println(query.list().size());
				List<User> n_rs = new ArrayList<User>();
				for(int i=0;i<query.list().size();i++){
					Map map = (Map) query.list().get(i);
					n_rs.add((User) map.get("User"));
				}
				//List<News> rs = query.list();
				return n_rs;
			}
		});
		return rs;
	}

}
