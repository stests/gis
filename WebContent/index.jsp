<%@ page language="java"
         contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>	
<%
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>系统管理 - 移动医疗监护系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn" />
</head>
<script type="text/javascript" src="/resources/easyui/jquery.min.js"></script>
<script type="text/javascript">
function check_main_login(){
	var name = $("input[name='idcode']");
	var pass = $("input[name='password']");
    if(name.val() == ''){
        alert('身份证号不能为空');
        name.focus();
        return false;
    }
    if(pass.val() == ''){
        alert('密码不能为空');
        pass.focus();
        return false;
    }
}
</script>
<style>
body,h1,h2,h3,h4,h5,h6,dl,dt,dd,ul,ol,li,th,td,p,blockquote,pre,form,legend,input,button,textarea,hr {
    margin:0;
    padding:0;
}
h1,h2,h3,h4,h5,h6 {
    font-size:100%;
}
ul {
    list-style:none;
}
ol {
    padding-left:20px;
}
img {
    border:0;
}
q:before,q:after {
    content:'';
}
abbr[title] {
    border-bottom:1px dotted;
    cursor:help;
}
button,input,select,textarea {
    font-size:100%;
}
hr {
    border:none;
    height:1px;
}
body,button,input,select,textarea {
    font:12px/1 Tahoma,'Microsoft Yahei','Simsun';
}
html,body {
    font:12px/1.8 'Microsoft YaHei',Tahoma,Verdana,'Simsun';
    color:#000;
    background:#fcfcfc;
    -webkit-text-size-adjust:none;
}
html,body {
	background: #fbfbfb;
}
#login {
    margin:0px;
    padding:140px 0px 0px;
    color:#333;
}
.login-lang {
}.login-min {
     width:600px;
     margin:0px auto 0px;
     padding:20px 0px;
    height: 200px;
 }
.login-left {
    float:left;
    margin-top:40px;
    text-align:center;
    width:270px;
    border-right:1px solid #ccc;
}
.login-left p {
    text-align:center;
    margin-top:10px;
    padding-left:5px;
}
.login-left a.img {
}.login-right {
     float:left;
     width:305px;
     padding-left:10px;
     border-left:1px solid #fff;
 }
.login-title {
    font-size:16px;
    padding-left:85px;
    height:35px;
    line-height:35px;
    margin-bottom:8px;
    overflow:hidden;
}
.login-right input.text {
    height:20px;
    line-height:20px;
    width:150px;
    margin:0px;
}
.login-right p {
    margin:10px 0px;
}
.login-right form label {
    float:left;
    width:76px;
    text-align:right;
    font-size:13px;
    padding-right:10px;
    font-weight:bold;
}
.login-submit {
    padding-left:86px;
}
.login-code img {
    width:60px;
    height:25px;
}
.login-submit {
    padding-top:5px;
}
.login-submit input {
    margin-right:10px;
    border:1px solid #71a9c5;
    cursor:pointer;
    padding:5px 12px;
    background:#b5dfe9;
    border-top:0;
    border-left:0;
    color:#333;
    padding:5px 4px 3px 5px\9;
    *padding:5px 4px 3px 4px;
}
.login-submit a {
    margin-right:8px;
}
.login-zhao {
    text-align:right;
    padding-right:15px;
}
.login-zhao a {
    color:#1c57c4;
    text-decoration:underline;
    margin:0px 20px;
}
.login-zhao a:hover {
    color:#1c57c4;
    text-decoration:underline;
}
#pass1,#pass2 {
    padding-left:6px;
    color:#f00;
}
.footer {
    clear:both;
    padding:8px 0px;
    font-size:12px;
    overflow:hidden;
    text-align:center;
    color:#777;
}
.footer b {
    font-weight:normal;
    color:#777;
}
.footer a {
    color:#1c57c4;
    text-decoration:none;
}
</style>
<body id="login">
	<div class="login-min">
		<div class="login-left">
			<div style="border-right: 1px solid #fff; padding: 0px 0px 20px;">
                <img src="/css/admin/login-logo.png" alt="移动医疗监护系统" title="移动医疗监护系统" />
				<p>移动医疗监护系统</p>
			</div>
		</div>
		<div class="login-right">
			<h1 class="login-title">管理员登录</h1>
			<div>
				<form method="post" action="welcome/login.action"
					name="main_login" onSubmit="return check_main_login()">
					<input type="hidden" name="action" value="login" />
					<p>
						<label>身份证</label><input
							type="text" class="text" name="idcode" value="admin" />
					</p>
					<p>
						<label>密码</label><input
							type="password" class="text" name="password" value="admin" />
					</p>
					<p class="login-code"></p>
					<p class="login-submit">
						<input type="submit" name="Submit"
							value="登录" />
					</p>
				</form>
			</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="footer" style="margin-top: 80px;">
		技术支持： <b><a href=Bypt.com target=_blank>无锡北邮</a></b> &copy;2013-2013 &nbsp;<a href=
			target=_blank>Bypt.com</a>	</div>
</body>
</html>


