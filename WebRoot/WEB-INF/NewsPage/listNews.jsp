<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>新闻列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.2.1.js"></script> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css"/>
  </head>
  
  <body style="padding:30px;">
    <div style="margin-bottom: 5px;">

<!-- 示例-970 
<ins class="adsbygoogle" style="display:inline-block;width:970px;height:90px" data-ad-client="ca-pub-6111334333458862" data-ad-slot="3820120620"></ins>

</div>

<div class="layui-btn-group demoTable">
  <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
  <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
  <button class="layui-btn" data-type="isAll">验证是否全选</button>
</div>-->

<table class="layui-table" lay-data="{width: 1000, height:332, url:'news/listNews', page:true, id:'idTest'}" lay-filter="demo">
  <thead>
    <tr>
      <!-- <th lay-data="{checkbox:true, fixed: true,align:'center'}"></th> -->
      <th lay-data="{field:'id', fixed: true, width:60, sort: true}">ID</th>
      <th lay-data="{field:'title', width:280,align:'center'}">新闻标题</th>
      <th lay-data="{field:'newsfrom', width:90,align:'center'}">新闻来源</th>
      <th lay-data="{field:'category', width:90,align:'center'}">新闻类型</th>
      <th lay-data="{field:'createTime', width:160,align:'center'}">创建时间</th>
      <th lay-data="{field:'updateTime', width:160,align:'center'}">更新时间</th>
      <th lay-data="{fixed: 'right', width:160, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>

<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-mini" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
</script>


<script type="text/javascript" src="<%=request.getContextPath() %>/layui/layui.js"></script>

<script>
layui.use('table', function(){
  var $ = layui.jquery;
  var table = layui.table;
  //监听表格复选框选择
  table.on('checkbox(demo)', function(obj){
    console.log(obj)
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

  var $ = layui.$, active = {
    getCheckData: function(){ //获取选中数据
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.alert(JSON.stringify(data));
    }
    ,getCheckLength: function(){ //获取选中数目
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.msg('选中了：'+ data.length + ' 个');
    }
    ,isAll: function(){ //验证是否全选
      var checkStatus = table.checkStatus('idTest');
      layer.msg(checkStatus.isAll ? '全选': '未全选')
    }
  };

  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});
</script>
  </body>
</html>
