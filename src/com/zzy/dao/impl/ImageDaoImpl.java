package com.zzy.dao.impl;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.ImageDao;
import com.zzy.po.TopAdImg;
import com.zzy.po.Avatar;
import com.zzy.po.News;
import com.zzy.po.NewsImg;

public class ImageDaoImpl extends HibernateDaoSupport implements ImageDao {

	@Override
	public NewsImg getNewsImgById(Integer id) {
		return getHibernateTemplate().get(NewsImg.class, id);
	}

	@Override
	public void saveOrUpdateNewsImg(NewsImg newsImg) {
		getHibernateTemplate().saveOrUpdate(newsImg);
	}

	@Override
	public void saveNewsImg(NewsImg newsImg) {
		getHibernateTemplate().save(newsImg);
	}

	@Override
	public void deleteNewsImg(NewsImg newsImg) {
		getHibernateTemplate().delete(newsImg);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<NewsImg> listNewsImg() {
		return (List<NewsImg>)getHibernateTemplate().find("form NewsImg");
	}

	@Override
	public Avatar getAvatarById(Integer id) {
		return getHibernateTemplate().get(Avatar.class, id);
	}

	@Override
	public void saveOrUpdateAvatar(Avatar avatar) {
		getHibernateTemplate().saveOrUpdate(avatar);
	}

	@Override
	public void saveAvatar(Avatar avatar) {
		getHibernateTemplate().save(avatar);
	}

	@Override
	public void deleteAvatar(Avatar avatar) {
		getHibernateTemplate().delete(avatar);
	}

	@Override
	public TopAdImg getAdImgById(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/*分页查询
	 * 分页查询需要三个参数:
	 * @param hql 查询语句
	 * @param offset 每页的首个记录对应总数的索引(总数以0为第一项)
	 * @param length 每页的最大的集合数
	 * */
	@SuppressWarnings("unchecked")
	@Override
	public List<NewsImg> listPage(final String hql, final int offset, final int length) {
		@SuppressWarnings("rawtypes")
		List<NewsImg> rs = getHibernateTemplate().execute(new HibernateCallback(){

			@Override
			public Object doInHibernate(Session session) throws HibernateException{
				List<News> rs = session.createQuery(hql).setFirstResult(offset).setMaxResults(length).list();
				return rs;
			}
		});
		return rs;
	}
	
	@Override
	public int getCount(String hql){
		return getHibernateTemplate().find(hql).size();
	}
}
