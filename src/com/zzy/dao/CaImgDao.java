package com.zzy.dao;

import java.util.List;

import com.zzy.po.CaImg;

public interface CaImgDao {

	public CaImg getById(Integer id);

	public List<CaImg> pageList(String hql, int offset, int length);

	public Integer getCount(String hql);
}