<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Object admin = session.getAttribute("admin");
	if(admin == null){
		response.sendRedirect(path+"/admin_login.jsp");
	}
%>
<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>控制台首页</title>    
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/plugins/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/plugins/font-awesome/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/src/css/app.css" media="all">
  </head>
<body>
    <div class="layui-layout layui-layout-admin kit-layout-admin">
        <div class="layui-header">
            <div class="layui-logo">NewsManager</div>
            <div class="layui-logo kit-logo-mobile"><i class="fa fa-desktop" aria-hidden="true"></div>
            <ul class="layui-nav layui-layout-left kit-nav" kit-one-level>
                <li class="layui-nav-item"><a href="javascript:;">控制台</a></li>
            </ul>
            <ul class="layui-nav layui-layout-right kit-nav">
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <img src="http://m.zhengjinfan.cn/images/0.jpg" class="layui-nav-img"> admin
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">基本资料</a></dd>
                        <dd><a href="javascript:;">安全设置</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="login/quit"><i class="fa fa-sign-out" aria-hidden="true"></i> 注销</a></li>
            </ul>
        </div>

        <div class="layui-side layui-bg-black kit-side">
            <div class="layui-side-scroll">
                <div class="kit-side-fold"><i class="fa fa-navicon" aria-hidden="true"></i></div>
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <ul class="layui-nav layui-nav-tree" lay-filter="kitNavbar" kit-navbar>
                    <li class="layui-nav-item layui-nav-itemed">
                        <a href="javascript:;" data-title="新闻管理"><i class="fa fa-cubes" aria-hidden="true"></i><span> 新闻管理</span></a>
                        <dl class="layui-nav-child">
                        	<dd>
                                <a href="javascript:;" data-url="news/select_news" data-title="新建文章" kit-target data-id='3'><i class="fa fa-plus" aria-hidden="true"></i><span> 新建文章</span></a>
                            </dd>
                            <dd>
                                <a href="javascript:;" data-url="category/go_listC" data-title="类型管理" kit-target data-id='1'><i class="fa fa-book" aria-hidden="true"></i><span> 类型管理</span></a>
                            </dd>
                            <dd>
                                <a href="javascript:;" data-url="news/go_list_news" data-title="文章管理" kit-target data-id='2'><i class="fa fa-file-text-o" aria-hidden="true"></i><span> 文章管理</span></a>
                            </dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item layui-nav-itemed">
                        <a href="javascript:;"><i class="fa fa-life-buoy" aria-hidden="true"></i><span> 广告管理</span></a>
                        <dl class="layui-nav-child">
                            <dd><a href="javascript:;" kit-target data-options="{url:'navbar.html',icon:'&#xe658;',title:'Navbar',id:'6'}"><i class="layui-icon">&#xe658;</i><span> Navbar</span></a></dd>
                            <dd><a href="javascript:;" kit-target data-options="{url:'tab.html',icon:'&#xe658;',title:'TAB',id:'7'}"><i class="layui-icon">&#xe658;</i><span> Tab</span></a></dd>
                            <dd><a href="javascript:;" kit-target data-options="{url:'onelevel.html',icon:'&#xe658;',title:'OneLevel',id:'50'}"><i class="layui-icon">&#xe658;</i><span> OneLevel</span></a></dd>
                            <dd><a href="javascript:;" kit-target data-options="{url:'app.html',icon:'&#xe658;',title:'App',id:'8'}"><i class="layui-icon">&#xe658;</i><span> app.js主入口</span></a></dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;" data-url="/components/table/table.html" data-name="table" kit-loader><i class="fa fa-user-o" aria-hidden="true"></i><span> 用户管理</span></a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;" data-url="/views/form.html" data-name="form" kit-loader><i class="fa fa-file-image-o" aria-hidden="true"></i><span> 图片管理</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="layui-body" id="container">
            <!-- 内容主体区域 -->
            <div style="padding: 15px;">主体内容加载中,请稍等...</div>
        </div>

        <div class="layui-footer"></div>
    </div>
    <script src="<%=request.getContextPath() %>/static/plugins/layui/layui.js"></script>
    <script>
        var message;
        layui.config({
            base: "<%=request.getContextPath() %>/static/src/js/"
        }).use(['app', 'message'], function() {
            var app = layui.app,
                $ = layui.jquery,
                layer = layui.layer;
            //将message设置为全局以便子页面调用
            message = layui.message;
            //主入口
            app.set({
                type: 'iframe'
            }).init();
        });
    </script>
  </body>
</html>
