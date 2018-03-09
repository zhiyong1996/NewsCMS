package com.zzy.service;

import java.util.List;

import com.zzy.po.BottomAd;
import com.zzy.po.SideAd;
import com.zzy.po.TopAd;

public interface AdService {
	public <O> void saveOrUpdateAd(O obj);
	public TopAd getTopById(Integer id);
	public BottomAd getBotById(Integer id);
	public SideAd getSideById(Integer id);
	public <O> List<O> listAd(String hql);
	public Integer getCount(String ad);
	
	public List<TopAd> listTop(Integer offset,Integer limit);
	public List<BottomAd> listBot(Integer offset,Integer limit);
	public List<SideAd> listSide(Integer offset,Integer limit);
}
