<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrainClassStudent.aspx.cs" Inherits="CRM_Test.TrainClassStudent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            PrivicesQuery();   //查询所有省份信息
            TrainClass();
            StationsQuery();  //显示所有岗位
            TrainClassStudentQuery();  //查询所有分班管理信息

            //点击查询按钮时
            $("#btnSeach").click(function () {
                TrainClassStudentQuery();
                $("#ddl_Scid").val(0);
            });

            $("#btnClick").click(function () {
                $(".ddlP_id").val(0); //省份编号
                $(".ddlStion_id").val(0);  //岗位编号
            });

            //换班
            $("#btnStudenUpdate").click(function () {
                StudentClassUpdate();
            });
            //点击对选定学生分班
            $("#btnStufenban").click(function () {
                $("#myModal").modal({ backdrop: "static" });
                $("myModalLabel").text("分班");
                $("#btnStudenUpdate").text("分到此班");
                $("#btnStudenfen").show();
                $("#btnStudenUpdate").hide();
            });
            //分到此班
            $("#btnStudenfen").click(function () {
                var str = "";
                var chklist = $(".chked");  //通过旋转器找到所有的复选框
                for (var i = 0; i < chklist.length == true; i++) {
                    //判断复选框有没有被选中，选中的用str字符串储存
                    if (chklist[i].checked == true) {
                        str += chklist[i].value + ";";

                    }

                }
                //去掉最后多了的分号 substring关键字截取字符串 0代表从多少位开始截取 后面的一个参数是截取到结束的位置（长度减一）
                str = str.substring(0, str.length - 1);
                //判断是否选择了班级
                if ($("#txtTcName").val() == 0)
                {
                    alert("请选择班级！！");
                    return;
                }
                if (str == "")
                {
                    alert("请选择需要换班的学生！！");
                    return;
                }
               

                $.ajax({
                    type: "post",
                    url: "Handler/TrainClassStudentHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "StudenUpdate",
                        Stuid: str,
                        Tcid:$("#txtTcName").val()
                    },
                    success: function (data) {
                        if (data != 0) {
                            alert("分班成功！！");
                            $("#myModal").modal("hide");
                            TrainClassStudentQuery();
                        } else {
                            alert("分班失败！！");
                        }

                    }
                });
            });
        });
        //查询所有分班管理信息
        function TrainClassStudentQuery() {
            $.ajax({
                type: "get",
                url: "Handler/TrainClassStudentHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TrainClassStudentQuery",
                    classstu: $("input[name=class]:checked").val(),//是否分配
                    P_id: $(".ddlP_id").val(), //省份编号
                    S_id: $(".ddlS_id").val(),  //校区编号
                    Scid: $(".ddl_Scid").val(),  //班级编号
                    Stionid: $(".ddlStion_id").val()  //岗位编号
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, e) {
                        str += "<tr>";
                        str += "<td><input type=\"checkbox\" class=\"chked\" value='" + e.Student_ID + "' /></td>";
                        str += "<td>" + e.Student_Name + "</td>";
                        str += "<td>" + e.Station_Name + "</td>";
                        str += "<td>" + e.TC_ID + "</td>";
                        str += "<td>" + e.Student_Sex + "</td>";
                        str += "<td>" + e.P_Name + "</td>";
                        str += "<td>" + e.School_Name + "</td>";
                        str += "<td>" + e.SC_Name + "</td>";
                        str += "<td> <button type=\"button\" class=\"btn btn-primary\" onclick='TrainClassUpdate(&nbsp;" + e.TC_ID + "&nbsp,&nbsp;" + e.Student_ID + ")' >换班</button></td>"
                        str += "</tr>";
                    });

                    $("#TrainClassSudent tr:gt(0)").remove();
                    $("#TrainClassSudent").append(str);
                }

            });
        }
        //点击换班按钮时
        function TrainClassUpdate(Tcid,Sid)
        {
            $("#Hid_Sid").val(Sid);
            $("#Hid_Tcid").val(Tcid);
            $("#myModal").modal({ backdrop: "static" });
            $("#myModalLabel").text("换班");
            $("#btnStudenUpdate").show();
            $("#btnStudenfen").hide();
            TrainClassQuery();
        }
        //根据学生所在实训班级查询实训班级信息
        function TrainClassQuery() {
            $.ajax({
                type: "get",
                url: "Handler/TrainClassStudentHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TrainClassQuery",
                    tcid:$("#Hid_Tcid").val()
                },
                success: function (data) {
                    if (data != 0) {
                        $("#txtTcName").val(data[0].TC_ID);
                    }
                    else {
                       
                        $("#txtTcName").val(0);
                    }
                   
                }
            });
        }
        //查询所有实训班级信息
        function TrainClass()
        {
            $.ajax({
                type: "get",
                url: "Handler/TrainClassStudentHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TrainClass"
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<option value='" + i.TC_ID + "'>" + i.TC_Name + "</option>";
                    });
                    $("#txtTcName option:gt(0)").remove();
                    $("#txtTcName").append(str);
                }
            });
        }
        //查询所有省份信息
        function PrivicesQuery() {
            $.ajax({
                type: "get",
                url: "Handler/TrainClassStudentHandler.ashx",
                dataType: "json",
                data: {
                    Method: "PrivicesQuery"
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<option value='" + i.P_ID + "'>" + i.P_Name + "</option>";
                    });

                    $(".ddlP_id option:gt(0)").remove();
                    $(".ddlP_id").append(str);
                }
            });


        }
        //根据省份编号查询校区信息
        function StudentSQuery() {
            $(".ddlS_id").empty();
            $.ajax({
                type: "get",
                url: "Handler/TrainClassStudentHandler.ashx",
                dataType: "json",
                data: {
                    Method: "StudentSQueryd",
                    P_id: $(".ddlP_id").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, o) {
                        str += "<option value='" + o.School_ID + "'>" + o.School_Name + "</option>";
                    });

                    $(".ddlS_id option:gt(0)").remove();
                    $(".ddlS_id").append(str);
                }
            });

        }
        //跟据校区编号查询班级名称
        function SchoolClassQuery() {
            $(".ddl_Scid").empty();
            $.ajax({
                type: "get",
                url: "Handler/TrainClassStudentHandler.ashx",
                dataType: "json",
                data: {
                    Method: "SchoolClassQuery",
                    S_id: $(".ddlS_id").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, x) {
                        str += "<option value='" + x.SC_ID + "'>" + x.SC_Name + "</option>";
                    });

                    $(".ddl_Scid option:gt(0)").remove();
                    $(".ddl_Scid").append(str);
                }
            });
        }
        //显示所有岗位
        function StationsQuery() {
            $.ajax({
                type: "get",
                url: "Handler/TrainClassStudentHandler.ashx",
                dataType: "json",
                data: {
                    Method: "StationsQuery"

                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, x) {
                        str += "<option value='" + x.Station_ID + "'>" + x.Station_Name + "</option>";
                    });

                    $(".ddlStion_id option:gt(0)").remove();
                    $(".ddlStion_id").append(str);
                }
            });
        }

        //换班（根据学生编号修改班级）
        function StudentClassUpdate() {
            $.ajax({
                type: "post",
                url: "Handler/TrainClassStudentHandler.ashx",
                dataType: "json",
                data: {
                    Method: "StudentClassUpdate",
                    tcidh:$("#Hid_Tcid").val(),
                    Tcid:$("#txtTcName").val(),
                    Sid: $("#Hid_Sid").val()
                },
                success: function (data) {
                    if (data != 0)
                    {
                        alert("换班成功！！");
                        $("#myModal").modal("hide");
                        TrainClassStudentQuery();
                    } else {
                        alert("换班失败！！");
                    }

                }
            });
        }

        //复选框的触发事件
        function chk_Class() {
            if ($(".chk").prop("checked")) {
                $(".chked").prop("checked", "checked");

            } else {
                $(".chked").prop("checked", false);
            }
        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <table>
                    <tr>

                        <td>省份名称：
                            <select class="ddlP_id" onchange="StudentSQuery()">
                                <option value="0">--请选择--</option>
                            </select>&nbsp;&nbsp;
                        </td>
                        <td>选择校区：
                            <select class="ddlS_id" onchange="SchoolClassQuery()">
                                <option value="0"></option>
                            </select>

                        </td>
                        <td>选择班级：
                             <select class="ddl_Scid">
                                 <option value="0"></option>
                             </select>

                        </td>
                        <td>选择岗位：
                               <select class="ddlStion_id">
                                   <option value="0">--显示全部--</option>
                               </select>
                        </td>
                        <td>
                            <input id="Radio1" type="radio" name="class" value="1" />未分班<input id="Radio2" type="radio" name="class" value="2" />已分班<input id="Radio3" type="radio" name="class" value="3" checked="checked" />全部</td>
                        <td>
                            <button type="button" class="btn btn-primary" id="btnClick" >重置</button>
                        </td>
                        <td>
                            <button type="button" class="btn btn-success" id="btnSeach">查询</button>
                        </td>
                        <td>
                            <button type="button" class="btn btn-warning" id="btnStufenban">给选定学生分班</button>
                        </td>
                    </tr>
                </table>


                <table class="table table-hover" id="TrainClassSudent">
                    <thead>
                        <tr>
                            <td><input type="checkbox" class="chk" onchange="chk_Class()" /></td>
                            <th>学生姓名</th>
                            <th class="auto-style1">所选岗位</th>
                            <th>分配实训班级</th>
                            <th>性别</th>
                            <th>所属省份</th>
                            <th>所属校区</th>
                            <th>校区班级名称</th>
                            <th>操作</th>
                        </tr>

                    </thead>
                </table>

            </div>
            <input id="Hid_Sid" type="hidden" />
            <input id="Hid_Tcid" type="hidden" />
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                aria-labelledby="myModalLabel" aria-hidden="true" style="height:500px">
                <div class="modal-dialog" style="width:300px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel">换班
                            </h4>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tr>
                                    <td>实训班级：</td>
                                    <td>
                                        <select id="txtTcName" >
                                            <option value="0">--请选择--</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                              <button type="button" class="btn btn-primary" id="btnStudenfen">
                                分到此班
                            </button>
                            <button type="button" class="btn btn-primary" id="btnStudenUpdate">
                                换到此班
                            </button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
            </div>
            </div>
    </form>
</body>
</html>
