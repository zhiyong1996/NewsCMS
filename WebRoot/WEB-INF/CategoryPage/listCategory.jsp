<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML">
<html>
  <head>
    <title>新闻列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body style="padding:30px;">
	<form class="layui-form" action="" style="width:100%;">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">新增类型:</label>
				<div class="layui-input-inline">
					<input type="text" name="categoryName" id="categoryName" lay-verify="required" autocomplete="off" class="layui-input"/>
				</div>
			</div>
			<div class="layui-inline">
				<div class="layui-input-inline">
					<button class="layui-btn" lay-submit="" lay-filter="submitC">立即提交</button>
				</div>
			</div>
		</div>
	</form>
	
	<table class="layui-table" lay-filter="table" id="table"></table>

	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
	
	<!-- 序列号模板引擎 -->
	<script type="text/html" id="indexTpl">
    	{{parseInt(d.LAY_TABLE_INDEX+1)}}
	</script>

	<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
	<script>
		layui.use(["table","form"], function(){
		  var $ = layui.jquery;
		  var table = layui.table;
		  var form = layui.form;
		  
		  //方法级渲染表格
		  table.render({
			  elem: "#table"
			  ,url: "category/pageCategory"
			  ,cellMinWidth: 60
			  ,cols: [[
				   {title: "序号",width: 60,fixed: true,templet: "#indexTpl"}  
				  //,{field: "cid", title: "ID", width: 60, sort: true,fixed: true}
			      ,{field: "cName", title: "新闻类型(点击可编辑)", width: 280, align: "center",edit: "text"}		  		  ,{field: "createTime", title: "创建时间", width: 160, align: "center"}
		  		  ,{field: "updateTime", title: "更新时间", width: 160, align: "center"}
			      ,{fixed: "right", title: "操作", width:160, align:"center", toolbar: "#barDemo"}
			        ]]
		  	  ,id: "Reload"
			  ,page:true
			  , height:"full"
		  });
		  
		  //监听单元格编辑
		  table.on("edit(table)", function(obj){
		    var value = obj.value //得到修改后的值
		    ,data = obj.data //得到所在行所有键值
		    ,field = obj.field; //得到字段
		    console.log('[ID: '+ data.cid +'] ' + field + ' 字段更改为：'+ value);
		    console.log(obj);
		    
		    if(value=="" || value==undefined){
		    	layer.msg("不能为空");
		    	return false;
		    }
		    
		    $.ajax({
				type:"post",
				url:"category/updateCategory",
				dataType:"html",
				data:{
					cid: obj.data.cid,
					categoryName: value
				},
				success:function(data){
					layer.msg("更新成功");
				},
				error:function(){
					layer.msg("网络出错");
				}
			});//ajax end 

		  });
		  
		  //监听工具条
		  table.on("tool(table)", function(obj){
		    var data = obj.data;
		    if(obj.event === 'del'){
		      layer.confirm("警告,删除该分类会连同该分类所有新闻一起删除", function(index){
		    	layer.close(index);
		        $.ajax({
		        	type: "post",
		        	url: "category/delCategory",
		        	dataType: "html",
		        	data: {
		        		cid: data.cid
		        	},
		        	success: function(data){     		
		        		console.log(data);
		        		layer.msg("删除成功");
		        		obj.del();
		        	},
		        	error: function(){
		        		layer.msg("删除失败");
		        	}
		        });//ajax end  
		      });  
		    } 
		  });
		
		  //监听提交新类型
		  form.on("submit(submitC)", function(data){
		    console.log(data);
		    
		    $.ajax({
				type:"post",
				url:"category/addCategory",
				dataType:"html",
				data:data.field,
				success:function(data){
					layer.msg("添加成功,3秒后自动更新");
					table.reload('table', {
			          page: {
			            curr: 1 //重新从第 1 页开始
			          }
			        });
				},
				error:function(){
					layer.msg("网络出错");
				}
			});
		    return false;
		  });
		});
	</script>
  </body>
</html>
