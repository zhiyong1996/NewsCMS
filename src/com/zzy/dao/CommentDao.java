package com.zzy.dao;

import com.zzy.po.Comment;

public interface CommentDao {
	//添加评论和删除评论
	public String addCommemt(Comment com);
	public String delComment(Comment com);
}
