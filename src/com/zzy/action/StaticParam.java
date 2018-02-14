package com.zzy.action;

import java.text.SimpleDateFormat;

public class StaticParam {
	// 新闻位置
	public final static Integer COMMENT_NEWS = 0; // 普通新闻
	public final static Integer CA_NEWS = 1; // 轮播新闻
	public final static Integer HOT_NEWS = 2; // 热点新闻
	
	//广告位置
	public final static Integer AD_TOP = 0; // 顶部
	public final static Integer AD_BOTTOM = 1; // 底部
	public final static Integer AD_SIDE = 2; // 右边

	public static String getPositionType(Integer type) {
		switch (type) {
		case 0:
			return "普通";
		case 1:
			return "轮播";
		case 2:
			return "热点";
		default:
			return "普通";
		}
	}

	// 日期格式化
	public static SimpleDateFormat DateFormat1 = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	public static SimpleDateFormat DateFormat2 = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
	public static SimpleDateFormat DateFormat3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public final static Integer CA_NEWS_MAX = 5; // 轮播新闻最大显示数量
	public final static Integer HOT_NEWS_MAX = 5; // 热点新闻最大显示数量
}
