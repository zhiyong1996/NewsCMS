package com.zzy.service.impl;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.AdDao;
import com.zzy.dao.PojoDao;
import com.zzy.po.BottomAd;
import com.zzy.po.SideAd;
import com.zzy.po.TopAd;
import com.zzy.service.AdService;

@Transactional(readOnly = false)
public class AdServiceImpl implements AdService{
	@Resource PojoDao pojodao;
	@Resource AdDao addao;
	
	@Override
	public <O> void saveOrUpdateAd(O obj) {
		pojodao.saveOrUpdate(obj);
	}
	@Override
	public TopAd getTopById(Integer id) {
		// TODO Auto-generated method stub
		return addao.getTopById(id);
	}

	@Override
	public BottomAd getBotById(Integer id) {
		// TODO Auto-generated method stub
		return addao.getBotById(id);
	}

	@Override
	public SideAd getSideById(Integer id) {
		// TODO Auto-generated method stub
		return addao.getSideById(id);
	}

}
