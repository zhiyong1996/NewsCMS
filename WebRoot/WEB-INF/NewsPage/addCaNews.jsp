<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加新闻</title>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/plugins/font-awesome/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body style="padding:30px;">
  <div class="top" style="display: fixed;top: 0;left: 0;">
  	<button class="layui-btn" onclick="history.go(-1)"><i class="fa fa-angle-double-left" aria-hidden="true"></i>  返回</button>
  </div>
  <div class="layui-container">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  	 <legend>新建轮播新闻</legend>
	</fieldset>
	<s:debug/>
  <div class="layui-row">
      <form class="layui-form" action="" method="post" id="article">
        <div class="layui-form-item">
          <label class="layui-form-label">新闻标题</label>
          <div class="layui-input-block">
            <input id="title" type="text" name="title" required  lay-verify="required" maxlength="20" placeholder="请输入标题" autocomplete="off" class="layui-input">
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">新闻类型</label>
          <div class="layui-input-block">
            <s:select name="catagery" id="catagery" lay-filter="test" list="category" listKey="key" listValue="value" headerKey="-1" headerValue="请选择分类" emptyOption="true"></s:select>
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">来源</label>
          <div class="layui-input-block">
            <input id="newsfrom" type="text" name="newsfrom" required  lay-verify="required" maxlength="15" placeholder="新闻来源" autocomplete="off" class="layui-input">
          </div>
        </div>
        <!-- 上传轮播大图 -->
        <div class="layui-form-item">
          <label class="layui-form-label">封面</label>
          <div class="layui-input-block">
            <div class="layui-upload">
			  <button type="button" class="layui-btn" id="caimg">上传封面图片</button>
			  <div class="layui-upload-list">
			    <img class="layui-upload-img" id="imgPre" style="width: 450px; height: 250px;">
			    <p id="demoText"></p>
			  </div>
			</div> 
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
	</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
<script type="text/javascript">
layui.use(["form","layedit","upload"], function(){
	  var form = layui.form,
	  layedit = layui.layedit,
	  upload = layui.upload;
	  layedit.set({
		  uploadImage: {
		    url: 'upload/uploadNewsImg' //接口url
		    ,type: 'post' //默认post
		  }
		});
  
	  //编辑器 start 
	  var edit = layedit.build('demo', {
		  tool: ['strong','italic','underline','del','|','left', 'center', 'right', '|', 'link','unlink','image'] //设置工具条
	  	 ,height: 500 //设置高度
	  }); //建立编辑器 end
	  
	//轮播图片上传
	  var uploadInst = upload.render({
	    elem: '#caimg'
	    ,url: 'upload/uploadNewsImg'
	    ,before: function(obj){
	      //预读本地文件示例，不支持ie8
	      obj.preview(function(index, file, result){
	        $('#imgPre').attr('src', result); //图片链接(base64)
	      });
	    }
	    ,done: function(res){
	      //如果上传失败
	      $('#imgPre').attr('src', res.data.src);
	      //上传成功
	    }
	    ,error: function(){
	      //演示失败状态，并实现重传
	      var demoText = $('#demoText');
	      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
	      demoText.find('.demo-reload').on('click', function(){
	        uploadInst.upload();
	      });
	    }
	  });
		
	  //监听新闻分类选择框 start
	  var cid = -1;//分类id
	  form.on("select(test)", function(data){
		  cid = data.value;
		});
	  //监听新闻分类选择框 end
	  
	  //监听提交按钮 start
	  $("#submit").on("click",function(e){
		  e.preventDefault();
		  
		 var title = $("#title").val()
		 	,caSrc = $("#imgPre").attr("src")
		 	,newsfrom = $("#newsfrom").val()
		  	,content = layedit.getContent(edit).replace(/\"/g,"'");//获取正文内容并替换双引号为单引号
		  	
		 if(content == ""){
			  layer.msg("请填写新闻内容");
			  return ;
		  }s
		  	
		 	if(content.indexOf("<p>") == -1){
				  console.log("无p标签包裹");
				  content = "<p>"+content+"</p>"
			  }else{
				  console.log("有p标签包裹");
			  }
		  	
		 	var imgs = $(content).find("img"),//将正文转换成jq对象并获取img
			 
		      pathList = [],//本地上传图片路径集合
		      netList = [], //网络图片路径集合
		      src = "";     //单个图片路径
		      
			if(imgs.length>0){
			  for(var i=0;i<imgs.length;i++){
				if($(imgs[i]).attr("datatype") == "Nupload"){
					src = $(imgs[i]).attr("src");
					src = src.substring(src.indexOf("\NewsCMS")-1); //去除图片src中协议，域名和端口号，只保留文件引用路径
					pathList.push(src);
				}else{
					src = $(imgs[i]).attr("src");
					netList.push(src);
				}
			  }
				pathList = pathList.join(",");
				netList = netList.join(",");
				console.log("pathList:"+pathList)
			}else{
				pathList = "";
				netList = "";
			}

		  	if(parseInt(cid)<1||title==""||newsfrom==""){
		  		layer.msg("请选择新闻分类");
		  		return;
		  	}else if(caSrc === "" || caSrc === undefined ||caSrc === null){
		  		layer.msg("请选择新闻封面图片");
		  		return;
		  	}

		 $.ajax({
				type:"post",
				url:"news/add_news",
				dataType:"html",
				data:{
					title: title
					,cid: cid
					,newsfrom: newsfrom
					,content: content
					,caSrc: caSrc
					,newstype: 1
					,pathList: pathList
					,netList: netList
				},
				success:function(data){
					layer.msg("添加成功,3秒后自动跳转");
					setTimeout(function(){
						location.href = location.origin+"/NewsCMS/select_news"
						},3000);
				},
				error:function(){
					layer.msg("网络出错");
				}
			});//ajax
	  });
	  //监听提交 end
	});
</script>
  </body>
</html>
