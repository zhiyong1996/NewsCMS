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

import com.zzy.dao.NewsDao;
import com.zzy.po.News;

public class NewsDaoImpl extends HibernateDaoSupport implements NewsDao{
	
	@Override
	public Integer save(News news){
		return (Integer)getHibernateTemplate().save(news);
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
	@SuppressWarnings("unchecked")
	@Override
	public List<News> getByCreateId(String createId) {
		return (List<News>) getHibernateTemplate().find("from News n where n.createId =?",createId);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<News> getNewsByType(Integer typeId){
		return (List<News>) getHibernateTemplate().find("from News n where n.newstype =? and n.issue = true order by createTime desc",typeId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<News> getComNews(Integer cid, Integer typeId) {
		return (List<News>) getHibernateTemplate().find("from News n where n.newstype =? and n.category_id = ? order by createTime desc",new Object[]{typeId,cid});
	}
	
	//根据分类分页查询
	@Override
	public List<News> listBySQL(final String hql, final int offset, final int length) {
		@SuppressWarnings({ "rawtypes", "unchecked" })
		List<News> rs = getHibernateTemplate().execute(new HibernateCallback(){
			@Override
			public Object doInHibernate(Session session) throws HibernateException{
				SQLQuery query = session.createSQLQuery(hql);
				//query.setParameter(0, cid);
				query.setFirstResult(offset);
				query.setMaxResults(length);
				query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
				query.addEntity(News.class);
				System.out.println(query.list().size());
				List<News> n_rs = new ArrayList<News>();
				for(int i=0;i<query.list().size();i++){
					Map map = (Map) query.list().get(i);
					n_rs.add((News) map.get("News"));
				}
				//List<News> rs = query.list();
				return n_rs;
			}
		});
		return rs;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<News> searchNewsByTitle(String keyword) {
		// TODO Auto-generated method stub
		return (List<News>) getHibernateTemplate().find("from News where title like '%"+keyword+"%' and issue = 'T' order by createTime desc");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<News> adminSearchTitle(String keyword) {
		// TODO Auto-generated method stub
		return (List<News>) getHibernateTemplate().find("from News where title like '%"+keyword+"%'  order by createTime desc");
	}
	
	
}
