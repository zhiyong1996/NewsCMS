package com.zzy.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zzy.po.Avatar;
import com.zzy.po.User;
import com.zzy.service.AvatarService;
import com.zzy.service.ImageService;
import com.zzy.service.NewsService;
import com.zzy.service.UserService;

@SuppressWarnings("serial")
public class ImageAction extends ActionSupport{
	@Resource ImageService imgService;
	@Resource NewsService nService;
	@Resource UserService uService;
	@Resource AvatarService avaService;
	
	private final String temporaryPath = "upload"; //新闻图片暂存一级目录
	private final String userPath = "UserImg"; //用户图片路径
	//private final String adPath = "\\data\\AdImg";     //广告图片路径
	private String fileFileName;  //图片文件名字
	private String fileContentType;  //文件类型
	private File file;  //上传的文件本体
	private String Path;  //路径
	private Date today;  //当天日期，主要用于创建文件目录
	
	private String createId; //新闻的createId，标识是哪一篇新闻的
	
	private Integer uid;
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
		
		//创建临时图片存储目录
		today = new Date();
		String secondPath = (new SimpleDateFormat("yyyyMM")).format(today).toString();
		String thirdPath = (new SimpleDateFormat("dd")).format(today).toString();
		String savePath = "\\"+temporaryPath+"\\"+secondPath+"\\"+thirdPath;		
		File file = new File(getSavePath()+savePath);
		if(!file.isDirectory()){
			file.mkdirs();
		}
		
		//设置图片名字和类型，图片临时保存路径
		String type = fileFileName.substring(fileFileName.lastIndexOf("."));
		String fileName = "NIMG"+(new SimpleDateFormat("yyyyMMddHHmmssSSS")).format(today)+type;
		String filePath = getSavePath()+savePath+"\\"+fileName;//文件保存的绝对路径包含文件名
		
		//开启文档流,暂存图片到服务器临时目录
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
	
	public String uploadUserImg() throws IOException{
		today = new Date();
		String savePath = "\\"+userPath+"\\"+uid;
		
		File file = new File(getSavePath()+savePath);
		if(!file.isDirectory()){
			file.mkdirs();
		}
		
		//设置文件名和路径
		System.out.println("fileFileName:"+fileFileName+uid+fileContentType);
		String type = fileFileName.substring(fileFileName.lastIndexOf("."));
		String fileName = "UIMG"+StaticParam.DateFormat1.format(today)+type;
		String filePath = getSavePath()+savePath+"\\"+fileName;//文件保存的绝对路径包含文件名
		
		//开启文档流,将图片存储到服务器文件夹
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
		String imgSrc = ServletActionContext.getRequest().getContextPath()+"/"+userPath+"/"+uid+"/"+fileName;
		
		User user = uService.getUserById(uid);
		System.out.println("uid"+uid);
		Avatar av = user.getAvatar();
		if(av == null){
			av = new Avatar();
		}
		av.setImgName(fileName);
		av.setPath(imgSrc);
		avaService.saveOrUpdate(av);
		user.setAvatar(av);
		uService.saveOrUpdate(user);
		ActionContext.getContext().getSession().put("user", user);
		
		imgJson = new JSONObject();
		imgJson.put("status", true);
		imgJson.put("imgUrl", imgSrc);
		
		return "uploadUserImg";
	}
	
	public String deleteImg(){
		return "deleteImg";
	}
	
	public String excute(){
		System.out.println("执行excute方法");
		return "excute";
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

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}
	
	
	
}
