package com.zzy.action;

import java.io.IOException;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.zzy.dao.AdDao;
import com.zzy.dao.PojoDao;
import com.zzy.imgUtil.ImgUtil;
import com.zzy.po.BotAdImg;
import com.zzy.po.BottomAd;
import com.zzy.po.TopAd;
import com.zzy.po.TopAdImg;

@SuppressWarnings("serial")
public class AdvertiseAction extends ActionSupport{
	@Resource AdDao addao;
	@Resource PojoDao pojodao;
	
	private Integer ad_type;
	private String ad_about;
	private String ad_url;
	private String ad_img_url;
	
	private JSONObject json_ad;
	
	public String ad_manager(){
		return "ad_manager";
	}
	
	public String create_ad(){
		return "";
	}
	
	public String update_ad() throws IOException{
		String new_src;//新的图片路径
		if(ad_type == StaticParam.AD_TOP){
			TopAd t_ad = addao.getTopById(1);
			if(t_ad == null){ //判断对象是否存在
				t_ad = new TopAd();
			}
			
			//保存图片对象
			String fileName = ad_img_url.substring(ad_img_url.lastIndexOf("/")+1);
			new_src = ImgUtil.moveFile(ad_type, ad_url, fileName); // 调用静态类方法移动文件，如果文件已存在则返回空字符串，否则返回新路径
			if(new_src.equals("")){
				new_src = ad_img_url;
			}
			TopAdImg t_ad_img = new TopAdImg();
			t_ad_img.setImgName(fileName);
			t_ad_img.setPath(new_src);
			t_ad_img.setTopad(t_ad);//设置图片和广告关联关系
			t_ad.setAbout(ad_about);
			t_ad.setUrl(ad_url);
			t_ad.setAbout(ad_about);
			t_ad.setAdimg(t_ad_img);
			pojodao.saveOrUpdate(t_ad);//保存新闻对象
			
		}else if(ad_type == StaticParam.AD_BOTTOM){
			BottomAd b_ad = addao.getBotById(1);
			if(b_ad == null){ //判断对象是否存在
				b_ad = new BottomAd();
			}
			
			//保存图片对象
			String fileName = ad_img_url.substring(ad_img_url.lastIndexOf("/")+1);
			new_src = ImgUtil.moveFile(ad_type, ad_url, fileName); // 调用静态类方法移动文件，如果文件已存在则返回空字符串，否则返回新路径
			if(new_src.equals("")){
				new_src = ad_img_url;
			}
			BotAdImg b_ad_img = new BotAdImg();
			b_ad_img.setImgName(fileName);
			b_ad_img.setPath(new_src);
			b_ad_img.setBotad(b_ad);//设置图片和广告关联关系
			b_ad.setAbout(ad_about);
			b_ad.setUrl(ad_url);
			b_ad.setAbout(ad_about);
			b_ad.setAdimg(b_ad_img);
			pojodao.saveOrUpdate(b_ad);//保存新闻对象
		}else{
			BottomAd b_ad = addao.getBotById(1);
			if(b_ad == null){ //判断对象是否存在
				b_ad = new BottomAd();
			}
			
			//保存图片对象
			String fileName = ad_img_url.substring(ad_img_url.lastIndexOf("/")+1);
			new_src = ImgUtil.moveFile(ad_type, ad_url, fileName); // 调用静态类方法移动文件，如果文件已存在则返回空字符串，否则返回新路径
			if(new_src.equals("")){
				new_src = ad_img_url;
			}
			BotAdImg b_ad_img = new BotAdImg();
			b_ad_img.setImgName(fileName);
			b_ad_img.setPath(new_src);
			b_ad_img.setBotad(b_ad);//设置图片和广告关联关系
			b_ad.setAbout(ad_about);
			b_ad.setUrl(ad_url);
			b_ad.setAbout(ad_about);
			b_ad.setAdimg(b_ad_img);
			pojodao.saveOrUpdate(b_ad);//保存新闻对象
		}
		
		json_ad = new JSONObject();
		json_ad.put("code", 0);
		json_ad.put("msg","success");
		
		return "update_ad";
	}

	public Integer getAd_type() {
		return ad_type;
	}

	public void setAd_type(Integer ad_type) {
		this.ad_type = ad_type;
	}

	public String getAd_about() {
		return ad_about;
	}

	public void setAd_about(String ad_about) {
		this.ad_about = ad_about;
	}

	public String getAd_url() {
		return ad_url;
	}

	public void setAd_url(String ad_url) {
		this.ad_url = ad_url;
	}

	public String getAd_img_url() {
		return ad_img_url;
	}

	public void setAd_img_url(String ad_img_url) {
		this.ad_img_url = ad_img_url;
	}

	public JSONObject getJson_ad() {
		return json_ad;
	}

	public void setJson_ad(JSONObject json) {
		this.json_ad = json_ad;
	}
	
}
