package com.zzy.action;

import java.io.IOException;
import java.util.ArrayList;
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
import com.zzy.service.AdService;

@SuppressWarnings("serial")
public class AdvertiseAction extends ActionSupport{
	@Resource AdDao addao;
	@Resource AdService adService;
	@Resource AdImgDao adImgDao;
	
	//服务端接收数据
	private Integer ad_id;
	private Integer ad_type;
	private String ad_about;
	private String ad_url;
	private String ad_img_url;
	private String ad_company;
	private Integer page;
	private Integer limit;
	private boolean issue;
	
	//服务器返回数据
	private JSONObject json_ad;
	
	private JSONObject json_top;
	private JSONObject json_bot;
	private JSONObject json_side;
	
	private TopAd t_ad;
	private BottomAd b_ad;
	private SideAd s_ad;
	
	public String ad_manager(){
		/*List<TopAd> top = addao.listAd("TopAd");
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
		}*/
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
	
	public String ad_update() throws IOException{
		String new_src;//新的图片路径
		if(ad_type == StaticParam.AD_TOP){
			TopAd t_ad ;
			if(ad_id == 0){ //判断对象是否存在
				t_ad = new TopAd();
				t_ad.setAbout(ad_about);
				t_ad.setUrl(ad_url);
				t_ad.setAbout(ad_about);
				t_ad.setCompany(ad_company);
				t_ad.setIssue(false);
				addao.save(t_ad);
			}else{
				t_ad = addao.getTopById(ad_id);
				t_ad.setAbout(ad_about);
				t_ad.setUrl(ad_url);
				t_ad.setAbout(ad_about);

				t_ad.setCompany(ad_company);
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
			if(ad_id == 0){ //判断对象是否存在
				b_ad = new BottomAd();
				b_ad.setAbout(ad_about);
				b_ad.setUrl(ad_url);
				b_ad.setAbout(ad_about);
				b_ad.setIssue(false);
				b_ad.setCompany(ad_company);
				addao.save(b_ad);
			}else{
				System.out.println(ad_url);
				b_ad = addao.getBotById(ad_id);
				b_ad.setAbout(ad_about);
				b_ad.setUrl(ad_url);
				b_ad.setAbout(ad_about);

				b_ad.setCompany(ad_company);
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
			if(ad_id == 0){ //判断对象是否存在
				s_ad = new SideAd();
				s_ad.setAbout(ad_about);
				s_ad.setUrl(ad_url);
				s_ad.setAbout(ad_about);
				s_ad.setIssue(false);
				s_ad.setCompany(ad_company);
				addao.save(s_ad);
			}else{
				s_ad = addao.getSideById(ad_id);
				System.out.println(ad_url);
				s_ad.setAbout(ad_about);
				s_ad.setUrl(ad_url);
				s_ad.setAbout(ad_about);

				s_ad.setCompany(ad_company);
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
		json_ad.put("status", true);
		json_ad.put("msg","success");
		
		return "update_ad";
	}
	
	public String listTopAd(){
		json_top = new JSONObject();
		int offset = (page - 1) * limit;
		List<TopAd> t_ad = addao.listAd("TopAd");
		System.out.println(t_ad+":"+t_ad.size());
		ArrayList<JSONObject> arrData = new ArrayList<JSONObject>();
		JSONObject data;
		for (TopAd ad : t_ad) {
			data = new JSONObject();
			System.out.println("id======="+t_ad);
			data.put("id",ad.getId());
			data.put("company",ad.getCompany());
			data.put("about",ad.getAbout());
			data.put("url",ad.getUrl());
			data.put("issue",ad.getIssue());
			arrData.add(data);
		}
		json_top.put("code", 0);
		json_top.put("msg", "");
		json_top.put("count", t_ad.size());
		json_top.put("data", arrData);
		return "list_top";
	}
	
	public String listBotAd(){
		json_bot = new JSONObject();
		int offset = (page - 1) * limit;
		List<BottomAd> b_ad = addao.listAd("BottomAd");
		ArrayList<JSONObject> arrData = new ArrayList<JSONObject>();
		JSONObject data;
		for (BottomAd ad : b_ad) {
			data = new JSONObject();
			data.put("id",ad.getId());
			data.put("company",ad.getCompany());
			data.put("about",ad.getAbout());
			data.put("url",ad.getUrl());
			data.put("issue",ad.getIssue());
			arrData.add(data);
		}
		json_bot.put("code", 0);
		json_bot.put("msg", "");
		json_bot.put("count", b_ad.size());
		json_bot.put("data", arrData);
		return "list_bot";
	}
	
	public String listSideAd(){
		json_side = new JSONObject();
		int offset = (page - 1) * limit;
		List<SideAd> s_ad = addao.listAd("SideAd");
		ArrayList<JSONObject> arrData = new ArrayList<JSONObject>();
		JSONObject data;
		for (SideAd ad : s_ad) {
			data = new JSONObject();
			data.put("id",ad.getId());
			data.put("company",ad.getCompany());
			data.put("about",ad.getAbout());
			data.put("url",ad.getUrl());
			data.put("issue",ad.getIssue());
			arrData.add(data);
		}
		json_side.put("code", 0);
		json_side.put("msg", "");
		json_side.put("count", s_ad.size());
		json_side.put("data", arrData);
		return "list_side";
	}
	
	public String go_new_ad(){
		if(ad_type==StaticParam.AD_TOP){
			return "go_new_top";
		}else if(ad_type==StaticParam.AD_BOTTOM){
			return "go_new_bot";
		}else{
			return "go_new_side";
		}
	}
	
	//查询更新广告
	public String go_update_ad(){
		if(ad_type==StaticParam.AD_TOP){
			t_ad = addao.getTopById(ad_id);
			return "go_update_top";
		}else if(ad_type==StaticParam.AD_BOTTOM){
			b_ad = addao.getBotById(ad_id);
			return "go_update_bot";
		}else{
			s_ad = addao.getSideById(ad_id);
			return "go_update_side";
		}	
	}
	
	public String ad_switch(){
		json_ad = new JSONObject();
		if(ad_type==StaticParam.AD_TOP){
			t_ad = addao.getTopById(ad_id);
			t_ad.setIssue(issue);
			addao.saveOrUpdate(t_ad);
		}else if(ad_type==StaticParam.AD_BOTTOM){
			b_ad = addao.getBotById(ad_id);
			b_ad.setIssue(issue);
			addao.saveOrUpdate(b_ad);
		}else{
			s_ad = addao.getSideById(ad_id);
			s_ad.setIssue(issue);
			addao.saveOrUpdate(s_ad);
		}
		
		json_ad.put("status",true);
		return "ad_switch";
	}
	
	public String delete_ad(){
		if(ad_type==StaticParam.AD_TOP){
			t_ad = addao.getTopById(ad_id);
			addao.delete(t_ad);
		}else if(ad_type==StaticParam.AD_BOTTOM){
			b_ad = addao.getBotById(ad_id);
			addao.delete(b_ad);
		}else{
			s_ad = addao.getSideById(ad_id);
			addao.delete(s_ad);
		}
		json_ad = new JSONObject();
		json_ad.put("status",true);
		return "delete_ad";
	}
	
	/*
	 * 
	 * 根对象setter 和getter
	 * 
	 * */
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

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public String getAd_company() {
		return ad_company;
	}

	public void setAd_company(String ad_company) {
		this.ad_company = ad_company;
	}

	public JSONObject getJson_top() {
		return json_top;
	}

	public void setJson_top(JSONObject json_top) {
		this.json_top = json_top;
	}

	public JSONObject getJson_bot() {
		return json_bot;
	}

	public void setJson_bot(JSONObject json_bot) {
		this.json_bot = json_bot;
	}

	public JSONObject getJson_side() {
		return json_side;
	}

	public void setJson_side(JSONObject json_side) {
		this.json_side = json_side;
	}

	public Integer getAd_id() {
		return ad_id;
	}

	public void setAd_id(Integer ad_id) {
		this.ad_id = ad_id;
	}

	public boolean getIssue() {
		return issue;
	}

	public void setIssue(boolean issue) {
		this.issue = issue;
	}
	
}
