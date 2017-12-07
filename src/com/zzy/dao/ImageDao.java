package com.zzy.dao;

import com.zzy.po.NewsImg;
import com.zzy.po.AdImg;
import com.zzy.po.Avatar;

public interface ImageDao {
	public NewsImg getNewsImgById(Integer id);
	public AdImg getAdImgById(Integer id);
	public Avatar getAvatarById(Integer id);
}
