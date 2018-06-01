<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="School_prvinces.aspx.cs" Inherits="CRM_Test.School_prvinces" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        //载入时
        $(function () {
            ProvinceQuery();
            //点击查询按钮时(省份)
            $("#btnproviceSeach").click(function () {
                ProvinceQuery();
            });
            ////点击添加按钮时
            $("#btnShoolsAdd").click(function ()
            {
                $("#btnSchoolUpdate").hide();
                $("#btnSchoolAdd").show();
                $("#myModa2").modal({ backdrop: "static" });
                $("#myModalLabe2").text("添加用户");
                $("#txtupSchool_Code").val("");
                $("#txtupSchool_Name").val("");
                $("#txtupSchool_Remark").val("");
                
            });
            //执行添加方法
            $("#btnSchoolAdd").click(function ()
            {               
                $.ajax({
                    type: "post",
                    url: "Handler/ProvicesHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "btnSchoolAdd",
                        Code: $("#txtupSchool_Code").val(),
                        Name: $("#txtupSchool_Name").val(),
                        Remark: $("#txtupSchool_Remark").val(),
                        Pid:$("#hid_pid").val(),
                      
                    },//所有前台向后台传值的代码都写在这里面
                    success: function (data) {
                        if (data == "1") {
                            alert("添加成功！！");
                            SchoolsProvices($("#hid_pid").val());
                            $("#myModa2").modal("hide");//隐藏弹框
                            $("#txtupSchool_Code").val("");
                            $("#txtupSchool_Name").val("");
                            $("#txtupSchool_Remark").val("");
                        } else {
                            alert("添加失败！！");
                        }

                    }

                });
            });
            //点击查询按钮时(学校)
            $("#btnShoolsSeach").click(function () {
                $.ajax({
                    type: "get",
                    url: "Handler/ProvicesHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "SchoolsProvices",
                        Pid: $("#hid_pid").val(),
                        Code: $("#txtSchoolCode").val(),
                        SchoolName: $("#txtSchoolName").val()

                    },
                    success: function (data) {

                        var str = "";
                        $.each(data, function (index, p) {

                            str += "<tr>";
                            str += "<td>" + p.School_Code + "</td>";
                            str += "<td>" + p.School_Name + "</td>";
                            str += "<td>" + p.School_Remark + "</td>";
                            str += "<td><button type=\"button\" class=\"btn btn-success\" onclick='SchoolsidUpdate(" + p.School_ID + ")' >修改</button>"
                            str += "<td><button type=\"button\" class=\"btn btn-success\" onclick='SchoolsidDelete(" + p.School_ID + ")'>删除</button>"
                            str += "</td>";
                            str += "</tr>";
                        });

                        $("#SchoolQuery tr:gt(0)").remove();
                        $("#SchoolQuery").append(str);


                    }
                });
             
             
                $("#txtSchoolCode").val("");
                $("#txtSchoolName").val("");
            });
            //点击修改按钮
            $("#btnSchoolUpdate").click(function () {

                var id = $("#Hidd_Sid").val();
               
                $.ajax({
                    type: "post",
                    url: "Handler/ProvicesHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "btnSchoolUpdate",
                        Code: $("#txtupSchool_Code").val(),
                        Name: $("#txtupSchool_Name").val(),
                        Remark: $("#txtupSchool_Remark").val(),
                        Pid: $("#hid_pid").val(),
                        sid: $("#Hidd_Sid").val()
                    },//所有前台向后台传值的代码都写在这里面
                    success: function (data) {
                        if (data == "1") {
                            alert("修改成功！！");
                            SchoolsProvices($("#hid_pid").val());
                            $("#myModa2").modal("hide");//隐藏弹框
                            $("#txtupSchool_Code").val("");
                             $("#txtupSchool_Name").val("");
                            $("#txtupSchool_Remark").val("");
                           
                        } else {
                            alert("修改失败！！");
                        }

                    }

                });
            });
        });

      
        //查询所有省份信息
        function ProvinceQuery() {
            $.ajax({
                type: "get",
                url: "Handler/ProvicesHandler.ashx",
                dataType: "json",
                data: {
                    Method: "ProvinceQuery",
                    PName: $("#SName").val()
                },

                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<tr>";
                        str += "<td>" + i.P_ID + "</td>";
                        str += "<td>" + i.P_Name + "</td>";
                        str += "<td>" + i.P_Remark + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-success\" onclick='SchoolsProvices(" + i.P_ID + ")'>管理该省校区</button>"
                        str += "</td>";
                        str += "</tr>";

                    });
                    $("#SchoolInfo tr:gt(0)").remove();
                    $("#SchoolInfo").append(str);
                }
            });
        }

        //根据省份编号查询所有校区信息
        function SchoolsProvices(Pid) {
            $("#myModal").modal({ backdrop: "static" });
            $("#myModalLabel").text("查询校区");
            $("#hid_pid").val(Pid);
            $.ajax({
                type: "get",
                url: "Handler/ProvicesHandler.ashx",
                dataType: "json",
                data: {
                    Method: "SchoolsProvices",
                    Pid: Pid,
                    Code: $("#txtSchoolCode").val(),
                    SchoolName: $("#txtSchoolName").val()

                },
                success: function (data) {

                    var str = "";
                    $.each(data, function (index, p) {

                        str += "<tr>";
                        str += "<td>" + p.School_Code + "</td>";
                        str += "<td>" + p.School_Name + "</td>";
                        str += "<td>" + p.School_Remark + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-success\" onclick='SchoolsidUpdate(" + p.School_ID + ")' >修改</button>"
                        str += "<td><button type=\"button\" class=\"btn btn-success\" onclick='SchoolsidDelete(" + p.School_ID + ")'>删除</button>"
                        str += "</td>";
                        str += "</tr>";
                    });
                   
                    $("#SchoolQuery tr:gt(0)").remove();
                    $("#SchoolQuery").append(str);
                 
                   
                }
            });
        }
        //根据校区id，删除学校
        function SchoolsidDelete(id) {
            if (confirm("您确定要删除该校吗？")) {
                $.ajax({

                    type: "post",
                    url: "Handler/ProvicesHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "SchoolsidDelete",
                        Sid: id,
                        Pid: $("#hid_pid").val()
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("删除成功！");
                            SchoolsProvices($("#hid_pid").val());
                            $("#txtupSchool_Code").val("");
                            $("#txtupSchool_Name").val("");
                            $("#txtupSchool_Remark").val("");

                        }
                        else {
                            alert("删除失败！")
                        }
                    }
                });
            }

        }
        //根据校区id，给文本框赋值
        function SchoolsidUpdate(id) {
            $("#myModa2").modal({ backdrop: "static" });
            $("#myModalLabe2").text("修改用户");
            $("#btnSchoolAdd").hide();
            $("#btnSchoolUpdate").show();
            $("#Hidd_Sid").val(id);
            $("#hid_pid").val();
            shoolUpdate();
        }
        function shoolUpdate()
        {
            $.ajax({
                type: "get",
                url: "Handler/ProvicesHandler.ashx",
                dataType: "json",
                data: {
                    Method: "SchoolsidUpdate",
                    Sid:  $("#Hidd_Sid").val()
                },
                success: function (data) {
                    $("#txtupSchool_Code").val(data[0].School_Code);
                    $("#txtupSchool_Name").val(data[0].School_Name);
                    $("#txtupSchool_Remark ").val(data[0].School_Remark);
                    $("#Hidd_Sid").val(id);
                }

            });
        }
    </script>
    <title></title>
    <style type="text/css">
        .auto-style5 {
            width: 140px;
        }

        .auto-style6 {
            width: 154px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>



            <h1>校区管理</h1>
            <table>
                <tr>
                    <td>省份名称：<input id="SName" type="text" /></td>
                    <td>
                        <button type="button" class="btn btn-info" id="btnproviceSeach">查询</button></td>

                </tr>

            </table>
            <table class="table table-striped " id="SchoolInfo">
                <thead>
                    <tr>
                        <th class="auto-style5">省份编号</th>
                        <th class="auto-style5">省份名称</th>
                        <th class="auto-style6">备注</th>
                        <th>操作</th>
                    </tr>
                </thead>
            </table>

        </div>
        <input id="hid_pid" type="hidden" />
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
                    <tr>
                        <td>校区代码：<input id="txtSchoolCode" type="text" /></td>
                        <td>校区名称：<input id="txtSchoolName" type="text" /></td>
                        <td>
                            <button type="button" class="btn btn-info" id="btnShoolsSeach">查询</button>
                            <button type="button" class="btn btn-info" id="btnShoolsAdd">新增</button>
                        </td>

                    </tr>
                    <table class="table table-striped " id="SchoolQuery">
                        <thead>
                            <tr>
                                <th class="auto-style5">校区代码</th>
                                <th class="auto-style5">校区名称</th>
                                <th class="auto-style6">备注</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                    </table>

                </div>
                <!-- /.modal-content -->
            </div>
        </div>

        <input id="Hidd_Sid" type="hidden" />
        <div class="modal fade" id="myModa2" tabindex="-1" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabe2">模态框（Moda2）标题
                        </h4>
                    </div>
                    <div class="modal-body">
                        <table>
                            <tr>
                                <td>校区代码：</td>
                                <td>
                                    <input id="txtupSchool_Code" type="text" /></td>
                            </tr>
                            <tr>
                                <td>校区名称：</td>
                                <td>
                                    <input id="txtupSchool_Name" type="text" /></td>
                            </tr>
                            <tr>
                                <td>备注：</td>
                                <td>
                                    <input id="txtupSchool_Remark" type="text" /></td>


                            </tr>
                       
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                            data-dismiss="modal">
                           返回列表
                        </button>
                        <button type="button" class="btn btn-primary" id="btnSchoolUpdate">
                            修改
                        </button>
                       <button type="button" class="btn btn-primary" id="btnSchoolAdd">
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
