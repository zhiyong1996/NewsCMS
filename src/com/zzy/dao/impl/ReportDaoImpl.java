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
import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.ReportDao;
import com.zzy.po.News;
import com.zzy.po.ReportMessage;

@Transactional(readOnly = false)
public class ReportDaoImpl extends HibernateDaoSupport implements ReportDao {

	@Override
	public Integer save(ReportMessage rmsg) {
		// TODO Auto-generated method stub
		return (Integer) getHibernateTemplate().save(rmsg);
	}

	@Override
	public void saveOrUpdate(ReportMessage rmsg) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(rmsg);
	}

	@Override
	public void delete(ReportMessage rmsg) {
		// TODO Auto-generated method stub
		getHibernateTemplate().delete(rmsg);
	}

	@Override
	public ReportMessage getById(Integer id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(ReportMessage.class,id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ReportMessage> listReportMsg(final String hql, final int offset, final int length) {
		// TODO Auto-generated method stub
		@SuppressWarnings("rawtypes")
		List<ReportMessage> rs = getHibernateTemplate().execute(new HibernateCallback(){

			@Override
			public Object doInHibernate(Session session) throws HibernateException{
				List<News> rs = session.createQuery(hql).setFirstResult(offset).setMaxResults(length).list();
				return rs;
			}
		});
		return rs;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ReportMessage> all() {
		// TODO Auto-generated method stub
		return (List<ReportMessage>) getHibernateTemplate().find("from ReportMessage");
	}

	@Override
	public List<ReportMessage> listBySQL(final String sql, final int offset, final int length) {
		@SuppressWarnings({ "rawtypes", "unchecked" })
		List<ReportMessage> rs = getHibernateTemplate().execute(new HibernateCallback(){
			@Override
			public Object doInHibernate(Session session) throws HibernateException{
				SQLQuery query = session.createSQLQuery(sql);
				//query.setParameter(0, cid);
				query.setFirstResult(offset);
				query.setMaxResults(length);
				query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
				query.addEntity(ReportMessage.class);
				System.out.println(query.list().size());
				List<ReportMessage> n_rs = new ArrayList<ReportMessage>();
				for(int i=0;i<query.list().size();i++){
					Map map = (Map) query.list().get(i);
					n_rs.add((ReportMessage) map.get("ReportMessage"));
				}
				//List<News> rs = query.list();
				return n_rs;
			}
		});
		return rs;
	}

	@Override
	public int getCountBySQL(final String sql) {
		@SuppressWarnings({ "rawtypes", "unchecked" })
		int size = getHibernateTemplate().execute(new HibernateCallback(){
			@Override
			public Object doInHibernate(Session session) throws HibernateException{
				SQLQuery query = session.createSQLQuery(sql);
				query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
				query.addEntity(ReportMessage.class);
				System.out.println(query.list().size());
				return query.list().size();
			}
		});
		return size;
	}

}
