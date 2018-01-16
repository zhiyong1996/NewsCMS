<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>   
    <title>注册帐号</title>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Ncss/index.css"/>
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
  </head>
<style>
body {
    padding-top: 20px;
}

.info-container {
    padding-top: 40px;
}

.title {
    padding-bottom: 30px;
    box-shadow: 0px 4px 9px rgba(64, 64, 64, 0.1);
}

.title small {
    padding-left: 10px;
    margin-left: 10px;
    font-size: 15px;
    border-left: 1px solid #ccc;
}

.my-error .tip-origin {
    position: relative;
}

.my-error .tip-origin .tip {
    position: absolute;
    top: 8px;
    left: 100%;
    width: 100px;
    color: #a94442;
    font-weight: bold;
    display: block;
}

.tip {
    display: none;
}

.help-block {
    color: #737373;
}

.has-success.has-feedback .glyphicon-ok.form-control-feedback {
    display: block;
}

.has-error.has-feedback.my-error .glyphicon-remove.form-control-feedback {
    display: block;
}

.form-control-feedback {
    display: none;
}

.submit {
    margin-top: 30px;
}
</style>
<!-- style end-->

<body>
    <div class="container-fluid title">
        <div class="container">
            <h1 class="">News帐号注册<small><a href="#">新闻首页</a></small></h1>
            <div class="login-link">
                已有帐号,<span><a href="#" class="btn btn-link">现在登录</a></span>
            </div>
        </div>
    </div>
    <div class="container info-container">
        <form class="form-horizontal" action="/aa" id="form">
            <div class="form-group">
                <label for="username" class="control-label col-sm-2">
                    用户名
                </label>
                <div class="col-sm-5 tip-origin">
                    <input class="form-control" type="text" id="username" name="username" placeholder="请设置用户名">
                    <span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
                    <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                    <p class="help-block">6-12个数字字母组成，必须由字母开头</p>
                    <span class="tip"></span>
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="control-label col-sm-2">
                    密码
                </label>
                <div class="col-sm-5  tip-origin">
                    <input class="form-control" type="password" id="password" name="password" placeholder="请设置登录密码">
                    <span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
                    <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                    <p class="help-block">6-12个数字字母组成,区分大小写,不能包含空格</p>
                    <span class="tip"></span>
                </div>
            </div>
            <div class="form-group">
                <label for="passagain" class="control-label col-sm-2">
                    重复密码
                </label>
                <div class="col-sm-5  tip-origin">
                    <input class="form-control" type="password" id="passagain" name="passagain" placeholder="请再次输入密码">
                    <span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
                    <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                    <p class="help-block">要求与密码一致</p>
                    <span class="tip"></span>
                </div>
            </div>
            <div class="form-group">
                <label for="username" class="control-label col-sm-2">
                    邮箱
                </label>
                <div class="col-sm-5  tip-origin">
                    <input class="form-control" type="email" id="email" name="email" placeholder="请设置电子邮箱">
                     <span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
                    <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                    <p class="help-block">可用电子邮箱</p>
                    <span class="tip"></span>
                </div>
            </div>
            <div class="form-group">
                <div class=" col-sm-offset-2 col-sm-4">
                    <button type="submit" id="submit" class="btn btn-primary btn-lg btn-block submit">立即注册</button>
                </div>
            </div>
        </form>
    </div>
    <div class="foot">
        <div class="container">
            <p>@ 2017-2018 zzy版权所有 | 联系方式: 814793367@qq.com | <a href="javascript:;">意见反馈</a></p>
        </div>
    </div>
    <script src="Njs/form_check.js"></script>
</body>
</html>
