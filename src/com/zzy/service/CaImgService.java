package com.zzy.service;

import com.zzy.po.CaImg;

public interface CaImgService {
	public Integer save (CaImg img);
	public void saveOrUpdate (CaImg img);
	public void delete (CaImg img);
}
