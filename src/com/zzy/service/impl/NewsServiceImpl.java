package com.zzy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.NewsDao;
import com.zzy.po.News;
import com.zzy.service.NewsService;

@Transactional(readOnly = false)
public class NewsServiceImpl implements NewsService {
	@Resource
	NewsDao newsDao;

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
	public List<News> getByCreateId(String createId) {
		return newsDao.getByCreateId(createId);
	}
}
