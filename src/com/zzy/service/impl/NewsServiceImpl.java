package com.zzy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.NewsDao;
import com.zzy.po.News;
import com.zzy.service.NewsService;

@Transactional(readOnly = false)
public class NewsServiceImpl implements NewsService {
	@Resource NewsDao newsDao;

	@Override
	public void saveOrUpdate(News news) {
		newsDao.saveOrUpdate(news);
	}

	@Override
	public News getById(Integer id) {
		return newsDao.getById(id);
	}

	@Override
	public void delNews(News news) {
		newsDao.delNews(news);
	}

	@Override
	public List<News> listNews() {
		return newsDao.listNews();
	}

	@Override
	public Integer save(News news) {
		return newsDao.save(news);
	}

	// 分页查询
	@Override
	public List<News> pageNews(final String hql, final int offset,
			final int length) {
		return newsDao.listPage(hql, offset, length);
	}

	// 获取某个记录总数
	@Override
	public int getCount(String hql) {
		return newsDao.getCount(hql);
	}

	@Override
	public News getByCreateId(String createId) {
		if(newsDao.getByCreateId(createId).size()>0){
			System.out.println("有");
			return newsDao.getByCreateId(createId).get(0);
			
		}else{
			return null;
		}
	}

	@Override
	public List<News> listBySQL(String hql, int offset, int length) {
		return newsDao.listBySQL(hql, offset, length);
	}

	@Override
	public List<News> getByTitle(String keyword) {
		// TODO Auto-generated method stub
		return newsDao.searchNewsByTitle(keyword);
	}

	@Override
	public List<News> listByPosition(Integer typeId) {
		// TODO Auto-generated method stub
		String sql = "select * from news where issue = 'T' and newstype = "+typeId;
		return newsDao.listBySQL(sql, 0, 5);
	}

	@Override
	public List<News> listComByCategory(Integer cateId) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM `news` where issue = 'T' and newstype = 0 and category_id = "+cateId;
		return newsDao.listBySQL(sql, 0, 5);
	}
}
