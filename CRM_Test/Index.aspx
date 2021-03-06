﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="CRM_Test.Index" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>CRM后台管理</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="css/matrix-style.css" />
    <link rel="stylesheet" href="css/matrix-media.css" />
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type ="text/javascript" >
      
    </script>
</head>
<body>
    <!--Header-part-->
    <div id="header">
      <h1><a href="dashboard.html">管理员登录系统</a></h1>
    </div>
    <!--close-Header-part--> 

    <!--top-Header-menu-->
    <div id="user-nav" class="navbar navbar-inverse">
        <ul class="nav">
            <li  class="dropdown" id="profile-messages" >
                <a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle">
                    <i class="icon icon-user"></i>&nbsp;
                    <span class="text">欢迎你，</span><span class="text" id="Name"></span>&nbsp;
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#"><i class="icon-user"></i> 个人资料</a></li>
                    <li class="divider"></li>
                    <li><a href="#"><i class="icon-check"></i> 我的任务</a></li>
                    <li class="divider"></li>
                    <li><a href="Login.aspx"><i class="icon-key"></i> 退出系统</a></li>
                </ul>
            </li>
            <li class="dropdown" id="menu-messages">
                <a href="#" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle">
                    <i class="icon icon-envelope"></i>&nbsp;
                    <span class="text">我的消息</span>&nbsp;
                    <span class="label label-important">4</span>&nbsp; 
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li><a class="sAdd" title="" href="#"><i class="icon-plus"></i> 新消息</a></li>
                    <li class="divider"></li>
                    <li><a class="sInbox" title="" href="#"><i class="icon-envelope"></i> 收件箱</a></li>
                    <li class="divider"></li>
                    <li><a class="sOutbox" title="" href="#"><i class="icon-arrow-up"></i> 发件箱</a></li>
                    <li class="divider"></li>
                    <li><a class="sTrash" title="" href="#"><i class="icon-trash"></i> 回收站</a></li>
                </ul>
            </li>
            <li class=""><a title="" href="#"><i class="icon icon-cog"></i> <span class="text">&nbsp;设置</span></a></li>
            <li class=""><a title="" href="Login.aspx"><i class="icon icon-share-alt"></i> <span class="text">&nbsp;退出系统</span></a></li>
        </ul>
    </div>
    <!--close-top-Header-menu-->

    <!--start-top-serch-->
    <div id="search">
        <input type="text" placeholder="搜索..."/>
        <button type="submit" class="tip-bottom" title="Search"><i class="icon-search icon-white"></i></button>
    </div>
    <!--close-top-serch-->

    <!--sidebar-menu-->
    <div id="sidebar" style="OVERFLOW-Y: auto; OVERFLOW-X:hidden;">
        <ul>
            <li class="submenu active">
                <a class="menu_a" link=""><i class="icon icon-home"></i> <span>主页</span></a> 
            </li>
            <li class="submenu"> 
                <a link="School_prvinces.aspx" class="menu_a">
                    <i class="icon icon-table"></i> 
                    <span>校区管理</span> 
                    <span></span>
                </a>
            </li>
            <li class="submenu">
				<a link="StationPeriods.aspx" class="menu_a">
                    <i class="icon icon-th"></i> 
                    <span>选岗设置</span>
                </a>
            </li>
            <li class="submenu"> 
                <a href="#">
                    <i class="icon icon-stop"></i> 
                    <span>专业岗位</span> 
                    <%--<span class="label badge-warning">3</span>--%>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span class="badge badge-warning">3</span>
                </a>
                <ul>
                    <li><a class="menu_a" link="Specialties.aspx"><i class="icon icon-caret-right"></i>专业管理</a></li>
                    <li><a class="menu_a" link="StationsAjax.aspx"><i class="icon icon-caret-right"></i>岗位管理</a></li>
                    <li><a class="menu_a" link="SetStations.aspx"><i class="icon icon-caret-right"></i>给校区专业设置岗位</a></li>
                </ul>
            </li>
            <li class="submenu"> 
                <a class="menu_a" link="TrainClass.aspx">
                    <i class="icon icon-flag"></i> 
                    <span>实训班级</span> 
                </a>
            </li>
            <li class="submenu"> 
                <a class="menu_a" link="SetClass.aspx">
                    <i class="icon icon-tasks"></i> 
                    <span>带班管理</span> 
                </a>
            </li>
            <li class="submenu">
                <a class="menu_a" link="TeacherMain.aspx"><i class="icon icon-group"></i> <span>用户管理</span></a> 
            </li>
            <li class="submenu"> 
                <a class="menu_a" link="OperationLogs.aspx">
                    <i class="icon icon-info-sign"></i> 
                    <span>用户操作日志</span> 
                </a>
            </li>
        </ul>
    </div>
    <!--sidebar-menu-->

    <!--main-container-part-->
    <div id="content">
        <!--breadcrumbs-->
        <div id="content-header">
          <div id="breadcrumb"> <a class="menu_a" link="Main.aspx" title="Go to Home"><i class="icon-home"></i>主页</a></div>
        </div>
        <!--End-breadcrumbs-->
        <iframe src="TeacherMain.aspx" id="iframe-main" frameborder='0' style="width:100%;"></iframe>
    </div>
    <!--end-main-container-part-->

    <script src="js/excanvas.min.js"></script> 
    <script src="js/jquery.min.js"></script> 
    <script src="js/jquery.ui.custom.js"></script> 
    <script src="js/bootstrap.min.js"></script> 
    <script src="js/nicescroll/jquery.nicescroll.min.js"></script> 
    <script src="js/matrix.js"></script> 


    <script type="text/javascript">

    //初始化相关元素高度
    function init(){
        $("body").height($(window).height()-80);
        $("#iframe-main").height($(window).height()-90);
        $("#sidebar").height($(window).height()-50);
    }
        //获取登录用户的姓名
    function GetName() {
        $.ajax({
            url: "Handlers/TeachersHandler.ashx",
            type: "post",
            data: {
                Method: "GetName"

            },
            success: function (data) {
                $("#Name").text(data);//给Span赋值
            }, error: function () {
              
            }
        })
    }
    $(function () {
        GetName();
        init();
        $(window).resize(function(){
            init();
        });
    });

    // This function is called from the pop-up menus to transfer to
    // a different page. Ignore if the value returned is a null string:
    function goPage (newURL) {
        // if url is empty, skip the menu dividers and reset the menu selection to default
        if (newURL != "") {
            // if url is "-", it is this page -- reset the menu:
            if (newURL == "-" ) {
                resetMenu();            
            } 
            // else, send page to designated URL            
            else {  
                document.location.href = newURL;
            }
        }
    }

    // resets the menu selection upon entry to this page:
    function resetMenu() {
        document.gomenu.selector.selectedIndex = 2;
    }

    // uniform使用示例：
    // $.uniform.update($(this).attr("checked", true));
    </script>
</body>
</html>

