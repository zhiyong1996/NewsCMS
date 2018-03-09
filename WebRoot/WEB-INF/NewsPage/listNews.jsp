<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>新闻列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  <style>
  	.head-select{
  		margin-top: 10px;
  	}
  	.head-select .layui-form{
  		float: left;
  		margin: 0 20px;
  	}
  	.head-select .layui-form:first-of-type{
  		margin-left: 0;
  	}
  	.head-select label{
  		width: auto;
  		padding-left: 0;
  	}
  	.head-select .layui-input-block{
  		margin-left: 74px;
  	}
  </style>
  <body style="padding:30px;">
    <div style="margin-bottom: 5px;">
	搜索标题：
	  <div class="layui-inline">
	    <input class="layui-input" name="id" id="demoReload" autocomplete="off">
	  </div>
	<div class="layui-btn-group demoTable">
	  <button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
	  <button class="layui-btn" data-type="Issue"><i class="layui-icon">&#xe619;</i>批量发布</button>
	  <button class="layui-btn layui-btn-warm" data-type="unIssue"><i class="layui-icon">&#xe61a;</i>批量下架</button>
	  <button class="layui-btn layui-btn-danger" data-type="batch_del"><i class="layui-icon">&#xe640;</i>批量删除</button>
	  <button class="layui-btn" data-type="refresh"><i class="layui-icon">&#x1002;</i></button>
	</div>
	<div class="head-select clearfix">
		<form class="layui-form">
			<div class="layui-form-item">
	        	<label class="layui-form-label">类型搜索</label>
	        	<div class="layui-input-block">
					<s:select name="catagery" id="catagery" lay-filter="cate-select" list="category" listKey="key" listValue="value" headerKey="-1" headerValue="请选择分类" emptyOption="true"></s:select>
				</div>
			</div>
		</form>
		<form class="layui-form">
			<div class="layui-form-item">
	        	<label class="layui-form-label">位置搜索</label>
	        	<div class="layui-input-block">
					<select lay-filter="news-position">
						<option value="-1">请选择</option> 
						<option value=""></option>
						<option value="1">普通</option>
						<option value="2">轮播</option>
						<option value="3">热点</option>					
					</select>
				</div>
			</div>
		</form>
	</div>

	<table class="layui-table" id="table" lay-filter="demo"></table>
	
	<!-- 工具栏模板引擎 -->
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">预览</a>
		<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="more">评论</a>
  		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
	
	<!-- 表格表单模板引擎 -->
	<script type="text/html" id="switchTpl">
  		<!-- 这里的 d为ajax获取到的数据对象 -->
  		<input type="checkbox" name="issue" value="{{d.id}}" lay-skin="switch" lay-text="on|off" lay-filter="issueDemo" {{ d.issue == true ? 'checked' : '' }}>
	</script>
	
	<!-- 序列号模板引擎 -->
	<script type="text/html" id="indexTpl">
    	{{parseInt(d.LAY_TABLE_INDEX+1)}}
	</script>
	
	<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
	<script>
	layui.use('table', function(){
	  var $ = layui.jquery;
	  var table = layui.table,
	  	  form = layui.form;
	  
	  //方法级渲染表格
	  table.render({
		  elem: "#table"
		  ,url: "list_news"
		  ,cols: [[
		      {checkbox: true,fixed: true}
		      ,{title: "序号",width: 60,fixed: true,templet: "#indexTpl",align: "center"}
		      ,{field: "id", title: "ID", width: 60, sort: true,align: "center"}
		      ,{field: "title", title: "标题", width: 280, align: "center"}
		      ,{field: "newsfrom", title: "来源", width: 100, align: "center"}
		      ,{field: "category", title: "类型", width: 60, align: "center"}
		      ,{field: "newstype", title: "位置", width: 60, align: "center"}
		      ,{field: "commentSize", title: "评论", width: 60, align: "center"}
		      //,{field: "createTime", title: "创建时间", width: 160, align: "center"}
		      //,{field: "updateTime", title: "更新时间", width: 160, align: "center"}
		      ,{field: "issue", title: "是否发布", width:100, align: "center", templet: "#switchTpl"}
		      ,{fixed: "right", title: "操作", width:250, align:"center", toolbar: "#barDemo"}

		        ]]
	  	  ,id: "table"
	  	  ,cellMinWidth: 85
		  ,page:true
		  , height: "full"
	  });
	  
	  //监听工具条
	  table.on('tool(demo)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'detail'){
	    	window.location.href = location.origin+"/NewsCMS/news_preview?newsid="+data.id;
	    	console.log(data.id);
	    } else if(obj.event === 'del'){
	      layer.confirm('确定删除该行么', function(index){
	    	layer.close(index);
	        $.ajax({
	        	type: "post",
	        	url: "news/del_news",
	        	dataType: "html",
	        	data: {
	        		newsid: data.id
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
	    } else if(obj.event === 'edit'){
	      window.location.href = location.origin+"/NewsCMS/go_update?newsid="+data.id;
	    }else if(obj.event === 'more'){
	    	window.location.href = location.origin+"/NewsCMS/news_comment?newsid="+data.id;
	    }
	  });
	  
	  //监听issue操作
	  form.on('switch(issueDemo)', function(obj){
		//console.log(obj);
	    //layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
	    $.ajax({
	        	type: "post",
	        	url: "news/issue_news",
	        	dataType: "html",
	        	data: {
	        		newsid: this.value,
	        		issue: obj.elem.checked
	        	},
	        	success: function(data){     		
	        		console.log(data);
	        		layer.msg("更新成功");
	        	},
	        	error: function(){
	        		layer.msg("更新失败");
	        	}
	        });//ajax end  
	  });
	  
	  //根据新闻分类重载
	  form.on('select(cate-select)', function(data){
		  var reloadvalue = data.value;
		  var reloadkey = "category";
		  if(reloadvalue > -1){
			  table.reload('table', {
		          page: {
		            curr: 1 //重新从第 1 页开始
		          },
		          where: {
		        	reloadvalue: reloadvalue,
		        	reloadkey: reloadkey
		          }
		        });
		  }else{
			  table.reload('table', {
		          page: {
		            curr: 1 //重新从第 1 页开始
		          },
		          where: {
					  reloadvalue: "",
				      reloadkey: ""
				  }
		        });
		  }
		});
	  
	  //根据新闻位置重载表格
	  form.on('select(news-position)', function(data){
		  var reloadvalue = data.value-1;
		  var reloadkey = "newsposition";

		  if(reloadvalue >=0){
			  console.log(reloadvalue);
			  table.reload('table', {
		          page: {
		            curr: 1 //重新从第 1 页开始
		          },
		          where: {
					  reloadvalue: reloadvalue,
				      reloadkey: reloadkey
				  }
		        });
		  }else{
			  console.log(reloadvalue);
			  table.reload('table', {
		          page: {
		            curr: 1 //重新从第 1 页开始
		          },
		          where: {
		        	  reloadvalue: "",
					  reloadkey: ""
				  }
		        });
		  }
	  });
	  //顶部按钮组的功能函数
	  var active = { //active start
		  Issue: function(){ //获取选中数目
	      var checkStatus = table.checkStatus("table")
	      	,data = checkStatus.data;
		  if(data.length == 0){
			  return;
		  }else{
			  var nids = [];
			  for(var i=0;i<data.length;i++){
				  nids.push(data[i].id);
			  }
			  nids = nids.join(",");
			  $.ajax({
				  type: "post",
				  url: "batch_handle",
				  data: {
					 nids:nids,
					 issue: true
				  },
				  success: function(data){
					  layer.msg(data);
					  setTimeout(function(){
						  table.reload('table', {
					          page: {
					            curr: 1 //重新从第 1 页开始
					          },
					          where: {
								  reloadvalue: "",
							      reloadkey: ""
							  }
						  });
					  },2000);
				  },
				  error: function(data){
					  layer.msg("网络出错，请稍候尝试");
				  }
			  });
		  }
	    }
	    ,unIssue: function(){ //获取选中数目
		      var checkStatus = table.checkStatus("table")
		      	,data = checkStatus.data;
			  if(data.length == 0){
				  return;
			  }else{
				  var nids = [];
				  for(var i=0;i<data.length;i++){
					  nids.push(data[i].id);
				  }
				  nids = nids.join(",");
				  $.ajax({
					  type: "post",
					  url: "batch_handle",
					  data: {
						 nids:nids,
						 issue: false
					  },
					  success:function (data){
						  layer.msg(data);
						  setTimeout(function(){
							  table.reload('table', {
						          page: {
						            curr: 1 //重新从第 1 页开始
						          },
						          where: {
						        	reloadvalue: "",
									reloadkey: ""
						          }
						        });
						  },2000);
					  },
					  error: function(data){
						  layer.msg("网络出错，请稍候尝试");
					  }
				  });
			  }
	    }
	    ,reload: function(){ //根据搜索内容表格重载start
	        var demoReload = $("#demoReload");
	        
	        //执行重载start
	        table.reload('table', {
	          page: {
	            curr: 1 //重新从第 1 页开始
	          }
	          ,where: {
	        	reloadvalue: demoReload.val(),
	        	reloadkey: "title"
	          }
	        }); //执行重载end
	      }  //根据搜索内容表格重载end
	    ,refresh: function(){
	    	//执行重载start
	        table.reload('table', {
	          page: {
	            curr: 1 //重新从第 1 页开始
	          }
	          ,where: {
	        	reloadvalue: "",
	        	reloadkey: ""
	          }
	        }); //执行重载end
	      }
	     ,batch_del: function(){
	    	 var checkStatus = table.checkStatus("table")
		      	,data = checkStatus.data;
			  if(data.length == 0){
				  return;
			  }else{
				  var nids = [];
				  for(var i=0;i<data.length;i++){
					  nids.push(data[i].id);
				  }
				  nids = nids.join(",");
				  $.ajax({
					  type: "post",
					  url: "batch_del",
					  data: {
						 nids:nids,
						 issue: false
					  },
					  success:function (data){
						  layer.msg(data);
						  setTimeout(function(){
							  table.reload('table', {
						          page: {
						            curr: 1 //重新从第 1 页开始
						          },
						          where: {
						        	reloadvalue: "",
									reloadkey: ""
						          }
						        });
						  },2000);
					  },
					  error: function(data){
						  layer.msg("网络出错，请稍候尝试");
					  }
				  });
			  }
	     }
	    	
	    };//active end
	
	  $('.demoTable .layui-btn').on('click', function(){
	    var type = $(this).data('type');
	    active[type] ? active[type].call(this) : '';
	  });
	});
	</script>
	</div>
  </body>
</html>
