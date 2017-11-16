<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <categoryName>添加新闻</categoryName>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body style="padding:30px;">
  <div class="layui-container">
  <div class="layui-row">
      <form class="layui-form" action="" method="post">
        <div class="layui-form-item">
          <label class="layui-form-label">类型名</label>
          <div class="layui-input-block">
            <input id="categoryName" value="${updateC.title}" type="text" name="categoryName" required  lay-verify="required" maxlength="30" placeholder="请输入类型名" autocomplete="off" class="layui-input">
          </div>
        </div>
        <div class="layui-form-item">
          <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" id="submit">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
          </div>
        </div>
      </form>
    </div>
	</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
<script type="text/javascript">
layui.use(["form","layedit"], function(){
	  var form = layui.form;
		
	  var sub = document.getElementById("submit");
	  sub.addEventListener("click",function(e){
		  e.preventDefault();
		  
		 var categoryName = document.getElementById("categoryName").value;

		  	if(categoryName==""||newsfrom==""||content=="")
		  		return;
		 
		 $.ajax({
				type:"post",
				url:"category/updateCategory",
				dataType:"html",
				data:{
					categoryName: categoryName,
					createTime: ${updateC.createTime}
				},
				success:function(data){
					layer.msg("添加成功");
					this.location.href = location.origin+"/NewsCMS/CategoryPage/category/go_listC"
				},
				error:function(){
					layer.msg("网络出错");
				}
			});//ajax
	  });//eventListener
	});
</script>
  </body>
</html>
