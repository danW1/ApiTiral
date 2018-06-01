<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeacherMain.aspx.cs" Inherits="CRM_Test.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Excel/jquery.table2excel.js"></script>
    <script type="text/javascript">
        $(function () {
            TeacherQuery();
            //导出
            $("#btndaochu").click(function () {
                $("#TeacherInfo").table2excel({
                    exclude: ".noExl",
                    name: "Excel Document Name",
                    filename: "myFileName",
                    exclude_img: true,
                    exclude_links: true,
                    exclude_inputs: true
                });
            });
            //导出
            //$("#btndaochu").click(function () {
            //    $.ajax({
            //        type: "get",
            //        url: "Handler/TeachersHandler.ashx",
            //        dataType: "json",
            //        data: {
            //            Method: "TeacherQueryrt"
                  
            //        },
            //        success: function (data) {

            //            Export('导出excel', data)
            //        }
            //    });
            //});
            //function Export(strXlsName, exportGrid) {

            //    var f = $('<form action="/exprotTable.aspx" method="post" id="fm1"></form>');//我们弹出导出excel的界面的路径
            //    var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            //    var l = $('<input type="hidden" id="txtName" name="txtName"/>');
            //    i.val(ChangeToTable(exportGrid));
               

            //    i.appendTo(f);
            //    l.val(strXlsName);
            //    l.appendTo(f);
            //    f.appendTo(document.body).submit();
            //    document.body.removeChild(f);
            //}
            //function ChangeToTable(printDatagrid) {
            //    var tableString = '<table cellspacing="0" class="pb">';
            //    tableString += '\n<tr>';
            //    tableString += '\n<th width="100px">老师姓名</th>';
            //    tableString += '\n<th width="100px">老师性别</th>';
            //    tableString += '\n<th width="100px">老师电话</th>';
            //    tableString += '\n</tr>';

            //    $.each(printDatagrid, function (index, i) {
            //        tableString += '\n<tr>';
            //        tableString += '\n<td style="text-align:"undefined;">' + i.T_Name + '</td>';
            //        tableString += '\n<td style="text-align:"undefined;">' + i.T_Sex + '</td>';
            //        tableString += '\n<td style="text-align:"undefined;">' + i.T_Tel + '</td>';
            //        tableString += '\n</tr>';
            //    })
            //    tableString += '\n</table>';

            //    return tableString;
            //}

            //点击查询时，按条件查询
            $("#btnSeach").click(function () {
                TeacherQuery();

            });

            //点击添加按钮，弹出添加框
            $("#btnAdd").click(function () {
                $("#btnSubmitUpdate").hide();
                $("#btnSubmitAdd").show();
                
                $("#txtNameAdd").val("");
                $("#radWomanAdd").is(":checked") ? "女" : "男";
                $("#txtTelAdd").val("");
                $("#txtCategoryAdd").val(3);
                $("#txtLoginNameAdd").val("");
                $("#txtRoleAdd ").val(0);

              
                $("#myModal").modal({ backdrop: "static" });
                $("#myModalLabel").text("添加用户");

            });
            //执行添加方法
            $("#btnSubmitAdd").click(function () {

                $.ajax({
                    type: "post",
                    url: "Handler/TeachersHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "TeacherAdd",
                        T_Name:$("#txtNameAdd").val(),
                        T_Sex:$("#radWomanAdd").is(":checked") ? "女" : "男",
                        T_Tel :$("#txtTelAdd").val(),
                        T_Category: $("#txtCategoryAdd option:selected").val(),
                        T_LoginName: $("#txtLoginNameAdd").val(),
                        T_Role: $("#txtRoleAdd option:selected").val(),
                    },//所有前台向后台传值的代码都写在这里面
                    success: function (data) {
                        if (data == "1") {
                            alert("添加成功！！");
                            TeacherQuery();//重新加载表格
                            $("#myModal").modal("hide");//隐藏弹框
                         

                        } else {
                            alert("添加失败！！");
                        }

                    }

                });



            });

            //修改
            $("#btnSubmitUpdate").click(function () {
                var id = $("#hid_Tid").val();
                //alert(id);

                $.ajax({
                    type: "post",
                    url: "Handler/TeachersHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "TeacherUpdate",
                        T_Name: $("#txtNameAdd").val(),
                        T_Sex: $("#radWomanAdd").is(":checked") ? "女" : "男",
                        T_Tel: $("#txtTelAdd").val(),
                        T_Category: $("#txtCategoryAdd option:selected").val(),
                        T_LoginName: $("#txtLoginNameAdd").val(),
                        T_Role: $("#txtRoleAdd option:selected").val(),
                        T_ID: $("#hid_Tid").val()
                    },//所有前台向后台传值的代码都写在这里面
                    success: function (data) {
                        if (data == "1") {
                            alert("修改成功！！");
                            TeacherQuery();//重新加载表格
                            $("#myModal").modal("hide");//隐藏弹框

                        } else {
                            alert("修改失败！！");
                        }

                    }

                });
            });

        });

        //查询所有Teacher表信息
        function TeacherQuery()
        {
            $.ajax({
                type: "get",
                url: "Handler/TeachersHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TeacherQuery",
                    LoginName:$("#txtAdminName").val(),
                    Name:$("#txtName").val(),
                    Tel:$("#txtTel").val(),
                    Category: $("#ddlT_Category").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {

                        var T_category="";

                        if (i.T_Category == 0) {
                            T_category = "教员";
                        }
                        else {
                            T_category = "督导";
                        }
                        //系统角色 1管理员 2教员 3督导 4学生
                        if (i.T_Role == "1")
                        {
                            i.T_Role ="管理员";
                        }
                        else if (i.T_Role == "2")
                        {
                            i.T_Role = "教员";
                        }
                        else if (i.T_Role == "3") {
                            i.T_Role = "督导";
                        }
                        else{
                            i.T_Role ="学生";
                        }
                        if (i.T_IsEnabled == true) {
                           i.T_IsEnabled = "是";
                        } else {
                            i.T_IsEnabled = "否";
                       }
                        str += "<tr>";
                        str += "<td>" + i.T_ID + "</td>";
                        str += "<td>" + i.T_Name + "</td>";
                        str += "<td>" + i.T_Sex + "</td>";
                        str += "<td>" + i.T_Tel + "</td>";
                        str += "<td>" + T_category + "</td>";
                        str += "<td>" + i.T_LoginName + "</td>";
                        str += "<td>" + i.T_Pwd + "</td>";
                        str += "<td>" + i.T_Role + "</td>";
                        str += "<td>" + i.T_IsEnabled + "</td>";
                        str += "<td>" + i.T_LastLoginTime + "</td>";

                        if (i.T_Role == "管理员") {
                            str += "<td><button type=\"button\" class=\"btn btn-primary\" onclick='TeacherUpdate(" + i.T_ID + ")'>修改</button> <button type=\"button\" class=\"btn btn-warning\" onclick='UpdateTeacherTid(" + i.T_ID + ")'>重置密码</button>";
                        } else {
                            str += "<td><button type=\"button\" class=\"btn btn-primary\" onclick='TeacherUpdate(" + i.T_ID + ")'>修改</button> <button type=\"button\" class=\"btn btn-danger\" onclick='TeacherDelete(" + i.T_ID + ")'>删除</button><button type=\"button\" class=\"btn btn-warning\" onclick='UpdateTeacherTid(" + i.T_ID + ")'>重置密码 </button>";
                        }
                        str += "</td>";
                        if (i.T_IsEnabled == "是") {
                            str += "<td><button type=\"button\" class=\"btn btn-warning\"  onclick='TeacherUpdateIsEnabled(" + i.T_ID + ")'>✔ </button></td>";
                        }
                        else {
                            str += "<td><button type=\"button\" class=\"btn btn-warning\" onclick='TeacherUpdateIsEnabled(" + i.T_ID + ")'> ✘</button></td>";
                        }
                        str += "</tr>";
                      
                    });
                    $("#TeacherInfo tr:gt(0)").remove();
                    $("#TeacherInfo").append(str);
                   // $("#hid_IsEnabled").val(data[0], i.T_IsEnabled);
                }
            });
        }
        //点击是否禁用图标时
        function TeacherUpdateIsEnabled(id)
        {
           
            $.ajax({
                type:"post",
                url:"Handler/TeachersHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TeacherIsEnabled",
                    uid: id,
                    IsEnabled: $("#hid_IsEnabled").val()
                },
                success: function (data)
                {
                    if (data == "1") {
                      
                        alert("操作成功！");
                        TeacherQuery();
                    }
                    else {
                        alert("操作失败！")
                    }
                }
            });

        }
        //删除Teaxher表的信息
        function TeacherDelete(id)
        {
            if (confirm("您确定要删除吗？")) {
                $.ajax({
                    type: "post",
                    url: "Handler/TeachersHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "TeacherDelete",
                        uid:id
                    },
                    success: function (data) {

                        if (data == "1") {
                            alert("删除成功！");
                            TeacherQuery();
                        }
                        else {
                            alert("删除失败！")
                        }
                    }
                });

            }

        }

        //重置密码(123) 
        function UpdateTeacherTid(id)
        {
            if (confirm("您确定要重置密码吗？"))
            {
                $.ajax({
                    type:"post",
                    url: "Handler/TeachersHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "UpdateTeacherTid",
                        Tid: id
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("您已成功重置密码，初始密码：123！");
                            TeacherQuery();
                        } else {
                            alert("重置失败！");
                        
                        }
                    }
                });
            }
        }

        //点击修改按钮是获取值
        function TeacherUpdate(id) {
            $("#myModal").modal({ backdrop: "static" });
            $("#myModalLabel").text("修改用户");
            $("#btnSubmitUpdate").show();
            $("#btnSubmitAdd").hide();
            $.ajax({
                type: "get",
                url: "Handler/TeachersHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TeacherUpdateid",
                    uid: id

                },
                success: function (data) {
                    $("#txtNameAdd").val(data[0].T_Name);
                    if (data[0].T_Sex == "男") {
                        $("#radManAdd").prop("checked", "checked");
                    } else {
                        $("#radManAdd").prop("checked", "checked");
                    };
                    $("#txtTelAdd ").val(data[0].T_Tel);
                    $("#txtCategoryAdd").val(data[0].T_Category);
                    $("#txtLoginNameAdd ").val(data[0].T_LoginName);
                    $("#txtRoleAdd ").val(data[0].T_Role);
                    $("#hid_Tid").val(id);
                }
                
            });
        }

    //初始化相关元素高度
    function init(){
        $("body").height($(window).height()-80);
        $("#iframe-main").height($(window).height()-90);
        $("#sidebar").height($(window).height()-50);
    }
        //获取登录用户的姓名
    function GetName() {
        $.ajax({
            url: "Handler/TeachersHandler.ashx",
            type: "get",
            dataType:"json",
            data: {
                Method: "GetName"
            },
            success: function (data) {
                $("#Name").text(data);//给Span赋值
            }, error: function () {
                //alert("未知错误！")
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
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
          <input id="hid_IsEnabled" type="hidden" />
        <input id="hid_Tid" type="hidden" />
      <table>
                <tr>
                    <td>登录名：<input id="txtAdminName" type="text" /></td>
                    <td>姓名：<input id="txtName" type="text" /></td>
                    <td>电话：<input id="txtTel" type="text" /></td>
                    <td>教员/督导：<select id="ddlT_Category">
                        <option value="3">--请选择--</option>
                        <option value="1">督导</option>
                        <option value="0">教员</option>
                    </select>

                    </td>
                    <td>
                        <button type="button" class="btn btn-success" id="btnSeach">查询</button>
                        <button type="button" class="btn btn-warning" id="btnAdd">添加</button>
                         <button type="button" class="btn btn-warning" id="btndaochu">导出</button>
                    </td>
                </tr>
            </table>


            <table class="table table-hover" id="TeacherInfo">
                <thead>
                    <tr>
                        <th>编号</th>
                        <th class="auto-style1">姓名</th>
                        <th>性别</th>
                        <th>电话</th>
                        <th>教员/督导</th>
                        <th>登录名</th>
                        <th>密码</th>
                        <th>系统角色</th>
                        <th>是否可用</th>
                        <th>登录时间</th>
                        <th>操作</th>
                        <th>是否启用</th>
                    </tr>

                </thead>
                <%--  <tr>
                        <td>编号</td>
                        <td>姓名</td>
                        <td>编号</td>
                        <td>年龄</td>
                        <td>电话</td>
                        <td>部门</td>
                    </tr>--%>
            </table>

        </div>

      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel">模态框（Modal）标题
                        </h4>
                    </div>
                    <div class="modal-body">
                        <table>
                            <tr>
                                <td>姓名：</td>
                                <td>
                                    <input id="txtNameAdd" type="text" /></td>
                            </tr>
                            <tr>
                                <td>性别：</td>
                                <td>
                                    <input id="radWomanAdd" type="radio" name="sex" checked="checked" />女<input id="radManAdd" type="radio" name="sex" />男  </td>
                            </tr>
                              <tr>
                                <td>电话：</td>
                                <td>
                                    <input id="txtTelAdd" type="text" /></td>


                            </tr>
                            <tr>
                                <td>教员or督导：</td>
                                <td>
                                    <select id="txtCategoryAdd">
                        <option value="3">--请选择--</option>
                        <option value="0">教员</option>
                        <option value="1">督导</option>
                        
                       
                    </select>
                                </td>
                               


                            </tr>
                             <tr>
                                <td>登录名：</td>
                                <td>
                                    <input id="txtLoginNameAdd" type="text" /></td>
                            </tr>
                             
                               <tr>
                                <td>系统角色：</td>
                                   <td>
                                    <select id="txtRoleAdd">
                        <option value="0">--请选择--</option>
                        <option value="1">管理员</option>
                        <option value="2">教员</option>
                        <option value="3">督导</option>
                        <option value="4">学生</option>
                    </select>

                                </td>
                                

                            </tr>
                   
                          


                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                            data-dismiss="modal">
                            关闭
                        </button>
                         <button type="button" class="btn btn-primary" id="btnSubmitUpdate">
                          修改
                        </button>
                        <button type="button" class="btn btn-primary" id="btnSubmitAdd">
                           添加
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>
    </form>
</body>
</html>
