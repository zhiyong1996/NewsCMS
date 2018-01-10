package com.zzy.service.impl;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.PojoDao;
import com.zzy.po.CaImg;
import com.zzy.service.CaImgService;

@Transactional(readOnly = false)
public class CaImgServiceImpl implements CaImgService {
	@Resource PojoDao pojoDao;
	
	@Override
	public Integer save(CaImg img) {
		// TODO Auto-generated method stub
		return pojoDao.save(img);
	}

	@Override
	public void saveOrUpdate(CaImg img) {
		// TODO Auto-generated method stub
		pojoDao.saveOrUpdate(img);
	}

	@Override
	public void delete(CaImg img) {
		pojoDao.delete(img);
	}

}
