<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
  <head> 
    <title>更新新闻</title>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body style="padding:30px;">
  <div class="layui-container">
  
  <div class="layui-row">
      <form class="layui-form" action="" method="post">
        <div class="layui-form-item">
          <input type="hidden" value="${update.createId}" id="createId" name="createId"/>
          <label class="layui-form-label">新闻标题</label>
          <div class="layui-input-block">
            <input id="title" type="text" name="title" value="${update.title}" required  lay-verify="required" maxlength="15" placeholder="请输入标题" autocomplete="off" class="layui-input">
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">新闻类型</label>
          <div class="layui-input-block">
            <s:select name="catagery" lay-filter="test" list="category" listKey="key" listValue="value" headerKey="-1" headerValue="请选择分类" emptyOption="true" value="%{#update.category.id}"></s:select>
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">来源</label>
          <div class="layui-input-block">
            <input id="newsfrom" type="text" name="newsfrom" value="${update.newsfrom}" required  lay-verify="required" maxlength="15" placeholder="作者" autocomplete="off" class="layui-input">
          </div>
        </div>
        <div class="layui-form-item">
        	<label class="layui-form-label">正文</label>
        	<div class="layui-input-block">
        		<textarea id="demo" style="display: none;"></textarea>
        	</div>
        </div>
        <div class="layui-form-item">
          <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" id="submit">立即提交</button>
          </div>
        </div>
      </form>
    </div>
	<!-- <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
	  		<legend>选择新闻图片</legend>
		</fieldset>
	
		<div class="layui-upload">
		  <button type="button" class="layui-btn" id="newsImg"><i class="layui-icon"></i>上传图片</button>
		  <div class="layui-upload-list">
		    <img class="layui-upload-img" id="preview">
		    <p id="demoText"></p>
		  </div>
		</div> -->
	</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
<script type="text/javascript">

(function(){
	var content = $("#demo").val("${update.content}");
})();
layui.use(["form","layedit","upload"], function(){
	  var form = layui.form,
	  layedit = layui.layedit;
	  //upload = layui.upload;
	  //设置图片上传接口
	  layedit.set({
		  uploadImage: {
		    url: 'upload/uploadNewsImg' //接口url
		    ,type: 'post' //默认post
		  }
		});
	  
	  var edit = layedit.build('demo', {
		  tool: ['strong','italic','underline','del','|','left', 'center', 'right', '|', 'link','unlink','image'] //设置工具条
	  	 ,height: 500 //设置高度
	  }); //建立编辑器
	  var cid = "${update.category.id}"|| -1;
	  form.on("select(test)", function(data){
		  cid = data.value;
		}); 
		
	  var sub = $("#submit");
	  sub.addEventListener("click",function(e){
			  e.preventDefault();
			  
			  var newsid = "${update.id}"
			  	,title = $("#title").val()
			 	,newsfrom = $("#newsfrom").val()
			  	,content = layedit.getContent(edit).replace(/\"/g,"'");//获取正文内容并替换双引号为单引号
			  	
			  if(content.indexOf("<img") == 0){
				  console.log("无p标签包裹");
				  content = "<p>"+content+"</p>"
			  }else{
				  console.log("有p标签包裹");
			  }
			  	
			  var imgs = $(content).find("img"),//将正文转换成jq对象并获取img
			 
			  	  //allPath = [], //全部图片路径
			      pathList = [],//本地上传图片路径集合
			      src = "";     //单个图片路径
			      console.log(content);
			      console.log($(content));
			      console.log(imgs);
			      
				if(imgs.length>0){
				  for(var i=0;i<imgs.length;i++){
					src = $(imgs[i]).attr("src");
					//allPath.push(src);
					src = src.substring(src.indexOf("\NewsCMS")-1); //去除图片src中协议，域名和端口号，只保留文件引用路径
					if($(imgs[i]).attr("datatype") == "Nupload"){
						pathList.push(src);
					}
				  }
					pathList = pathList.join(",");
					//allPath = allPath.join(",");
					console.log("pathList:"+pathList)
					//console.log("allPath:"+allPath)
				}else{
					pathList = "";
					//allPath = "";
				}
			      
			  	if(title==""||newsfrom==""||parseInt(cid)<1){
			  		layer.msg("请选择新闻分类");
			  		return;
		  		}
			 
			 $.ajax({
					type:"post",
					url:"news/updateNews",
					dataType:"html",
					data:{
						newsid: newsid
						,createId: "${update.createId}"
						,title: title
						,cid: cid
						,content: content
						,newsfrom: newsfrom
						,pathList: pathList
						//,allPath: allPath
					},
					success:function(data){
						/*layer.msg("保存成功,3秒后自动跳转");
						setTimeout(function(){
							location.href = location.origin+"/NewsCMS/news/go_listN";
						},3000);*/

					},
					
					error:function(){
						layer.msg("网络出错");
					}
				});//ajax end
	   //});
	  });
	});
</script>
  </body>
</html>
