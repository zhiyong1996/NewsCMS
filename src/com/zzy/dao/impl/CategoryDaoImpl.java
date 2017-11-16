package com.zzy.dao.impl;

import java.util.List;







import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.CategoryDao;
import com.zzy.po.Category;
import com.zzy.po.News;

public class CategoryDaoImpl extends HibernateDaoSupport implements CategoryDao {

	@Override
	public void saveOrUpdate(Category c) {
		getHibernateTemplate().saveOrUpdate(c);
	}

	@Override
	public void saveCategory(Category c) {
		getHibernateTemplate().save(c);
	}

	@Override
	public void delCategory(Category c) {
		getHibernateTemplate().delete(c);
	}

	@Override
	public Category findById(Integer cid) {
		return getHibernateTemplate().get(Category.class, cid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Category> pageCategory(final String hql, final int offset, final int length) {
		@SuppressWarnings("rawtypes")
		List<Category> rs = getHibernateTemplate().execute(new HibernateCallback(){

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
	public List<Category> allCategory() {
		return (List<Category>) getHibernateTemplate().find("from Category");
	}

}
