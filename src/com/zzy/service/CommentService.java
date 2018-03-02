package com.zzy.service;

import java.util.List;

import com.zzy.po.Comment;

public interface CommentService {
	public Integer save(Comment com);
	public void saveOrUpdate(Comment com);
	public Comment getById(Integer id);
	public void delCom(Comment com);
	
	public List<Comment> listByUser(Integer uid);
}
