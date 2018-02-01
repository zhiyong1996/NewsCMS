package com.zzy.po;

public class Advertisement {
	private Integer id;
	private String describe;
	private AdImg adimg;
	private String url;
	private Integer position;
	private Boolean show;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public AdImg getAdimg() {
		return adimg;
	}
	public void setAdimg(AdImg adimg) {
		this.adimg = adimg;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getPosition() {
		return position;
	}
	public void setPosition(Integer position) {
		this.position = position;
	}
	public Boolean getShow() {
		return show;
	}
	public void setShow(Boolean show) {
		this.show = show;
	}
	
	
}
