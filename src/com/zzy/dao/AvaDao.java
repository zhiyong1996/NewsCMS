package com.zzy.dao;

import com.zzy.po.Avatar;

public interface AvaDao {
	public Integer save(Avatar av);
	public void saveOrUpdate(Avatar av);
	public void delete(Avatar av);
	public Avatar getById(Integer id);
}
