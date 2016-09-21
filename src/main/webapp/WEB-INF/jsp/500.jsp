<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>
	<title>500错误</title>
	<base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
	<!-- 全局css -->
	<link href="css/bootstrap.min.css?v=3.4.0" rel="stylesheet">
	<link href="css/font-awesome.css?v=4.3.0" rel="stylesheet">
	<link href="css/animate.css" rel="stylesheet">
	<link href="css/style.css?v=3.0.0" rel="stylesheet">
	<link href="css/common.css?v=3.0.0" rel="stylesheet">
	<!-- 全局js -->
	<script src="js/jquery-2.1.1.min.js"></script>
	<script src="js/bootstrap.min.js?v=3.4.0"></script>
	<script src="plugins/layer/layer.min.js"></script>

</head>

<body class="gray-bg">

    <div class="middle-box text-center animated fadeInDown">
        <h1>500</h1>
        <h3 class="font-bold">服务器好像出错了...好尴尬！</h3>
        <div class="error-desc">
            <br/>您可以返回主页看看
            <br/><a href="/myblog-web" class="btn btn-primary m-t">主页</a>
        </div>
    </div>

</body>

</html>