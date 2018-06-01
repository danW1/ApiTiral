<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StationsAjax.aspx.cs" Inherits="CRM_Test.StationsAjax" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            StaticQuery();
            //点击查询按钮时
            $("#btnStaticQuery").click(function () {
                StaticQuery()
            });
            //点击修改时
            $("#btnSUpdate").click(function () {
                $.ajax({
                    type: "post",
                    url: "Handler/StaticHandler.ashx",
                    dataType: "json",
                    data: {
                        Method:"StaticSUpdate",
                        Sid: $("#Hidd_id").val(),
                        Sname: $("#txtSName").val(),
                        SDuty: $("#txtSDuty").val(),
                        STeachnique: $("#txtSNeedTechnique ").val()
                    },
                    success: function (data)
                    {
                        if (data == "1") {
                            alert("修改成功！！");
                            $("#myModal").modal("hide");
                            StaticQuery();
                            $("#txtSName").val("");
                            $("#txtSDuty").val("");
                            $("#txtSNeedTechnique ").val("");
                        } else {
                            alert("修改失败！！");
                        }
                    }
                });

            });
            //点击新增时
            $("#btnStaticAdd").click(function () {
                $("#myModal").modal({ backdrop: "static" });
                $("#myModalLabel").text("新增专业");
                $("#btnSAdd").show();
                $("#btnSUpdate").hide();
                $("#txtSName").val("");
                $("#txtSDuty").val("");
                $("#txtSNeedTechnique ").val("");
            });
            //点击新增时
            $("#btnSAdd").click(function ()
            {
                $.ajax({
                    type: "post",
                    url: "Handler/StaticHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "StaticSAdd",
                        Sname: $("#txtSName").val(),
                        SDuty: $("#txtSDuty").val(),
                        STeachnique: $("#txtSNeedTechnique ").val()
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("添加成功！！");
                            $("#myModal").modal("hide");
                            StaticQuery();
                            $("#txtSName").val("");
                            $("#txtSDuty").val("");
                            $("#txtSNeedTechnique ").val("");
                        } else {
                            alert("添加失败！！");
                        }
                    }
                });

            });
 });
        //查询全部岗位
        function StaticQuery() {
            $.ajax({
                type: "get",
                url: "Handler/StaticHandler.ashx",
                dataType: "json",
                data: {
                    Method: "StaticQuery",
                    Sname: $("#txtStaticName").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, o) {
                        str += "<tr>";
                        str += "<td>" + o.Station_Name + "</td>";
                        str += "<td>" + o.Station_Duty + "</td>";
                        str += "<td>" + o.Station_NeedTechnique + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-primary\" onclick='StationUpdate(" + o.Station_ID + ")'>修改</button> ";
                        str += "<button type=\"button\" class=\"btn btn-warning\" onclick='StaticDelete(" + o.Station_ID + ")'>删除</button>";
                        str += "</td>";
                        str += "</tr>";
                    });
                    $("#StaticInfo tr:gt(0)").remove();
                    $("#StaticInfo").append(str);
                }


            });

        }
        //删除
        function StaticDelete(id)
        {
            if (confirm("您确定要删除吗？")) {
                $.ajax({
                    type: "post",
                    url: "Handler/StaticHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "StaticDelete",
                        Sid: id
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("删除成功！！");
                            StaticQuery();

                        } else {
                            alert("删除失败！！");
                        }

                    }
                });
            }
        }
        //点击修改按钮时
        function StationUpdate(id)
        {
            $("#myModal").modal({ backdrop: "static" });
            $("#myModalLabel").text("修改专业");
            $("#btnSUpdate").show();
            $("#btnSAdd").hide();
            $.ajax({
                type: "get",
                url: "Handler/StaticHandler.ashx",
                dataType: "json",
                data: {
                    Method: "StaticUpdateQuery",
                    Sid: id
                },
                success: function (data) {
                    $("#txtSName").val(data[0].Station_Name);
                    $("#txtSDuty").val(data[0].Station_Duty);
                    $("#txtSNeedTechnique ").val(data[0].Station_NeedTechnique);
                    $("#Hidd_id").val(id);
                }

            });
        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <h1>岗位管理</h1>
                <table>
                    <tr>

                        <td>岗位名称：<input id="txtStaticName" type="text" /></td>
                        <td>
                            <button type="button" class="btn btn-info" id="btnStaticQuery">查询</button>
                            <button type="button" class="btn btn-info" id="btnStaticAdd">新增</button>
                        </td>

                    </tr>

                </table>
                <table class="table table-striped " id="StaticInfo">
                    <thead>
                        <tr>
                            <th class="auto-style5">岗位名称</th>
                            <th class="auto-style5">岗位职责</th>
                            <th class="auto-style5">所需技术</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                </table>

            </div>
            <input id="Hidd_id" type="hidden" />
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel">修改用户
                            </h4>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tr>
                                    <td>岗位名称：</td>
                                    <td>
                                        <input id="txtSName" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="name">岗位职责：</label>
                                        <textarea class="form-control" rows="3" id="txtSDuty"></textarea></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="name">所需技术：</label>
                                        <textarea class="form-control" rows="3" id="txtSNeedTechnique"></textarea>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default"
                                data-dismiss="modal">
                                返回列表
                            </button>
                            <button type="button" class="btn btn-primary" id="btnSUpdate">
                                修改
                            </button>
                            <button type="button" class="btn btn-primary" id="btnSAdd">
                                添加
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
