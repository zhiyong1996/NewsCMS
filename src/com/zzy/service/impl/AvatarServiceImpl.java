package com.zzy.service.impl;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.AvaDao;
import com.zzy.po.Avatar;
import com.zzy.service.AvatarService;

@Transactional(readOnly=false)
public class AvatarServiceImpl implements AvatarService{
	@Resource AvaDao avaDao;
	@Override
	public Integer save(Avatar avatar) {
		// TODO Auto-generated method stub
		return avaDao.save(avatar);
	}

	@Override
	public void saveOrUpdate(Avatar avatar) {
		// TODO Auto-generated method stub
		avaDao.saveOrUpdate(avatar);
	}

	@Override
	public void delete(Avatar avatar) {
		// TODO Auto-generated method stub
		avaDao.delete(avatar);
	}

}
