<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>新闻列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body style="padding:30px;">
    <div style="margin-bottom: 5px;">
	搜索标题：
	  <div class="layui-inline">
	    <input class="layui-input" name="id" id="demoReload" autocomplete="off">
	  </div>
	<div class="layui-btn-group demoTable">
	
	  <button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
	  <button class="layui-btn" data-type="newNews"><i class="layui-icon">&#xe608;</i>添加文章</button>
	  <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
	  <button class="layui-btn" data-type="isAll">验证是否全选</button>
	</div>


	<table class="layui-table" id="table" lay-filter="demo"></table>

	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn-mini" lay-event="detail">查看</a>
  		<a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  		<a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
	</script>

	<script type="text/html" id="switchTpl">
  		<!-- 这里的 checked 的状态只是演示 -->
  		<input type="checkbox" name="sex" value="{{d.id}}" lay-skin="switch" lay-text="女|男" lay-filter="sexDemo" {{ d.id == 10003 ? 'checked' : '' }}>
	</script>
	
	<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>

	<script>
	layui.use('table', function(){
	  var $ = layui.jquery;
	  var table = layui.table,
	  	  form = layui.form;
	  //监听表格复选框选择
	  table.on('checkbox(demo)', function(obj){
	    console.log(obj)
	  });
	  
	  //方法级渲染表格
	  table.render({
		  elem: "#table"
		  ,url: "news/listNews"
		  ,cols: [[
		      {checkbox: true,fixed: true}
		      ,{field: "id", title: "ID", width: 60, sort: true,fixed: true}
		      ,{field: "title", title: "标题", width: 280, align: "center"}
		      ,{field: "newsfrom", title: "来源", width: 90, align: "center"}
		      ,{field: "category", title: "类型", width: 90, align: "center"}
		      ,{field: "createTime", title: "创建时间", width: 160, align: "center"}
		      ,{field: "updateTime", title: "更新时间", width: 160, align: "center"}
		      ,{field:"sex", title:"性别", width:85, templet: "#switchTpl", unresize: true}
		      ,{fixed: "right",title:"操作", width:160, align:"center", toolbar: "#barDemo"}

		        ]]
	  	  ,id: "Reload"
		  ,page:true
		  ,width: 1200
		  , height:332
	  });
	  
	  //监听工具条
	  table.on('tool(demo)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'detail'){
	      layer.msg('ID：'+ data.id + ' 的查看操作');
	      console.log(navigator)
	    } else if(obj.event === 'del'){
	      layer.confirm('真的删除行么', function(index){
	    	layer.close(index);
	        $.ajax({
	        	type: "post",
	        	url: "news/delNews",
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
	      window.location.href = location.origin+"/NewsCMS/news/goUpdate?newsid="+data.id;
	    }
	  });
	  
	  //监听性别操作
	  form.on('switch(sexDemo)', function(obj){
	    layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
	  });

	  //监听锁定操作
	  form.on('checkbox(lockDemo)', function(obj){
	    layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
	  });
	
	  //顶部按钮组的功能函数
	  var active = { //active start
	    newNews: function(){ //新建文章
	    	window.location.href = location.origin+"/NewsCMS/news/go_addN";
	    }
	    ,getCheckLength: function(){ //获取选中数目
	      var checkStatus = table.checkStatus("Reload")
	      ,data = checkStatus.data;
	      layer.msg('选中了：'+ data.length + ' 个');
	    }
	    ,isAll: function(){ //验证是否全选
	      var checkStatus = table.checkStatus("table");
	      layer.msg(checkStatus.isAll ? '全选': '未全选')
	    }
	    ,reload: function(){ //根据搜索内容表格重载start
	        var demoReload = $('#demoReload');
	        
	        //执行重载start
	        table.reload('testReload', {
	          page: {
	            curr: 1 //重新从第 1 页开始
	          }
	          ,where: {
	            key: {
	              id: demoReload.val()
	            }
	          }
	        }); //执行重载end
	      }  //根据搜索内容表格重载end
	    	
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
