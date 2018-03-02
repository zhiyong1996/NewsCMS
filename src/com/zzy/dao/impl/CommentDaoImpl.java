package com.zzy.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.zzy.dao.CommentDao;
import com.zzy.po.Comment;

public class CommentDaoImpl extends HibernateDaoSupport implements CommentDao{

	@Override
	public Integer save(Comment com) {
		// TODO Auto-generated method stub
		return (Integer) getHibernateTemplate().save(com);
	}

	@Override
	public void saveOrUpdate(Comment com) {
		getHibernateTemplate().saveOrUpdate(com);
	}

	@Override
	public Comment getById(Integer id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(Comment.class, id);
	}

	@Override
	public void delComment(Comment com) {
		getHibernateTemplate().delete(com);
	}

	@Override
	public List<Comment> listComment(String hql, int offset, int length) {
		// TODO Aauto-generated method stub
		return null;
	}

	@Override
	public List<Comment> listComByUser() {
		// TODO Auto-generated method stub
		return null;
	}

}
