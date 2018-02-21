package com.zzy.service.impl;

import javax.annotation.Resource;
import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.AdImgDao;
import com.zzy.service.AdImgService;

@Transactional(readOnly = false)
public class AdImgServiceImpl implements AdImgService {
	@Resource AdImgDao adimgDao;
	
	@Override
	public <O> Integer save(O obj) {
		// TODO Auto-generated method stub
		return adimgDao.save(obj);
	}

	@Override
	public <O> void saveOrUpdate(O obj) {
		// TODO Auto-generated method stub
		adimgDao.saveOrUpdate(obj);
	}

	@Override
	public <O> void delete(O obj) {
		// TODO Auto-generated method stub
		adimgDao.delete(obj);
	}

}
