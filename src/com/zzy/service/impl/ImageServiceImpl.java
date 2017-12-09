package com.zzy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.ImageDao;
import com.zzy.po.NewsImg;
import com.zzy.service.ImageService;

@Transactional(readOnly = false)
public class ImageServiceImpl implements ImageService{
	@Resource ImageDao imgDao;

	@Override
	public void save(NewsImg newsImg) {
		imgDao.saveNewsImg(newsImg);
	}

	@Override
	public void saveOrUpdate(NewsImg newsImg) {
		imgDao.saveOrUpdateNewsImg(newsImg);		
	}

	@Override
	public NewsImg getNewsImgById(Integer id) {
		return imgDao.getNewsImgById(id);
	}

	@Override
	public void delNewsImg(NewsImg newsImg) {
		imgDao.deleteNewsImg(newsImg);
	}

	@Override
	public List<NewsImg> listNewsImg() {
		return imgDao.listNewsImg();
	}

	@Override
	public List<NewsImg> pageNewsImg(String hql, int offset, int length) {
		// TODO Auto-generated method stub
		return imgDao.listPage(hql, offset, length);
	}

	@Override
	public int getCount(String hql) {
		// TODO Auto-generated method stub
		return imgDao.getCount(hql);
	}

}
