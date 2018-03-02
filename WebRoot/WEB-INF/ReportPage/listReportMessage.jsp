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
		<div class="layui-btn-group demoTable">
		  <button class="layui-btn" data-type="readed">标记为已读</button>
		  <button class="layui-btn" data-type="删除">删除</button>
		</div>
		
		<!-- 表格容器 -->
		<table class="layui-table" id="table" lay-filter="demo"></table>
		
		<!-- 工具栏模板引擎 -->
		<script type="text/html" id="barDemo">
  			<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="detail">查看详情</a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
		</script>
		
		
		<!-- 表格表单模板引擎 -->
		<script type="text/html" id="switchTpl">
  		<!-- 这里的 d为ajax获取到的数据对象 -->
  		<input type="checkbox" name="issue" value="{{d.id}}" lay-skin="switch" lay-text="on|off" lay-filter="sexDemo" {{ d.issue == true ? 'checked' : '' }}>
		</script>
		
		<!-- 序列号模板引擎 -->
		<script type="text/html" id="indexTpl">
    	{{parseInt(d.LAY_TABLE_INDEX+1)}}
		</script>
	</div>
	
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
		  ,url: "report/list_report_msg"
		  ,cols: [[
		      {checkbox: true,fixed: true}
		      ,{title: "序号",width: 60,fixed: true,templet: "#indexTpl"}
		      ,{field: "id", title: "mid", width: 60, sort: true}
		      ,{field: "reporter", title: "举报者", width: 280, align: "center"}
		      ,{field: "content", title: "理由", width: 90, align: "center"}
		      ,{field: "checked", title: "状态", width: 90, align: "center"}
		      ,{field: "createTimeS", title: "日期", width: 250, align: "center"}
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
	    	window.location.href = location.origin+"/NewsCMS/report/msg_detail?msgid="+data.id;
	    	console.log(data.id);
	    } else if(obj.event === 'del'){
	      layer.confirm('确定删除该行么', function(index){
	    	layer.close(index);
	        $.ajax({
	        	type: "post",
	        	url: "report/del_single",
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
	    }
	  });

	  //顶部按钮组的功能函数
	  var active = { //active start
	    getCheckLength: function(){ //获取选中数目
	      var checkStatus = table.checkStatus("table")
	      ,data = checkStatus.data;
	    
	      layer.msg('选中了：'+ data.length + ' 个');
	    }
	    ,isAll: function(){ //验证是否全选
	      var checkStatus = table.checkStatus("table");
	      layer.msg(checkStatus.isAll ? '全选': '未全选')
	    }
	    ,reload: function(){ //根据搜索内容表格重载start
	        var demoReload = $("#demoReload");
	        
	        //执行重载start
	        table.reload('table', {
	          page: {
	            curr: 1 //重新从第 1 页开始
	          }
	          ,where: {
	            username: demoReload.val()
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
	
  </body>
</html>
