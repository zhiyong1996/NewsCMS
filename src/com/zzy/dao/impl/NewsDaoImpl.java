package com.zzy.dao.impl;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.NewsDao;
import com.zzy.po.News;

public class NewsDaoImpl extends HibernateDaoSupport implements NewsDao{
	
	@Override
	public void save(News news){
		getHibernateTemplate().save(news);
	}
	
	@Override
	public void saveOrUpdate(News news) {
		getHibernateTemplate().saveOrUpdate(news);
	}
	
	@Override
	public News getById(Integer id) {
		return getHibernateTemplate().get(News.class, id);
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<News> listNews() {
		return (List<News>)getHibernateTemplate().find("from News");
	}


	@Override
	public void delNews(News news) {
		getHibernateTemplate().delete(news);
	}
	
	/*分页查询
	 * 分页查询需要三个参数:
	 * @param hql 查询语句
	 * @param offset 每页的首个记录对应总数的索引(总数以0为第一项)
	 * @param length 每页的最大的集合数
	 * */
	@SuppressWarnings("unchecked")
	@Override
	public List<News> listPage(final String hql, final int offset, final int length) {
		@SuppressWarnings("rawtypes")
		List<News> rs = getHibernateTemplate().execute(new HibernateCallback(){

			@Override
			public Object doInHibernate(Session session) throws HibernateException{
				List<News> rs = session.createQuery(hql).setFirstResult(offset).setMaxResults(length).list();
				return rs;
			}
		});
		return rs;
	}
	
	//获取记录总数
	@Override
	public int getCount(String hql) {
		return getHibernateTemplate().find(hql).size();
	}
	
	//根据createid查询
	@Override
	public News getByCreateId(String createId) {
		return (News)getHibernateTemplate().find("form News where createId like"+createId);
	}

}
