<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
  <head>
  	<%@include file="../base.jsp" %>
  	<title>添加文章</title>
  	<!-- 标签插件 -->
    <link href="plugins/tagsinput/css/jquery.tagsinput.css" rel="stylesheet">
  </head>
  
  <body>
  	<div class="ibox float-e-margins">
        <div class="ibox-title">
        	<h5>添加文章</h5>
    	</div>
	    <div class="ibox-content no-padding">
		  	<form id="articleForm" class="form-horizontal form" style="margin-top: 10px;">
			   <div class="form-group">
			      <label for="title" class="col-sm-2 control-label"><span style="color:red;margin-right: 2px;">*</span>标题</label>
			      <div class="col-sm-8">
			         <div>
			         	<input type="text" class="form-control" id="title" name="title" maxlength="20" placeholder="请输入标题">
			         </div>
			      </div>
			   </div>
			   <div class="form-group">
			      <label for="lead" class="col-sm-2 control-label">描述</label>
			      <div class="col-sm-8">
			         <div>
			         	<textarea class="form-control" id="lead" name="lead" placeholder="请输入描述"></textarea>
			         </div>
			      </div>
			   </div>
			   <div class="form-group">
			      <label for="content" class="col-sm-2 control-label"><span style="color:red;margin-right: 2px;">*</span>内容</label>
			      <div class="col-sm-8">
			         <script type="text/javascript" id="content"></script>
			      	 <span id="content-error" style="color: red; line-height: 33px;display: none;">请填写内容</span>
			      </div>
			   </div>
			   <div class="form-group">
			      <label for="tag" class="col-sm-2 control-label">标签</label>
			      <div class="col-sm-8">
			      	 <input id="tags" name="tags" type="text" class="tags" value=""/>
			      </div>
			   </div>
			   <div class="form-group">
			   	  <div class="col-sm-12" style="text-align: center;">
			         <button id="submit" class="btn btn-success" style="margin-right: 30px;">确定</button>
			         <input type="reset" class="btn btn-default">
			      </div>
			   </div>
			</form>
  		
  		</div>
	</div>
	<!-- ueditor -->
    <script src="plugins/ueditor1_4_3/ueditor.config.js"></script>
    <script src="plugins/ueditor1_4_3/ueditor.all.js"></script>
    <!-- jQuery Validation plugin javascript-->
    <script src="plugins/validate/jquery.validate.min.js"></script>
    <script src="plugins/validate/messages_zh.min.js"></script>
    <!-- 标签插件 -->
    <script src="plugins/tagsinput/js/jquery.tagsinput.min.js"></script>
  	<script type="text/javascript">
  	
  		   var bjtoolbars=[
           'source','|', 'undo', 'redo', '|','bold','italic','underline','strikethrough','|','superscript','subscript','|','forecolor','backcolor','|','removeformat','|',
            'insertorderedlist','insertunorderedlist','|','selectall','cleardoc','paragraph','|','fontfamily','fontsize' ,
            '|','justifyleft','justifycenter','justifyright','justifyjustify','|',
            'link','unlink','|','insertImage','insertVideo','|','map',
            '|','horizontal','inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|'
            ];
            //实例化百度编辑器
           var ue = UE.getEditor('content',{ toolbars:[bjtoolbars],initialFrameHeight:500});
           
        $('#tags').tagsInput({ width: 'auto',defaultText:'请填写标签'});
  		//验证
  		(function(){
			
  			$("#articleForm").validate({
           		rules:{
           			title:{
           				required: true,
           			},
           		},
           		messages:{
           			title:{
           				required: "请填写标题",
           			},
           		},
           		errorPlacement: function(error, element) { //错误信息显示位置
           			var message=error.html(); 
           			var id=error.attr('id'); //错误信息的id，如：startTime-error
           			var html='<span id="'+id+'" style="color:red;line-height:33px;" class="error">'+message+'</span>';
           			element.parent().after(html);
				},
				errorElement: 'span',
           });
           function myValidate(){
             var bool=true;
             var content=ue.getContent().trim();
             if(content==''){
             	bool=false;
             	$('#content-error').show();
             }else{
             	$('#content-error').hide();
             }
	         return bool;
           }
           //提交表单验证
           $('#submit').click(function(){
           	   var bool=$("#articleForm").valid();
           	   var bool2=myValidate();
           	   if(bool&&bool2){
           	   	  var $self=$(this);
           	   	  $self.html('提交中...');
           	   	  var title = $('#title').val().trim();
           	   	  var lead = $('#lead').val().trim();
           	   	  var content =ue.getContent();
           	   	  var tags=$('#tags').getTags();
           	   	  $.ajax({
           	   	  	url:'cms/addArticle',
           	   	  	type:'post',
           	   	  	dataType:'json',
           	   	  	async:false,
           	   	  	data:{
           	   	  		title : title,
           	   	  		lead : lead,
           	   	  		content : content,
           	   	  		tags : tags
           	   	  	},
           	   	  	success:function(data){
           	   	  		var status=data.status;
           	   	  		var msg=data.msg;
           	   	  		$self.html('确定');
           	   	  		if(status==1){
           	   	  			layer.alert('添加成功！');
           	   	  			//location.href='cms/articleList';
           	   	  		}else{
           	   	  			layer.alert('添加失败！原因：'+msg);
           	   	  		};
           	   	  	},
           	   	  	error:function(){
           	   	  		layer.alert('请求异常！');
           	   	  		$self.html('确定');
           	   	  	}
           	   	  });
           	   	  
           	   }
           	   
           	   return false;
           });
  		})();
  	
  	
  	</script>
  	
  </body>
</html>
