package com.zzy.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.News;
import com.zzy.po.NewsImg;
import com.zzy.service.ImageService;
import com.zzy.service.NewsService;

@SuppressWarnings("serial")
public class ImageAction extends ActionSupport{
	@Resource ImageService imgService;
	@Resource NewsService nService;
	
	private final String newsPath = "\\data\\NewsImg"; //新闻图片路径
	private final String userPath = "\\data\\UserImg"; //用户图片路径
	private final String adPath = "\\data\\AdImg";     //广告图片路径
	private String fileFileName;  //图片文件名字
	private String fileContentType;  //文件类型
	private File file;  //上传的文件本体
	private String Path;  //路径
	
	private String createId; //隐藏信息,新闻的createId
	
	private JSONObject imgJson;
	
	@SuppressWarnings("deprecation")
	public String getSavePath(){
		return ServletActionContext.getRequest().getRealPath("");
	}
	
	public String uploadNewsImg() throws Exception{
		File file = new File(getSavePath()+newsPath);
		if(!file.isDirectory()){
			file.mkdirs();
		}
		
		String type = fileFileName.substring(fileFileName.lastIndexOf("."));
		String fileName = (new SimpleDateFormat("yyyyMMddHHmmssSSS")).format(new Date())+type;
		String filePath = getSavePath()+newsPath+"\\"+fileName;
		//String pathData = newsPath+"\\"+fileName;
		NewsImg newsImg = new NewsImg();
		newsImg.setName(fileName);
		newsImg.setPath(filePath);
		newsImg.setNews((News)nService.getByCreateId(createId).get(0));
		imgService.save(newsImg);
		
		//开启文档流,保存图片到服务器
		InputStream is = new FileInputStream(getFile());
		OutputStream os = new FileOutputStream(filePath);
		byte buffer[] = new byte[1024];
		int len = 0;
		while((len = is.read(buffer))>0)
			os.write(buffer, 0, len);
		is.close();
		os.close();
		//关闭文档流
		
		System.out.println(ServletActionContext.getRequest().getContextPath()+"/data/NewsImg/"+fileName);
		System.out.println(filePath);
		//设置保存信息
		JSONObject data = new JSONObject();
		data.put("src",ServletActionContext.getRequest().getContextPath()+"/data/NewsImg/"+fileName);
		data.put("title", fileFileName);
		
		imgJson = new JSONObject();
		imgJson.put("code", 0);
		imgJson.put("msg", "");
		imgJson.put("data", data);
		return "uploadNewsImg";
	}
	
	public String uploadUserImage(){
		return "uploadUserImage";
	}
	
	public String uploadAdvertiseImage(){
		return "uploadAdvertiseImage";
	}
	
	public String getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	public String getFileType() {
		return fileContentType;
	}
	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	public String getPath() {
		return Path;
	}
	public void setPath(String path) {
		Path = path;
	}

	public JSONObject getImgJson() {
		return imgJson;
	}

	public void setImgJson(JSONObject imgJson) {
		this.imgJson = imgJson;
	}

	public String getCreateId() {
		return createId;
	}

	public void setCreateId(String createId) {
		this.createId = createId;
		System.out.println(createId);
	}
	
	
	
}
