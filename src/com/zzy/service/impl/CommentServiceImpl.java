package com.zzy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.zzy.dao.CommentDao;
import com.zzy.po.Comment;
import com.zzy.service.CommentService;

@Transactional(readOnly=false)
public class CommentServiceImpl implements CommentService{
	@Resource CommentDao comdao;
	@Override
	public Integer save(Comment com) {
		// TODO Auto-generated method stub
		return comdao.save(com);
	}

	@Override
	public void saveOrUpdate(Comment com) {
		// TODO Auto-generated method stub
		comdao.saveOrUpdate(com);
	}

	@Override
	public Comment getById(Integer id) {
		// TODO Auto-generated method stub
		return comdao.getById(id);
	}

	@Override
	public void delCom(Comment com) {
		// TODO Auto-generated method stub
		comdao.delComment(com);
	}

	@Override
	public List<Comment> listByUser(Integer uid) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM `comment` where user_id = "+uid+" order by createTimeS desc;";
		return comdao.listComByUser(sql, 0, 10);
	}

}
