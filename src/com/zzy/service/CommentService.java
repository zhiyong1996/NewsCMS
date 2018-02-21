package com.zzy.service;

import com.zzy.po.Comment;

public interface CommentService {
	public Integer save(Comment com);
	public void saveOrUpdate(Comment com);
	public Comment getById(Integer id);
	public void delCom(Comment com);
}
