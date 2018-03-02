package com.zzy.service;

import com.zzy.po.Avatar;

public interface AvatarService {
	public Integer save(Avatar avatar);
	public void saveOrUpdate(Avatar avatar);
	public void delete(Avatar avatar);
}
