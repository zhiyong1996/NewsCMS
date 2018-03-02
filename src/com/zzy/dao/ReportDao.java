package com.zzy.dao;

import java.util.List;

import com.zzy.po.ReportMessage;

public interface ReportDao {
	public Integer save(ReportMessage rmsg);
	public void saveOrUpdate(ReportMessage rmsg);
	public void delete(ReportMessage rmsg);
	public ReportMessage getById(Integer id);
	
	public List<ReportMessage> listReportMsg(String hql,int offset,int length);
	public List<ReportMessage> listBySQL(String sql,int offset,int length);
	public int getCountBySQL(String sql);
	public List<ReportMessage> all();
}
