package com.zzy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.AdDao;
import com.zzy.po.BottomAd;
import com.zzy.po.SideAd;
import com.zzy.po.TopAd;
import com.zzy.service.AdService;

@Transactional(readOnly = false)
public class AdServiceImpl implements AdService{
	@Resource AdDao addao;
	
	@Override
	public <O> void saveOrUpdateAd(O obj) {
		addao.saveOrUpdate(obj);
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
	@Override
	public Integer getCount(String ad) {
		String hql = "from "+ad;
		return addao.getCount(hql);
	}
	@Override
	public <O> List<O> listAd(String hql) {
		// TODO Auto-generated method stub
		return addao.listAd(hql);
	}

	@Override
	public List<TopAd> listTop(Integer offset, Integer limit) {
		// TODO Auto-generated method stub
		String sql = "select * from topad";
		return (List<TopAd>) addao.listTopBySQL(sql, offset, limit);
	}
	@Override
	public List<BottomAd> listBot(Integer offset, Integer limit) {
		// TODO Auto-generated method stub
		String sql = "select * from bottomad";
		return (List<BottomAd>) addao.listBotBySQL(sql, offset, limit);
	}
	@Override
	public List<SideAd> listSide(Integer offset, Integer limit) {
		// TODO Auto-generated method stub
		String sql = "select * from sidead";
		return (List<SideAd>) addao.listSideBySQL(sql, offset, limit);
	}

}
