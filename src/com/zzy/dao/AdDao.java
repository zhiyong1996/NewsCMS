package com.zzy.dao;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.po.BottomAd;
import com.zzy.po.SideAd;
import com.zzy.po.TopAd;

@Transactional(readOnly = false)
public interface AdDao {
	public void show();
	public TopAd getTopById(Integer id);
	public BottomAd getBotById(Integer id);
	public SideAd getSideById(Integer id);
	
	public <O> Integer save(O obj); 
	public <O> void saveOrUpdate(O obj); 
	public <O> void delete(O obj);
	public Integer getCount(String hql);
	public <O> List<O> listAd(String hql);
}
