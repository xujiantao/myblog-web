<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>登录</title>
    <%@include file="../base.jsp"%>
    <style type="text/css">
      .login{padding-top: 130px;height: auto;}
    </style>
</head>

<body class="gray-bg">

    <div class="middle-box text-center loginscreen  animated fadeInDown login">
        <div>
            <h2>认真、谦卑、善良、坚持。加油哦！</h2>

            <form class="m-t" id="loginForm" role="form">
                <div class="form-group">
                    <input type="text" id="username" name="username" class="form-control" placeholder="用户名" maxlength="11">
                </div>
                <div class="form-group">
                    <input type="password" id="password" name="password" class="form-control" placeholder="密码">
                </div>
                <button id="submit" class="btn btn-primary block full-width m-b">登 录</button>

				<!-- 
                	<p class="text-muted text-center"> <a href="login.html#"><small>忘记密码了？</small></a> | <a href="register.html">注册一个新账号</a>
                </p> -->

            </form>
        </div>
    </div>
    <!-- jQuery Validation plugin javascript-->
    <script src="plugins/validate/jquery.validate.min.js"></script>
    <script src="plugins/validate/messages_zh.min.js"></script>
    <script type="text/javascript">
	
    	 //验证
         $("#loginForm").validate({
           		rules:{
           			username:{
           				required: true,
           			},
           			password:{
           				required: true,
           			}
           		},
           		messages:{
           			username:{
           				required: "请输入用户名",
           			},
           			password:{
           				required: "请输入密码",
           			}
           		}
           });
    
        var asynch_load_status=0;
    	$("#submit").click(function(){
    	    var flag=$("#loginForm").valid();
    	    if(flag){
    	    	var $self=$(this);
    	    	$(this).html('登录中...');
	    	    var username=$("#username").val();
	    	    var password=$("#password").val();
	    	    if(asynch_load_status==0){
	    	        asynch_load_status=1;
		    		$.ajax({
		    		   url:'loginVerify',
		    		   type:'post',
		    		   dataType:'json',
		    		   data:{username:username,password:password},
		    		   success:function(data){
		    		   	   var status=data.status;
		    		   	   if(status==1){
		    		   	        location.href='cms/articleList';
		    		   	   }else{
		    		   	   	    var errinfo='登录失败';
		    		   	   	    if(status==0){
		    		   	   	    	errinfo='用户名或密码错误';
		    		   	   	    }
		    		   	        var label='<label style="display: inline-block;" for="password" class="error" id="password-error">'+errinfo+'</label>';
		    		   	   	    $("#username,#password").removeClass("valid").addClass("error");
		    		   	   	    $("#password").after(label);
		    		   	   }
		    		   	   $self.html('登录');
		    		   	   asynch_load_status=0;
		    		   },
		    		   error:function(){
		    		   	   $self.html('登录');
		    		       asynch_load_status=0;
		    		   }
		    		});
	    		}
    		}
    		return false;
    	});
    </script>

</body>

</html>