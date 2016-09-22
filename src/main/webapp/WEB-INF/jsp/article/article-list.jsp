<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<%@include file="../base.jsp"%>
<title>文章列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="文章列表页面">
<style type="text/css">
	.article-list{font-size: 18px;}
	.font-hidden{
		display: block;
		white-space: nowrap;
		overflow: hidden;  
		text-overflow: ellipsis;
	}
	
</style>

</head>

<body>
<body>
	 
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container-fluid row">
			<div class="navbar-header col-xs-12" style="width: auto; margin-top: 10px;">
				<a class="navbar-brand font-hidden" href="javascript:;">认真、谦卑、善良、坚持。</a>
			</div>
			<div class="input-group col-xs-12 col-md-9" style="padding-top: 10px; padding-bottom: 10px; padding-left: 15px; padding-right: 15px;">
				<input placeholder="请输入关键字" id="keyword" name="keyword" class="form-control input-lg" type="text" maxlength="30">
				<div class="input-group-btn">
					<button id="search" class="btn btn-lg btn-primary">搜索</button>
				</div>
			</div>
			
			<!-- 
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li class="active"><a href="#">Blog</a>
					</li>
					<li><a
						href="http://www.jianshu.com/users/b1dd2b2c87a8/latest_articles">简书</a>
					</li>
					<li><a href="http://www.yinwang.org/tweet.html">Tweet</a>
					</li>
					<li><a href="https://github.com/yinwang0">GitHub</a>
					</li>
				</ul>
			</div>
			 -->
		</div>
	</nav>
	
	<div class="row">
		<div class="container center-block">
			<div class="col-md-2"></div>
			<div class="col-md-8 col-sm-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Blog</h3>
					</div>
					<ul class="list-group article-list">
						<c:if test="${pr.rowsCount>0}">
							<c:forEach var="article" items="${pr.list}">
								<li class="list-group-item title">
									<a href="article/${article.id}.html" target="_blank">${article.title}</a>
								</li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>

			<div class="col-md-2"></div>
		</div>
	</div>
	<script type="text/javascript">
	$('#search').click(function(){
	    var keyword = $('#keyword').val().trim();
		open('search/result?keyword=' + keyword);
	});
	</script>
</body>

</html>
