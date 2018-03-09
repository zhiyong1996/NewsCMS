<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
  <head>   
    <title>广告管理</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  <style>
  	.layui-table-view{
  		margin: 0;
  	}
  	.layui-elem-field legend{
  		font-weight: bold;
  	}
  	.btn-group{
  		margin: 10px 20px;
  	}
  </style>
  
  <body style="padding: 30px;">
  
  	<fieldset class="layui-elem-field">
  		<legend>头部广告</legend>
  		<div class="btn-group">
  			<button class="layui-btn layui-btn-normal addAd" data-adType="top">添加新广告</button>
  			<input type="hidden" value="0" id="top-hide"/>
  		</div>
  		<table class="layui-table" id="TopTable" lay-filter="top"></table>
  	</fieldset>
  	
  	
  	<fieldset class="layui-elem-field">
  		<legend>底部广告</legend>
  		<div class="btn-group">
  			<button class="layui-btn layui-btn-normal addAd" data-adType="bot">添加新广告</button>
  			<input type="hidden" value="0" id="bot-hide"/>
  		</div>
  		<table class="layui-table" id="BotTable" lay-filter="bot"></table>
  	</fieldset>
  	
  	
  	<fieldset class="layui-elem-field">
  		<legend>侧栏广告</legend>
  		<div class="btn-group">
  			<button class="layui-btn layui-btn-normal addAd" data-adType="side">添加新广告</button>
  			<input type="hidden" value="0" id="side-hide"/>
  		</div>
  		<table class="layui-table" id="SideTable" lay-filter="side"></table>
  	</fieldset>
  	
  	<!-- 序列号模板引擎 -->
	<script type="text/html" id="indexTpl">
    	{{parseInt(d.LAY_TABLE_INDEX+1)}}
	</script>
	<!-- 工具栏 -->
	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="update">修改</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
	
	<!-- Top表格表单模板引擎 -->
	<script type="text/html" id="TopswitchTpl">
  		<!-- 这里的 d为ajax获取到的数据对象 -->
  		<input type="checkbox" name="issue" value="{{d.id}}" lay-skin="switch" lay-text="on|off" lay-filter="topSwitch" {{ d.issue == true ? 'checked' : '' }}>
	</script>
	<!-- Bot表格表单模板引擎 -->
	<script type="text/html" id="BotswitchTpl">
  		<!-- 这里的 d为ajax获取到的数据对象 -->
  		<input type="checkbox" name="issue" value="{{d.id}}" lay-skin="switch" lay-text="on|off" lay-filter="botSwitch" {{ d.issue == true ? 'checked' : '' }}>
	</script>
	<!-- Side表格表单模板引擎 -->
	<script type="text/html" id="SideswitchTpl">
  		<!-- 这里的 d为ajax获取到的数据对象 -->
  		<input type="checkbox" name="issue" value="{{d.id}}" lay-skin="switch" lay-text="on|off" lay-filter="sideSwitch" {{ d.issue == true ? 'checked' : '' }}>
	</script>
	
  <script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>
  <script>
  layui.use('table', function(){
	  var $ = layui.jquery;
	  var table = layui.table,
	  	  form = layui.form;
	
	  //方法级渲染表格
	  table.render({
		  elem: "#TopTable"
		  ,url: "list_top"
		  ,cols: [[
		      //{checkbox: true,fixed: true}
		      {title: "序号",width: 60,fixed: true,templet: "#indexTpl",align: "center"}
		      //,{field: "id", title: "ID", width: 60, sort: true,align: "center"}
		      ,{field: "company", title: "广告单位", width: 120, align: "center"}
		      ,{field: "about", title: "描述", width: 300, align: "center"}
		      ,{field: "url", title: "链接", width: 300, align: "center"}
		      //,{field: "updateTime", title: "更新时间", width: 160, align: "center"}
		      ,{field: "issue", title: "是否发布", width:100, align: "center", templet: "#TopswitchTpl"}
		      ,{ title: "操作", width:120, align:"center", toolbar: "#barDemo"}

		        ]]
	  	  ,id: "top_table"
	  	  ,cellMinWidth: 85
		  ,page:true
		  , height: 200
	  });
	  
	//方法级渲染表格
	  table.render({
		  elem: "#BotTable"
		  ,url: "list_bot"
		  ,cols: [[
		      //{checkbox: true,fixed: true}
		      {title: "序号",width: 60,fixed: true,templet: "#indexTpl",align: "center"}
		      //,{field: "id", title: "ID", width: 60, sort: true,align: "center"}
		      ,{field: "company", title: "广告单位", width: 120, align: "center"}
		      ,{field: "about", title: "描述", width: 300, align: "center"}
		      ,{field: "url", title: "链接", width: 300, align: "center"}
		      //,{field: "updateTime", title: "更新时间", width: 160, align: "center"}
		      ,{field: "issue", title: "是否发布", width:100, align: "center", templet: "#BotswitchTpl"}
		      ,{ title: "操作", width:120, align:"center", toolbar: "#barDemo"}

		        ]]
	  	  ,id: "bot_table"
	  	  ,cellMinWidth: 85
		  ,page:true
		  , height: 200
	  });
	
	//方法级渲染表格
	  table.render({
		  elem: "#SideTable"
		  ,url: "list_side"
		  ,cols: [[
		      //{checkbox: true,fixed: true}
		      {title: "序号",width: 60,fixed: true,templet: "#indexTpl",align: "center"}
		      //,{field: "id", title: "ID", width: 60, sort: true,align: "center"}
		      ,{field: "company", title: "广告单位", width: 120, align: "center"}
		      ,{field: "about", title: "描述", width:300, align: "center"}
		      ,{field: "url", title: "链接", width: 300, align: "center"}
		      //,{field: "updateTime", title: "更新时间", width: 160, align: "center"}
		      ,{field: "issue", title: "是否发布", width:100, align: "center", templet: "#SideswitchTpl"}
		      ,{ title: "操作", width:120, align:"center", toolbar: "#barDemo"}

		        ]]
	  	  ,id: "side_table"
	  	  ,cellMinWidth: 85
		  ,page:true
		  , height: 200
	  });
	
	//监听工具条---TOP
	  table.on('tool(top)', function(obj){
	    var data = obj.data;
	    var ad_id = data.id;
	    if(obj.event === 'update'){
	    	layer.open({
				 type: 2
				 ,content: 'go_update_ad?ad_type=0&ad_id='+ad_id
				 ,area: ['800px', '500px']
			 	 ,end: function(index,layero){
			 		 var v = $("#top-hide").val();
			 		 if(v==1){
			 			 
			 			 table.reload('top_table',{
			 				 page: {
			 					 curr: 1
			 				 }
			 			 });
			 		 }
			 	 }
			 });
	    } else if(obj.event === 'del'){
	      layer.confirm('确定删除该行么', function(index){
	    	layer.close(index);
	        $.ajax({
	        	type: "post",
	        	url: "ad/delete_ad",
	        	dataType: "json",
	        	data: {
	        		ad_id: data.id,
	        		ad_type: 0
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
		//监听工具条---BOT
	  table.on('tool(bot)', function(obj){
	    var data = obj.data;
	    var ad_id = data.id;
	    if(obj.event === 'update'){
	    	layer.open({
				 type: 2
				 ,content: 'go_update_ad?ad_type=1&ad_id='+ad_id
				 ,area: ['800px', '500px']
			 	 ,end: function(index,layero){
			 		 var v = $("#bot-hide").val();
			 		 if(v!==1){ 
			 			 table.reload('bot_table',{
			 				 page: {
			 					 curr: 1
			 				 }
			 			 });
			 		 }
			 	 }
			 });
	    } else if(obj.event === 'del'){
	      layer.confirm('确定删除该行么', function(index){
	    	layer.close(index);
	        $.ajax({
	        	type: "post",
	        	url: "ad/delete_ad",
	        	dataType: "json",
	        	data: {
	        		ad_id: data.id,
	        		ad_type: 1
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
		//监听工具条---Side
	  table.on('tool(side)', function(obj){
	    var data = obj.data;
	    var ad_id = data.id;
	    if(obj.event === 'update'){
	    	layer.open({
				 type: 2
				 ,content: 'go_update_ad?ad_type=2&ad_id='+ad_id
				 ,area: ['800px', '500px']
			 	 ,end: function(index,layero){
			 		 var v = $("#side-hide").val();
			 		 if(v!==1){
			 			 
			 			 table.reload('side_table',{
			 				 page: {
			 					 curr: 1
			 				 }
			 			 });
			 		 }
			 	 }
			 });
	    } else if(obj.event === 'del'){
	      layer.confirm('确定删除该行么', function(index){
	    	layer.close(index);
	        $.ajax({
	        	type: "post",
	        	url: "ad/delete_ad",
	        	dataType: "json",
	        	data: {
	        		ad_id: data.id,
	        		ad_type: 2
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
	
		
		
	 //监听按钮---Top
	 $("button[data-adType='top']").on("click",function(e){
		 layer.open({
			 type: 2
			 ,content: 'go_new_ad?ad_type=0'
			 ,area: ['800px', '500px']
		 	 ,end: function(index,layero){
		 		 var v = $("#top-hide").val();
		 		 if(v!==1){
		 			 
		 			 table.reload('top_table',{
		 				 page: {
		 					 curr: 1
		 				 }
		 			 });
		 		 }
		 	 }
		 });
	 });
	//监听按钮---Bot
	 $("button[data-adType='bot']").on("click",function(e){
		 layer.open({
			 type: 2
			 ,content: 'go_new_ad?ad_type=1'
			 ,area: ['800px', '500px']
		 	 ,end: function(index,layero){
		 		 var v = $("#bot-hide").val();
		 		 if(v!==1){	 
		 			 table.reload('bot_table',{
		 				 page: {
		 					 curr: 1
		 				 }
		 			 });
		 		 }
		 	 }
		 });
	 });
	//监听按钮---Side
	 $("button[data-adType='side']").on("click",function(e){
		 layer.open({
			 type: 2
			 ,content: 'go_new_ad?ad_type=2'
			 ,area: ['800px', '500px']
		 	 ,end: function(index,layero){
		 		 var v = $("#side-hide").val();
		 		 if(v!==1){
		 			 table.reload('side_table',{
		 				 page: {
		 					 curr: 1
		 				 }
		 			 });
		 		 }
		 	 }
		 });
	 });
	
	//监听issue操作
	  form.on('switch(topSwitch)', function(obj){
	    $.ajax({
	        	type: "post",
	        	url: "ad/ad_switch",
	        	dataType: "html",
	        	data: {
	        		ad_type: 0,
	        		ad_id: this.value,
	        		issue: obj.elem.checked
	        	},
	        	success: function(data){     		
	        		var data_ = JSON.parse(data);
	        		if(data_.status){
		        		layer.msg("更新成功");
	        		}
	        	},
	        	error: function(){
	        		layer.msg("网络出错,更新失败");
	        	}
	        });//ajax end  
	  });
	//监听issue操作
	  form.on('switch(botSwitch)', function(obj){
	  	console.log(obj.elem.checked);
	    $.ajax({
	        	type: "post",
	        	url: "ad/ad_switch",
	        	dataType: "html",
	        	data: {
	        		ad_type: 1,
	        		ad_id: this.value,
	        		issue: obj.elem.checked
	        	},
	        	success: function(data){
	        		var data_ = JSON.parse(data);
	        		if(data_.status){
		        		layer.msg("更新成功");
	        		}
	        	},
	        	error: function(){
	        		layer.msg("网络出错,更新失败");
	        	}
	        });//ajax end  
	  });
	//监听issue操作
	  form.on('switch(sideSwitch)', function(obj){
	    $.ajax({
	        	type: "post",
	        	url: "ad/ad_switch",
	        	dataType: "html",
	        	data: {
	        		ad_type: 2,
	        		ad_id: this.value,
	        		issue: obj.elem.checked
	        	},
	        	success: function(data){
	        		var data_ = JSON.parse(data);
	        		if(data_.status){
		        		layer.msg("更新成功");
	        		}
	        	},
	        	error: function(){
	        		layer.msg("网络出错,更新失败");
	        	}
	        });//ajax end  
	  });
  });
  </script>
  </body>
</html>
