package com.zzy.action;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.zzy.dao.AdDao;
import com.zzy.dao.AdImgDao;
import com.zzy.imgUtil.ImgUtil;
import com.zzy.po.BotAdImg;
import com.zzy.po.BottomAd;
import com.zzy.po.SideAd;
import com.zzy.po.SideAdImg;
import com.zzy.po.TopAd;
import com.zzy.po.TopAdImg;

@SuppressWarnings("serial")
public class AdvertiseAction extends ActionSupport{
	@Resource AdDao addao;
	@Resource AdImgDao adImgDao;
	
	private Integer ad_type;
	private String ad_about;
	private String ad_url;
	private String ad_img_url;
	
	private JSONObject json_ad;
	
	private TopAd t_ad;
	private BottomAd b_ad;
	private SideAd s_ad;
	
	public String ad_manager(){
		List<TopAd> top = addao.listAd("TopAd");
		List<BottomAd> bot = addao.listAd("BottomAd");
		List<SideAd> side = addao.listAd("SideAd");
		if(top.size()>0){
			t_ad = top.get(0);
		}
		if(bot.size()>0){
			b_ad = bot.get(0);
		}
		if(side.size()>0){
			s_ad = side.get(0);
		}
		return "ad_manager";
	}
	
	public String get_ad(){
		//实例化根json对象
		json_ad = new JSONObject();
		//创建一个对象引用
		JSONObject ad;
		List<TopAd> top = addao.listAd("TopAd");
		List<BottomAd> bot = addao.listAd("BottomAd");
		List<SideAd> side = addao.listAd("SideAd");
		if(top.size()>0){
			t_ad = top.get(0);
			ad = new JSONObject();
			ad.put("type","top");
			ad.put("about", t_ad.getAbout());
			ad.put("url", t_ad.getUrl());
			ad.put("img", t_ad.getAdimg().getPath());
			json_ad.put("top", ad);
		}else{
			json_ad.put("top", "");
		}
		if(bot.size()>0){
			b_ad = bot.get(0);
			ad = new JSONObject();
			ad.put("type","bot");
			ad.put("about", b_ad.getAbout());
			ad.put("url", b_ad.getUrl());
			ad.put("img", b_ad.getAdimg().getPath());
			json_ad.put("bot", ad);
		}else{
			json_ad.put("bot", "");
		}
		if(side.size()>0){
			s_ad = side.get(0);
			ad = new JSONObject();
			ad.put("type","side");
			ad.put("about", s_ad.getAbout());
			ad.put("url", s_ad.getUrl());
			ad.put("img", s_ad.getAdimg().getPath());
			json_ad.put("side", ad);
		}else{
			json_ad.put("side", "");
		}
		return "get_ad";
	}
	
	public String update_ad() throws IOException{
		String new_src;//新的图片路径
		if(ad_type == StaticParam.AD_TOP){
			TopAd t_ad ;
			List<TopAd> all_t_ad = addao.listAd("TopAd");
			if(all_t_ad.size() == 0){ //判断对象是否存在
				t_ad = new TopAd();
				t_ad.setAbout(ad_about);
				t_ad.setUrl(ad_url);
				t_ad.setAbout(ad_about);
				addao.save(t_ad);
			}else{
				t_ad = all_t_ad.get(0);
				t_ad.setAbout(ad_about);
				t_ad.setUrl(ad_url);
				t_ad.setAbout(ad_about);
			}
			System.out.println(ad_type+ad_url+ad_about+ad_img_url);
			//保存图片对象
			String fileName = ad_img_url.substring(ad_img_url.lastIndexOf("/")+1);
			System.out.println(ad_img_url);
			new_src = ImgUtil.MoveAdImg(ad_type, ad_img_url, fileName); // 调用静态类方法移动文件，如果文件已存在则返回空字符串，否则返回新路径
			if(new_src.equals("")){
				new_src = ad_img_url;
			}
			//System.out.println(ad_type+ad_url+ad_img_url+ad_about);
			TopAdImg t_ad_img = t_ad.getAdimg() == null?new TopAdImg():t_ad.getAdimg();
			t_ad_img.setImgName(fileName);
			t_ad_img.setPath(new_src);
			t_ad_img.setTopad(t_ad);//设置图片和广告关联关系
			adImgDao.saveOrUpdate(t_ad_img);
			
			t_ad.setAdimg(t_ad_img);
			addao.saveOrUpdate(t_ad);//保存新闻对象
			
		}else if(ad_type == StaticParam.AD_BOTTOM){
			BottomAd b_ad ;
			List<BottomAd> all_b_ad = addao.listAd("BottomAd");
			if(all_b_ad.size() == 0){ //判断对象是否存在
				b_ad = new BottomAd();
				b_ad.setAbout(ad_about);
				b_ad.setUrl(ad_url);
				b_ad.setAbout(ad_about);
				addao.save(b_ad);
			}else{
				System.out.println(ad_url);
				b_ad = all_b_ad.get(0);
				b_ad.setAbout(ad_about);
				b_ad.setUrl(ad_url);
				b_ad.setAbout(ad_about);
			}
			
			//保存图片对象
			String fileName = ad_img_url.substring(ad_img_url.lastIndexOf("/")+1);
			new_src = ImgUtil.MoveAdImg(ad_type, ad_img_url, fileName); // 调用静态类方法移动文件，如果文件已存在则返回空字符串，否则返回新路径
			if(new_src.equals("")){
				new_src = ad_img_url;
			}
			BotAdImg b_ad_img = b_ad.getAdimg() == null?new BotAdImg():b_ad.getAdimg();
			b_ad_img.setImgName(fileName);
			b_ad_img.setPath(new_src);
			b_ad_img.setBotad(b_ad);//设置图片和广告关联关系
			adImgDao.saveOrUpdate(b_ad_img);
			
			b_ad.setAdimg(b_ad_img);
			addao.saveOrUpdate(b_ad);//保存新闻对象
		}else{
			SideAd s_ad;
			List<SideAd> all_s_ad = addao.listAd("SideAd");
			if(all_s_ad.size() == 0){ //判断对象是否存在
				s_ad = new SideAd();
				s_ad.setAbout(ad_about);
				s_ad.setUrl(ad_url);
				s_ad.setAbout(ad_about);
				addao.save(s_ad);
			}else{
				s_ad = all_s_ad.get(0);
				System.out.println(ad_url);
				s_ad.setAbout(ad_about);
				s_ad.setUrl(ad_url);
				s_ad.setAbout(ad_about);
			}
			
			//保存图片对象
			String fileName = ad_img_url.substring(ad_img_url.lastIndexOf("/")+1);
			new_src = ImgUtil.MoveAdImg(ad_type, ad_img_url, fileName); // 调用静态类方法移动文件，如果文件已存在则返回空字符串，否则返回新路径
			if(new_src.equals("")){
				new_src = ad_img_url;
			}
			SideAdImg s_ad_img = s_ad.getAdimg() == null?new SideAdImg():s_ad.getAdimg();
			s_ad_img.setImgName(fileName);
			s_ad_img.setPath(new_src);
			s_ad_img.setSidead(s_ad);//设置图片和广告关联关系
			adImgDao.saveOrUpdate(s_ad_img);
			
			s_ad.setAdimg(s_ad_img);
			addao.saveOrUpdate(s_ad);//保存新闻对象
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

	public void setJson_ad(JSONObject json_ad) {
		this.json_ad = json_ad;
	}

	public TopAd getT_ad() {
		return t_ad;
	}

	public void setT_ad(TopAd t_ad) {
		this.t_ad = t_ad;
	}

	public BottomAd getB_ad() {
		return b_ad;
	}

	public void setB_ad(BottomAd b_ad) {
		this.b_ad = b_ad;
	}

	public SideAd getS_ad() {
		return s_ad;
	}

	public void setS_ad(SideAd s_ad) {
		this.s_ad = s_ad;
	}
	
}
