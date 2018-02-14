package com.zzy.service;

import com.zzy.po.BottomAd;
import com.zzy.po.SideAd;
import com.zzy.po.TopAd;

public interface AdService {
	public <O> void saveOrUpdateAd(O obj);
	public TopAd getTopById(Integer id);
	public BottomAd getBotById(Integer id);
	public SideAd getSideById(Integer id);
}
