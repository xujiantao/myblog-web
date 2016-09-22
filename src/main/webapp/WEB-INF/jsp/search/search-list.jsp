<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<%@include file="../base.jsp"%>
<title>搜索结果列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
					    <div id="title-part" style="display: none;">
							<h2>
								为您找到相关结果约<span id="result-count"></span>个： <span class="text-navy">“<span id="show-keyword"></span>”</span>
							</h2>
							分词结果为：<span id="words" style="font-weight: bold;"></span>
							<br><br>
							<small>搜索用时 ( <span id="ms"></span>ms )</small>
							
						</div>
						<div class="search-form">
							<form action="index.html" method="get">
								<div class="input-group">
									<input type="text" id="keyword" value="${keyword}" placeholder="请输入关键字" name="search"
										class="form-control input-lg" maxlength="30">
									<div class="input-group-btn">
										<button class="btn btn-lg btn-primary" id="search-submit">搜索</button>
									</div>
								</div>

							</form>
						</div>
						<div class="hr-line-dashed"></div>
						<div id="search-result-list">
							快输入关键字搜索吧！
							<div class="hr-line-dashed"></div>
						</div>
						<div class="text-center" id="page-info">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	var defaultPageNo = 1;
	searchArticle(defaultPageNo);
	$('#search-submit').click(function(){
	    searchArticle(defaultPageNo);
		return false;
	});
	
	function searchArticle(pageNo){
	    var keyword = $('#keyword').val().trim();
	    if(keyword == ''){
	        return false;
	    }
	    var $resultList= $('#search-result-list');
		var html = [];
		html.push('<div class="animated fadeInRight">');
		$.ajax({
		    url : 'search/searchArticle',
		    dataType : 'json',
		    data : {
		        keyword : keyword,
		        pageNo : pageNo
		    },
		    success : function(data){
		        var status = data.status;
		        var pr = data.pr;
		        var ms = data.ms;
		        if(status == 1){
		        	if(pr.rowsCount > 0){
			            $(pr.list).each(function(i, o){
			                html.push('<div class="search-result">');
							html.push('<h3><a href="article/' + o.id + '.html" target="_blank">'+ o.title +'</a></h3>');
							if(strIsNotNull(o.lead)){
								html.push('<p class="content">'+ o.lead +'<p>');
							}
							html.push('<p class="content">'+ o.showContent +'<p>');
							html.push('<div class="hr-line-dashed"></div>');
							html.push('</div>');
			            });
		        	}else{
		        		 html.push('sorry！啥也木有枣到！');
		        	}
		            if(pr.pageCount > 1){
		                createPageInfo(pr);
		            }else{
		            	$('#page-info').html('');
		            }
		            $('#result-count').html(pr.rowsCount);
		            $('#words').html(pr.other); //分词
		        }else{ 
		            var msg = data.msg;
		            layer.alert('搜索错误，原因：' + msg);
		            html.push('sorry！啥也木有枣到！');
		        }
		        
		        html.push('</div>');
		        
		        $('#show-keyword').html(data.keyword);
		        $('#ms').html(ms);
		        $('#title-part').show();
		        
				$resultList.html(html.join(''));
		    },
		    error : function(){
		        layer.alert('网络错误！');
		    }
		});
		
	}
	
	function createPageInfo(pr){
		var pageNo = pr.pageNo;
		var pageCount = pr.pageCount;
		var showPageSize = 7;
		var html = [];
		html.push('<div class="btn-group">');
		if(pr.hasPrev){
			html.push('<button class="btn btn-white" id="prev-page" data-page="'+ pr.prevPageNo +'" type="button">');
		}else{
		    html.push('<button class="btn btn-white" type="button">');
		}
		html.push('<i class="fa fa-chevron-left"></i>');
		html.push('</button>');
		if(pageCount < 7){
			for(var i = 1; i <= pageCount; i++){
			    if(pageNo == i){
			        html.push('<button class="btn btn-white page active" data-page="'+ i +'">'+ i +'</button>');
			    }else{
			        html.push('<button class="btn btn-white page" data-page="'+ i +'">'+ i +'</button>');
			    }
			}
		}else{
		    var top3 = 3;
		    var bottom3 = pageCount - pageNo;
		    //前3页点击
			if(pageNo <=top3){
				for(var i = 1; i <= 7; i++){
				    if(pageNo == i){
				        html.push('<button class="btn btn-white page active" data-page="'+ i +'">'+ i +'</button>');
					}else{
					    html.push('<button class="btn btn-white page" data-page="'+ i +'">'+ i +'</button>');
					}
				}
			//后3页点击
			}else if(bottom3 <= 3){
			    var num = pageCount - 6;
				for(var i = num; i <= pageCount; i++){
				    if(pageNo == i){
				        html.push('<button class="btn btn-white page active" data-page="'+ i +'">'+ i +'</button>');
					}else{
					    html.push('<button class="btn btn-white page" data-page="'+ i +'">'+ i +'</button>');
					}
				}
			}else{			   
				for(var i = 3; i > 0; i--){
				    var leftPageNo = pageNo - i;
				    html.push('<button class="btn btn-white page" data-page="'+ leftPageNo +'">'+ leftPageNo +'</button>');
				}
				html.push('<button class="btn btn-white page active" data-page="'+ pageNo +'">'+ pageNo +'</button>');
				for(var i = 1; i <= 3; i++){
				    var rightPageNo = pageNo + i;
				    html.push('<button class="btn btn-white page" data-page="'+ rightPageNo +'">'+ rightPageNo +'</button>');
				};
			};
		}
		
		if(pr.hasNext){
		    html.push('<button class="btn btn-white page" id="next-page" data-page="'+ pr.nextPageNo +'" type="button">');
		}else{
		    html.push('<button class="btn btn-white" type="button">');
		}
		html.push('<i class="fa fa-chevron-right"></i>');
		html.push('</button>');
		html.push('</div>');
			
	    $('#page-info').html(html.join(''));
	}
	
	$(document).on('click', '.page' ,function(){
	    if(!$(this).hasClass('active')){
		    var pageNo = $(this).data('page');
			searchArticle(pageNo);	 
		}   
	});
	$(document).on('click', '#prev-page, #next-page' ,function(){
	    var pageNo = $(this).data('page');
		searchArticle(pageNo);	    
	});
	
	</script>
</body>

</html>
