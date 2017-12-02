package com.zzy.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ImageAction extends ActionSupport{
	private final String newsPath = "\\data\\NewsImg";
	private final String userPath = "\\data\\UserImg";
	private final String adPath = "\\data\\AdImg";
	private String fileFileName;  //图片文件名字
	private String fileContentType;  //文件类型
	private File file;  //上传的文件本体
	private String Path;  //路径
	
	private String newsHide; //隐藏信息
	
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
		
		InputStream is = new FileInputStream(getFile());
		OutputStream os = new FileOutputStream(filePath);
		byte buffer[] = new byte[1024];
		int len = 0;
		while((len = is.read(buffer))>0)
			os.write(buffer, 0, len);
		is.close();
		os.close();
		
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

	public String getNewsHide() {
		return newsHide;
	}

	public void setNewsHide(String newsHide) {
		this.newsHide = newsHide;
		System.out.println(newsHide);
	}
	
	
	
}
