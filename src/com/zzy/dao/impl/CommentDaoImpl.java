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

import com.zzy.dao.CommentDao;
import com.zzy.po.Comment;

public class CommentDaoImpl extends HibernateDaoSupport implements CommentDao{

	@Override
	public Integer save(Comment com) {
		// TODO Auto-generated method stub
		return (Integer) getHibernateTemplate().save(com);
	}

	@Override
	public void saveOrUpdate(Comment com) {
		getHibernateTemplate().saveOrUpdate(com);
	}

	@Override
	public Comment getById(Integer id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(Comment.class, id);
	}

	@Override
	public void delComment(Comment com) {
		getHibernateTemplate().delete(com);
	}

	@Override
	public List<Comment> listComment(String hql, int offset, int length) {
		// TODO Aauto-generated method stub
		return null;
	}

	@Override
	public List<Comment> listComByUser(final String hql,final int offset,final int length) {
		@SuppressWarnings({ "rawtypes", "unchecked" })
		List<Comment> rs = getHibernateTemplate().execute(new HibernateCallback(){
			@Override
			public Object doInHibernate(Session session) throws HibernateException{
				SQLQuery query = session.createSQLQuery(hql);
				query.setFirstResult(offset);
				//query.setMaxResults(length);
				query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
				query.addEntity(Comment.class);
				System.out.println(query.list().size());
				List<Comment> n_rs = new ArrayList<Comment>();
				for(int i=0;i<query.list().size();i++){
					Map map = (Map) query.list().get(i);
					n_rs.add((Comment) map.get("Comment"));
				}
				//List<News> rs = query.list();
				return n_rs;
			}
		});
		return rs;
	}

}
