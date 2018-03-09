<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>用户列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body style="padding:30px;">
    <div style="margin-bottom: 5px;">
    <form class="layui-form layui-inline" id="searchUser">
	  <div class="layui-inline">
	  	<select name="searchType" lay-filter="searchType">
	  		<option value="username">用户名</option>
	  		<option value="id">ID</option>
	  		<option value="name">昵称</option>
	  	</select>
	  </div>
	  <div class="layui-inline">
	    <input class="layui-input" id="searchValue" name="reloadValue" id="demoReload" autocomplete="off" required maxlength="12"/>
	  </div>
	  <button class="layui-btn" type="submit"><i class="layui-icon">&#xe615;</i>搜索</button>
	</form>
	<button class="layui-btn" id="refresh"><i class="layui-icon">&#x1002;</i></button>

	<table class="layui-table" id="table" lay-filter="demo"></table>
	
	<!-- 工具栏模板引擎 -->
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看详细资料</a>
  		
	</script>
	<!-- <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a> -->
	
	<!-- 表格表单模板引擎 -->
	<script type="text/html" id="switchTpl">
  		<!-- 这里的 d为ajax获取到的数据对象 -->
  		<input type="checkbox" name="issue" value="{{d.id}}" lay-skin="switch" lay-text="on|off" lay-filter="sexDemo" {{ d.issue == true ? 'checked' : '' }}>
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
	  
	  var defaultType = "username";
	  
	  form.on('select(searchType)', function(data){
		  defaultType = data.value;
		}); 
	  
	  $("#searchUser").on("submit",function(e){
		  e.preventDefault();
		  var reloadKey = defaultType;
		  var reloadValue = $("#searchValue").val();
			//执行重载start
          table.reload('table', {
          	page: {
            	curr: 1 //重新从第 1 页开始
          	}
          	,where: {
            	reloadKey: reloadKey,
            	reloadValue: reloadValue
          }
        }); //执行重载end
	  });
	  
	  //方法级渲染表格
	  table.render({
		  elem: "#table"
		  ,url: "page_user"
		  ,cols: [[
		      {checkbox: true,fixed: true}
		      ,{title: "序号",width: 60,fixed: true,templet: "#indexTpl"}
		      //,{field: "id", title: "ID", width: 60, sort: true}
		      ,{field: "username", title: "用户名", width: 280, align: "center"}
		      ,{field: "name", title: "昵称", width: 90, align: "center"}
		      ,{field: "lastlogin", title: "最后登录时间", width: 250, align: "center"}
		      //,{field: "islock", title: "锁定", width:100, align: "center", templet: "#switchTpl"}
		      ,{fixed: "right", title: "操作", width:160, align:"center", toolbar: "#barDemo"}

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
	    	window.location.href = location.origin+"/NewsCMS/adminuser/user_detail?uid="+data.id;
	    	console.log(data.id);
	    } 
	  });
		
	  $("#refresh").on("click",function(e){
		//执行重载start
          table.reload('table', {
          	page: {
            	curr: 1 //重新从第 1 页开始
          	}
          	,where: {
            	reloadKey: "",
            	reloadValue: ""
          }
        }); //执行重载end
	  });

	});
	</script>
	</div>
  </body>
</html>
