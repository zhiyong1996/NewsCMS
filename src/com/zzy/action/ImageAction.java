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
	
	private final String temporaryPath = "upload"; //新闻图片暂存一级目录
	private final String userPath = "\\data\\UserImg"; //用户图片路径
	private final String adPath = "\\data\\AdImg";     //广告图片路径
	private String fileFileName;  //图片文件名字
	private String fileContentType;  //文件类型
	private File file;  //上传的文件本体
	private String Path;  //路径
	private Date today;  //当天日期，主要用于创建文件目录
	
	private String createId; //新闻的createId，标识是哪一篇新闻的
	
	private JSONObject imgJson;
	
	//获取服务器绝对路径
	@SuppressWarnings("deprecation")
	public String getSavePath(){
		return ServletActionContext.getRequest().getRealPath("");
	}
	
	/* @param fileName 文件名
	 * @param filePath文件保存路径
	 * @param secondPath 新闻图片暂存二级目录名 ,以年月为名字:2017/12
	 * @param thirdPath 新闻图片暂存三级目录名,二级目录之下,以日期为名字: 01~29/30/31
	 * */
	public String uploadNewsImg() throws Exception{
		
		//创建图片存储目录
		today = new Date();
		String secondPath = (new SimpleDateFormat("yyyyMM")).format(today).toString();
		String thirdPath = (new SimpleDateFormat("dd")).format(today).toString();
		String savePath = "\\"+temporaryPath+"\\"+secondPath+"\\"+thirdPath;		
		File file = new File(getSavePath()+savePath);
		if(!file.isDirectory()){
			file.mkdirs();
		}
		
		//设置图片名字和类型，获取图片保存路径
		String type = fileFileName.substring(fileFileName.lastIndexOf("."));
		String fileName = "NIMG"+(new SimpleDateFormat("yyyyMMddHHmmssSSS")).format(today)+type;
		String filePath = getSavePath()+savePath+"\\"+fileName;
		
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
		
		//前端返回的图片引用路径src
		String imgSrc = ServletActionContext.getRequest().getContextPath()+"/"+temporaryPath+"/"+secondPath+"/"+thirdPath+"/"+fileName;
		System.out.println(imgSrc);
		System.out.println(filePath);
		
		//设置保存信息
		JSONObject data = new JSONObject();
		data.put("src",imgSrc);
		data.put("title", fileFileName);
		
		imgJson = new JSONObject();
		imgJson.put("code", 0);
		imgJson.put("msg", "");
		imgJson.put("data", data);
		return "uploadNewsImg";
	}
	
	public String deleteImg(){
		return "deleteImg";
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
