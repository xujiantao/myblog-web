<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
	<%@include file="../base.jsp"%>
	<title>${article.title}</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="文章详细页面">
	
	<style type="text/css">
		.ibox-content img{max-width: 100%;}	
	</style>
	
	</head>

	
	<body class="gray-bg">
		<div class="wrapper wrapper-content  animated fadeInRight article">
	        <div class="row">
	            <div class="col-lg-10 col-lg-offset-1">
	                <div class="ibox">
	                    <div class="ibox-content">
	                    	<div class="pull-left">
	                    		<i class="fa fa-eye"></i>
	                    		${article.visitCount}
	                    	</div>
	                        <div class="pull-right">
	                        	<c:if test="${article.tags!=''}">
	                        		<c:forEach var="tag" items="${article.tagList }">
	                        			<button class="btn btn-white btn-xs"type="button">${tag}</button>
	                        		</c:forEach>
	                        	</c:if>
	                            
	                        </div>
	                        <div class="text-center article-title">
	                            <h1>${article.title}</h1>
	                        </div>
	                        
							${article.content}
							
							<div class="pull-right">
							    <br>
	                        	${article.showCreateDate} <br>
	                        	 ————阿鸡米德
	                        </div>
	                        <div style="clear: both;"></div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	    </div>

	</body>

</html>
