package com.zzy.dao;

import java.util.List;

import com.zzy.po.NewsImg;
import com.zzy.po.AdImg;
import com.zzy.po.Avatar;

public interface ImageDao {
	public NewsImg getNewsImgById(Integer id);
	public void saveOrUpdateNewsImg(NewsImg newsImg);
	public void saveNewsImg(NewsImg newsImg);
	public void deleteNewsImg(NewsImg newsImg);
	public List<NewsImg> listNewsImg();
	
	public Avatar getAvatarById(Integer id);
	public void saveOrUpdateAvatar(Avatar avatar);
	public void saveAvatar(Avatar avatar);
	public void deleteAvatar(Avatar avatar);
	
	public AdImg getAdImgById(Integer id);
	
	public List<NewsImg> listPage(final String hql, final int offset, final int length);
	public int getCount(String hql);
}
