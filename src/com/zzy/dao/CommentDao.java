package com.zzy.dao;

import java.util.List;

import com.zzy.po.Comment;

public interface CommentDao {
	//添加评论和删除评论
	public Integer save(Comment com);
	public void saveOrUpdate(Comment com);
	public Comment getById(Integer id);
	
	public void delComment(Comment com);
	public List<Comment> listComment(String hql,int offset,int length);
	public List<Comment> listComByUser(String hql,int offset,int length);
}
