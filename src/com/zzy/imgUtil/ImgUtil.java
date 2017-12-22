package com.zzy.imgUtil;

import java.io.File;

import org.apache.struts2.ServletActionContext;

public class ImgUtil {
	private static String N_fileName = "NewsImg";//保存新闻图片的文件夹
	//获取服务器绝对路径
	@SuppressWarnings("deprecation")
	public static String getSavePath(){
		return ServletActionContext.getRequest().getRealPath("");
	}
	
	/*
	 * 该方法是将图片文件从临时目录移动到保存目录
	 * 传进三个参数：
	 * @param nid：新闻id，用于命名文件夹，文件夹下保存该新闻id对应的新闻的图片
	 * @param linkSrc：当前图片的引用路径，分两种情况，1是图片新上传的目前在暂存目录里，linkSrc就是暂存目录的引用路径，
	 *                 2是图片已经在保存目录，linkSrc就是保存目录的引用路径是，所以方法应该先判断文件是属于哪种情况
	 * @param filename: 目标文件名
	 * */
	public static String moveFile(Integer nid,String linkSrc,String filename){
		String source_path = getSavePath()+linkSrc.replaceAll("/", "\\\\");
		String target_path = getSavePath()+"\\"+N_fileName+"\\"+nid;
		String target_source = target_path+"\\"+filename;
		System.out.println("目标"+target_source);
		File f = new File(target_path);
		
		if(new File(target_source).exists()){//如果图片已经存在就返回空字符串，否则返回新的图片引用路径
			return "";
		}else{
			if(!f.isDirectory()){//如果目录不存在就创建目录
				
					boolean y1 = f.mkdirs();
					System.out.println("创建新目录"+y1);
					File s = new File(source_path);
					File t = new File(target_path);
					
					boolean y2 = s.renameTo(t);
					System.out.println("移动到新目录1"+y2);
					return ServletActionContext.getRequest().getContextPath()+"/"+N_fileName+"/"+nid+"/"+filename;
				
			}else{
				
					File s = new File(source_path);
					File t = new File(target_path+"\\"+filename);
					
					boolean y2 = s.renameTo(t);
					System.out.println("移动到新目录1"+y2);
					return ServletActionContext.getRequest().getContextPath()+"/"+N_fileName+"/"+nid+"/"+filename;
				
			}
		}
		
	}
}
