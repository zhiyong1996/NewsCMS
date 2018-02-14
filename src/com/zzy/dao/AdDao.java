package com.zzy.dao;

import com.zzy.po.BottomAd;
import com.zzy.po.SideAd;
import com.zzy.po.TopAd;

public interface AdDao {
	public void show();
	public TopAd getTopById(Integer id);
	public BottomAd getBotById(Integer id);
	public SideAd getSideById(Integer id);
}
