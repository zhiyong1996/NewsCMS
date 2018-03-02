package com.zzy.service;

import java.util.List;

import com.zzy.po.ReportMessage;

public interface ReportService {
	public Integer save(ReportMessage rmsg);
	public void saveOrUpdate(ReportMessage rmsg);
	public ReportMessage getById(Integer id);
	public void delete(ReportMessage rmsg);
	
	public List<ReportMessage> all();
	public List<ReportMessage> listData(String hql,int offset,int limit);
	public List<ReportMessage> listBySQL(String sql,int offset,int limit);
	public int getCount(String sql);
}
