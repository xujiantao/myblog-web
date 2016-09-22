<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE>
<html lang="zh-CN">
  <head>
    <%@include file="../base.jsp" %>
    <title>文章列表</title>
  	<!-- jqgrid-->
    <link href="plugins/jqgrid/css/ui.jqgrid.css?0820" rel="stylesheet">
     <!-- jqGrid -->
    <script src="plugins/jqgrid/js/i18n/grid.locale-cn.js?0820"></script>
    <script src="plugins/jqgrid/js/jquery.jqGrid.min.js?0820"></script>
    <style type="text/css">
      #gbox_article-list, #gview_article-list, #pager{
        width: 100% !important;
      }
      #container{
        padding-left: 0px !important;
        padding-right: 0px !important;
      }
    </style>
  </head>
  
  <body>
  	<div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5>文章列表</h5>
    	</div>
	    <div class="ibox-content no-padding">
		  	<div id="container" class="container">
		  		<div class="row" style="margin-top: 20px;">
		  			<!-- 
		  			<form action="" class="form-horizontal">
		  			     <div class="form-group">
					        <label for="articleId" class="search-left control-label">活动ID</label>
					        <div class="search-right">
					        	<input id="articleId" name="articleId" placeholder="请填写活动ID" class="form-control"/>
					         </div>
					     </div>
					     <div class="form-group">
						   	 <div class="col-sm-12" style="text-align: center;">
						         <button id="select-submit" class="btn btn-success" style="margin-right: 30px;">查询</button>
						         <input type="reset" class="btn btn-default"/>
						     </div>
						 </div>
					 </form> -->
		  		</div>
		  		<div class="row" style="margin-bottom: 20px;">
		  			 <button id="add" class="btn btn-success btn-sm"><i class="glyphicon glyphicon-plus"></i>添加文章</button>
		  			 <button id="delete-all-index" class="btn btn-success btn-sm">删除全部索引</button>
		  			 <button id="add-all-index" class="btn btn-success btn-sm">添加全部索引</button>
                     <table id="article-list" class="jqgird-table"></table>
                     <div id="pager"></div>
		  		</div>
			</div>
		 </div> 
	</div>
  	<script type="text/javascript">
  		var pageNo='${pageNo}';
  		$(function(){
	  		$.jgrid.defaults.styleUI = 'Bootstrap';
			$("#article-list").jqGrid({
				url:'cms/getArticleList',
				datatype:'json',
				mtype:'post',
				sortorder:'desc',
				page:pageNo, //请求页数
				forceFit:true,
				shrinkToFit:true, //是否压缩到合适的宽度
				autowidth:true, //是否自动压缩
				jsonReader: {
	                       root:"rows",                // 数据行（默认为：rows）
	                       page: "pageNo",            // 当前页
	                       total: "pageCount",    // 总页数
	                       records: "rowCount",    // 总记录数
	                       repeatitems : false                // 设置成false，在后台设置值的时候，可以乱序。且并非每个值都得设
	            },
				colNames:['id','标题','时间','阅读量','操作'],
				colModel:[
	                   {
	                       name: 'id',
	                       index: 'id',
	                       align : 'left',
	                       sortable:true,
	                       width:100,
	                   },
	                   {
	                       name: 'title',
	                       index: 'title',
	                       align : 'left',
	                       sortable:false,
	                       width:100,
	                       formatter:function(data1,data2,article){
	                         return '<a href="article/'+article.id+'.html" target="_blank">'+article.title+'</a>';
	                       }
	                   },
	                   {
	                       name: 'showCreateDate',
	                       index: 'showCreateDate',
	                       align : 'left',
	                       sortable:false,
	                       width:100,
	                   },
	                   {
	                       name: 'visitCount',
	                       index: 'visitCount',
	                       align : 'left',
	                       sortable:false,
	                       width:100,
	                   },
	                   {
	                       name: '操作',
	                       index: '操作',
	                       align : 'left',
	                       sortable:false,
	                       width:100,
	                       formatter:function(data,data2,row){
	                       	var source = row.source;
	                       	var sortCount = row.sortCount;
	                       	var isTop = row.isTop;
	                       	var bts='';
	                       	bts+='<a class="update glyphicon glyphicon-pencil ml5"></a>';
	                   		bts+='<a class="delete glyphicon glyphicon-trash ml5"></a>';
	                   		if(sortCount > 0){
	                   		    bts+='<button class="recommend btn btn-default btn-xs ml5" data-is-execute-or-cancel="false">取消推荐</button>';
	                   		}else{
	                   		    bts+='<button class="recommend btn btn-success btn-xs ml5" data-is-execute-or-cancel="true">推荐</button>';
	                   		}
	                   		
	                   		if(isTop > 0){
	                   		    bts+='<button class="set-top btn btn-default btn-xs ml5" data-is-execute-or-cancel="false">取消置顶</button>';
	                   		}else{
	                   		    bts+='<button class="set-top btn btn-success btn-xs ml5" data-is-execute-or-cancel="true">置顶</button>';
	                   		}
	                   		
	                   		return bts;
	                       }
	                   }
				],
				pager:'#pager',
				height:'auto',
				rowNum:10,
				rowList:[10,20,30],
				viewrecords:true,
	            addtext: 'Add',
                edittext: 'Edit',
                hidegrid: false,
                emptyrecords:'没有相关数据',//没有数据提示文字
                cellEdit: true,
                cellsubmit : 'remote',
                cellurl:'article/updateArticleSortCount',
                beforeSubmitCell:function(rowid, cellname, value, iRow, iCol){ //提交单元格之前
					var articleId = $("#"+rowid).find("td:eq(0)").html();
					return {id:articleId};
    			},
    			afterSubmitCell:function (serverresponse, rowid, cellname, value, iRow, iCol){//提交单元格之后
    				var data=JSON.parse(serverresponse.responseText);
    				var state=data.resultCode;
    				if(state==1){
						$("#article-list").trigger("reloadGrid");
						layer.alert('修改成功');
					}else{
						layer.alert('修改失败');
					}
    			},
                gridComplete:function(){ //请求完毕之后触发
				   //修改
		          $('.update').click(function(){
		          	var dataId = $(this).parent().parent().find('td:eq(0)').html();
					location.href='cms/toUpdateArticle?id=' + dataId;
		          });
		          
		          //推荐
				  $('.recommend').click(function(){
				   	    var dataId = $(this).parent().parent().find('td:eq(0)').html();
				   	    var isExecuteOrCancel = $(this).data('is-execute-or-cancel');
				   	    layer.confirm('确定要推荐吗？', {icon: 3}, function(index){
						    $.ajax({
					   	   	  url:'cms/recommend',
					   	   	  dataType:'json',
					   	   	  data : {
					   	   	  	  id : dataId,
					   	   		  isExecuteOrCancel : isExecuteOrCancel
					   	   	  },
					   	   	  async:false,
					   	   	  success:function(data){
					   	   	  	 var status = data.status;
					   	   	  	 var msg = data.msg;
					   	   	  	 if(status == 1){
					   	   	  	 	layer.alert('操作成功！');
					   	   	  	 	$('#article-list').trigger('reloadGrid');
					   	   	  	 }else{
					   	   	  	 	layer.alert('操作失败！原因：'+msg);
					   	   	  	 }
					   	   	  }
					   	   });
						});
				   });    
				   
				   //置顶
				  $('.set-top').click(function(){
				   	    var dataId = $(this).parent().parent().find('td:eq(0)').html();
				   	    var isExecuteOrCancel = $(this).data('is-execute-or-cancel');
				   	    layer.confirm('确定要置顶吗？', {icon: 3}, function(index){
						    $.ajax({
					   	   	  url : 'cms/setTop',
					   	   	  dataType : 'json',
					   	   	  data : {
					   	   	  	  id : dataId,
					   	   		  isExecuteOrCancel : isExecuteOrCancel
					   	   	  },
					   	   	  async:false,
					   	   	  success:function(data){
					   	   	  	 var status = data.status;
					   	   	  	 var msg = data.msg;
					   	   	  	 if(status == 1){
					   	   	  	 	layer.alert('操作成功！');
					   	   	  	 	$('#article-list').trigger('reloadGrid');
					   	   	  	 }else{
					   	   	  	 	layer.alert('操作失败！原因：'+msg);
					   	   	  	 }
					   	   	  }
					   	   });
						});
				   });    
				   //删除
				   $('.delete').click(function(){
				   	    var dataId = $(this).parent().parent().find('td:eq(0)').html();
				   	    layer.confirm('确定要删除吗？', {icon: 3}, function(index){
						    $.ajax({
					   	   	  url:'cms/deleteArticle',
					   	   	  dataType:'json',
					   	   	  data : { id : dataId },
					   	   	  async:false,
					   	   	  success:function(data){
					   	   	  	 var status = data.status;
					   	   	  	 var msg = data.msg;
					   	   	  	 if(status==1){
					   	   	  	 	layer.alert('删除成功！');
					   	   	  	 	$('#article-list').trigger('reloadGrid');
					   	   	  	 }else{
					   	   	  	 	layer.alert('删除失败！原因：'+msg);
					   	   	  	 }
					   	   	  }
					   	   });
						});
				   });        	
               },
               loadComplete:function(data){ //数据加载完毕触发
               	  pageNo=data.pageNo;
               },
               serializeGridData:function(data){  //请求之前触发
               	  data['pageNo']=data['page'];
               	  data['pageSize']=data['rows'];
               	  data['sort']=data['sord'];
               	  return data;
               },
               beforeSelectRow:function(rowid,e){ //选择行之前触发
               	//console.info($("#"+rowid)); //获得当前行的tr
               	return false; 
               }
			});
	
	          $("#article-list").jqGrid('navGrid', '#pager', {
	              edit: false,
	              add: false,
	              del: false,
	              search: false
	          });
	          
	          
	          //查询
	          /*
	          $('#select-submit').click(function(){
	             $('#article-list').trigger('reloadGrid');
	             return false;
	          });*/
	          //添加
	          $('#add').click(function(){
	          	location.href='cms/toAddArticle';
	          });
	          
	          $('#delete-all-index').click(function(){
	              var $self = $(this);
	              layer.confirm('确定要删除全部索引吗？', {icon: 3}, function(index){
		              layer.close(index);
		              $self.html('操作中...');
		              $.ajax({
			              url : 'cms/deleteAllArticleIndex',
			              dataType : 'json',
			              async : false,
			              success : function(data){
			                  var status = data.status;
			                  if(status == 1){
			                  	  layer.alert('操作成功！');
			                  }else{
			                  	  layer.alert('操作失败！');
			                  }
			                  $self.html('删除全部索引');
			              },
			              error : function(){
			                  layer.alert('网络错误！');
			                  $self.html('删除全部索引');
			              }
		              });
	              });
	          });
	          
	          $('#add-all-index').click(function(){
	            var $self = $(this);
	            layer.confirm('确定要添加全部索引吗？', {icon: 3}, function(index){
	                layer.close(index);
		            $self.html('操作中...');
		            $.ajax({
		              	url : 'cms/addAllArticleIndex',
		              	dataType : 'json',
		              	async : false,
		              	success : function(data){
			                var status = data.status;
			                if(status == 1){
			                    layer.alert('操作成功！');
			                }else{
			                    layer.alert('操作失败！');
			                }
			                $self.html('添加全部索引');
		                },
			            error : function(){
			                layer.alert('网络错误！');
			                $self.html('添加全部索引');
			            }
		            });
	            });
	          });
	          
          });
  	</script>
  	
  </body>
</html>
