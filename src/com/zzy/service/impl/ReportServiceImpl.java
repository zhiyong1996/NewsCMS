package com.zzy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.zzy.dao.ReportDao;
import com.zzy.po.ReportMessage;
import com.zzy.service.ReportService;

public class ReportServiceImpl implements ReportService{
	@Resource ReportDao rDao;
	
	@Override
	public Integer save(ReportMessage rmsg) {
		// TODO Auto-generated method stub
		return rDao.save(rmsg);
	}

	@Override
	public void saveOrUpdate(ReportMessage rmsg) {
		// TODO Auto-generated method stub
		rDao.saveOrUpdate(rmsg);
	}

	@Override
	public ReportMessage getById(Integer id) {
		// TODO Auto-generated method stub
		return rDao.getById(id);
	}

	@Override
	public void delete(ReportMessage rmsg) {
		// TODO Auto-generated method stub
		rDao.delete(rmsg);
	}

	@Override
	public List<ReportMessage> all() {
		// TODO Auto-generated method stub
		return rDao.all();
	}

	@Override
	public List<ReportMessage> listData(String hql, int offset, int limit) {
		// TODO Auto-generated method stub
		return rDao.listReportMsg(hql, offset, limit);
	}

	@Override
	public int getCount(String sql) {
		// TODO Auto-generated method stub
		return rDao.getCountBySQL(sql);
	}

	@Override
	public List<ReportMessage> listBySQL(String sql, int offset, int limit) {
		// TODO Auto-generated method stub
		return rDao.listBySQL(sql, offset, limit);
	}

}
