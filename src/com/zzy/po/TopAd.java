package com.zzy.po;

public class TopAd {
	private Integer id;
	private String company;
	private String about;
	private TopAdImg adimg;
	private String url;
	private Boolean issue;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public TopAdImg getAdimg() {
		return adimg;
	}
	public void setAdimg(TopAdImg adimg) {
		this.adimg = adimg;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Boolean getIssue() {
		return issue;
	}
	public void setIssue(Boolean issue) {
		this.issue = issue;
	}
	public String getAbout() {
		return about;
	}
	public void setAbout(String about) {
		this.about = about;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	
	
}
