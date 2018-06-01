<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CRM_Test.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="css/matrix-login.css" />
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href='#' rel='stylesheet' type='text/css' />
    <script src="Scripts/jquery-1.10.2.js"></script>
    <style type="text/css">
        input {
            font-family: "Microsoft Yahei";
        }

        .control-label {
            color: #B2DFEE;
            padding-left: 4px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            //点击登录按钮时
      
            $("#BtnLogin").click(function () {

                $.ajax({
                    type: "get",
                    url: "Handler/TeachersHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "TeacherAdmin",
                        loginName: $("#loginName").val(),
                        Pwd: $("#LoginPwd").val()

                    },
                    success: function (data) {
                        if (data == "1") {
                            window.location.href = "Index.aspx";

                        } else if (data == "2") {
                            window.location.href = "Indexx.aspx";
                        }
                        else if (data == "3") {
                            alert("登录成功，进行页面跳转");
                        }
                        else if (data == "4") {
                            alert("登录成功，进行页面跳转");
                        }
                        else if (data =="0") {
                            alert("此用户不存在或输入错误");
                        }
                        else {
                            alert("此用户已禁用");
                        }
                    }

                });

            });


        });
     


      

    </script>
 
</head>
<body onkeydown="keydown()">
    <div id="loginbox">  
        <div class="control-group normal_text"> 
            <h2 style="color:#B2DFEE;font-size:28px;">CRM管理系统</h2>
            <span style="font-size:14px;color:gray;">版权所有 &copy; iProg网络科技有限公司 2015-2018</span>
        </div>
        <form id="loginform" class="form-vertical" action="http://themedesigner.in/demo/matrix-admin/index.html">
            <div class="control-group">
                <label class="control-label">登陆账号</label>
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on bg_lg"><i class="icon-user" style="font-size:16px;"></i></span><input type="text" value="admin"  id="loginName"/>
                    </div>
                </div>
            </div>
            <div class="control-group2">
                <label class="control-label">登陆密码</label>
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on bg_ly"><i class="icon-lock" style="font-size:16px;"></i></span><input type="password" id="LoginPwd" />
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <span class="pull-left"><a href="#" class="flip-link btn btn-info" id="to-recover">忘记密码？</a></span>
                <span class="pull-right"><input type="button" id="BtnLogin" class="btn btn-success" style="width:335px;" value=" 登&nbsp;&nbsp;&nbsp;&nbsp;录"/></span>
            </div>
            <div class="control-group normal_text">
                <div style="font-size:14px;color:gray;">推荐使用webkit内核浏览器，如chrome等</div>
            </div>
        </form>
        

        <form id="recoverform" action="#" class="form-vertical" style="padding-top:10px;">
            <label class="control-label">登陆账号</label>
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_lg"><i class="icon-user" style="font-size:16px;"></i></span><input type="text" name="re_username"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">新密码</label>
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on bg_ly"><i class="icon-lock" style="font-size:16px;"></i></span><input type="password" name="re_password"/>
                    </div>
                </div>
            </div>
            <div class="control-group" style="padding-top:0px;">
                <label class="control-label">确认新密码</label>
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on bg_ly"><i class="icon-lock" style="font-size:16px;"></i></span><input type="password" name="re_confirmpassword" />
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <span class="pull-left"><a href="#" class="flip-link btn btn-success" id="to-login">&laquo; 返回登录</a></span>
                <span class="pull-right"><a id="changePwd" class="btn btn-info" style="width:310px;">重置密码</a></span>
            </div>
            <div class="control-group normal_text">
                <div style="font-size:14px;color:gray;">推荐使用webkit内核浏览器，如chrome等</div>
            </div>
        </form>

    </div>
    
    <script src="js/jquery.min.js"></script>  
    <script src="js/matrix.login.js"></script> 
</body>
</html>
