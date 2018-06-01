<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetStations.aspx.cs" Inherits="CRM_Test.SetStations" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        //给校区专业设置岗位
        $(function () {
            Schoolquery();

            //点击查询
            $("#btnSchoolQuery").click(function () {
                Schoolquery();
            });

            //点击模态框2的查询按钮
            $("#btnStationsQuery").click(function () {
             
                Stationsquery();
              
            });
            //点击模态框2的保存按钮
            $("#btnStationsAdd").click(function () {
                var str = "";
                var chklist = $(".chk");  //通过旋转器找到所有的复选框
                for (var i = 0; i < chklist.length == true; i++) {
                    //判断复选框有没有被选中，选中的用str字符串储存
                    if (chklist[i].checked == true) {
                        str += chklist[i].value + ";";
                       
                    }

                }
                //去掉最后多了的分号 substring关键字截取字符串 0代表从多少位开始截取 后面的一个参数是截取到结束的位置（长度减一）
                str = str.substring(0, str.length - 1);
               
                $.ajax({
                    type: "post",
                    url: "Handler/SetStaticHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "StationAdd",
                        Sid: $("#Hid_Sid").val(),
                        Zid: $("#Hid_Zhuanye").val(),
                        strr: str
                    },
                    success: function (data) {
                        if (data == "1") {

                            alert("保存成功");
                            Stationsquery();
                        }
                        else {
                            alert("保存失败");
                        }
                    }

                });
            });
        });
        //查看所有校区信息
        function Schoolquery() {
            $.ajax({
                type: "get",
                url: "Handler/SetStaticHandler.ashx",
                dataType: "json",
                data: {
                    Method: "Schoolquery",
                    Scode: $("#txtSchoolid").val(),
                    Sname: $("#txtSchoolName").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<tr>";
                        str += "<td>" + i.School_Code + "</td>";
                        str += "<td>" + i.School_Name + "</td>";
                        str += "<td>" + i.School_Remark + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-warning\" onclick='SchQuery(" + i.School_ID + ")'>查看</button>";
                        str += "</td>";
                        str += "</tr>";
                    });
                    $("#SchoolInfo tr:gt(0)").remove();
                    $("#SchoolInfo").append(str);
                }
            });
        }
        //（查看校区专业）根据校区编号查询所有校区专业班级信息
        function SchQuery(id) {
            $("#Hid_Sid").val(id);
            $("#myModal").modal({ backdrop: "static" });
            $.ajax({
                type: "get",
                url: "Handler/SetStaticHandler.ashx",
                dataType: "json",
                data: {
                    Method: "SchQuery",
                    Sid: id
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, o) {
                        str += "<tr>";
                        str += "<td>" + o.Specialty_Name + "</td>";
                        str += "<td>" + o.Specialty_Description + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-success\" onclick='SpeQuery(&quot;" + o.Specialty_ID + "&quot;,&quot;" + o.Specialty_Name + "&quot;)' >设置可选岗位</button>";
                        str += "</td>";
                        str += "</tr>";
                    });
                    $("#SpeicInfo tr:gt(0)").remove();
                    $("#SpeicInfo").append(str);
                }
            });

        }

        //点击设置可选岗位时(查询所有岗位信息)
        function SpeQuery(id, name) {
            $("#myModa2").modal({ backdrop: "static" });
            $("#Specialtie").text(name);
            $("#Hid_Zhuanye").val(id);
            Stationsquery();
         
        }
        //查询所有岗位信息
        function StdQuery()
        {
            $.ajax({
                type: "get",
                url: "Handler/SetStaticHandler.ashx",
                dataType: "json",
                data: {
                    Method: "StdQuery"
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, x) {
                        str += "<tr>";
                        str += "<td><input type=\"checkbox\" class=\"chk\" value='" + x.Station_ID + "' /></td>";
                        str += "<td>" + x.Station_Name + "</td>";
                        str += "<td>" + x.Station_Duty + "</td>";
                        str += "<td>" + x.Station_NeedTechnique + "</td>";
                        str += "</tr>";
                    });
                    $("#StationInfo tr:gt(0)").remove();
                    $("#StationInfo").append(str);
                }
            });

        }
        //当复选框被选中时触发
        function chk_Chu() {
            if ($("#chk_all").prop("checked")) {
                $(".chk").prop("checked", "checked");
            }
            else {
                $(".chk").prop("checked", false);
            }

        }
        //根据单选框的状态选中加载
        function Stationsquery()
        {
            $.ajax({
                type: "get",
                url: "Handler/SetStaticHandler.ashx",
                dataType: "json",
                data: {
                    Method: "StationsQuery",
                    Sid: $("#Hid_Sid").val(),
                    Zid: $("#Hid_Zhuanye").val(),
                    S:  $("input[name=rad]:checked").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, x) {
                        str += "<tr>";
                        str += "<td><input type=\"checkbox\" class=\"chk\" value='" + x.Station_ID + "' /></td>";
                        str += "<td>" + x.Station_Name + "</td>";
                        str += "<td>" + x.Station_Duty + "</td>";
                        str += "<td>" + x.Station_NeedTechnique + "</td>";
                        str += "</tr>";
                    });
                    $("#StationInfo tr:gt(0)").remove();
                    $("#StationInfo").append(str);
                }

            });
        }
      
    </script>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 148px;
        }

        .auto-style2 {
            width: 139px;
        }

        .auto-style3 {
            width: 120px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <h1>给校区专业设置岗位</h1>
                <table>
                    <tr>
                        <td>校区代码：<input id="txtSchoolid" type="text" /></td>
                        <td>校区名称：<input id="txtSchoolName" type="text" /></td>
                        <td>
                            <button type="button" class="btn btn-info" id="btnSchoolQuery">查询</button>
                        </td>

                    </tr>

                </table>
                <table class="table table-striped " id="SchoolInfo">
                    <thead>
                        <tr>
                            <th class="auto-style1">校区代码</th>
                            <th class="auto-style2">校区名称</th>
                            <th class="auto-style3">备注</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                </table>
            </div>
            <input id="Hid_Sid" type="hidden" />
            <input id="Hid_Zhuanye" type="hidden" />
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                                &times;</button>
                            <h4 class="modal-title" id="myModalLabel">查看校区专业
                            </h4>
                        </div>
                        <div class="modal-body">
                            <table class="table table-striped " id="SpeicInfo">
                                <thead>
                                    <tr>
                                        <th class="auto-style5">专业名称</th>
                                        <th class="auto-style5">专业描述</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>

                    </div>
                    <!-- /.modal-content -->
                </div>
            </div>


            <div class="modal fade" id="myModa2" tabindex="-1" role="dialog"
                aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                                &times;</button>
                            <h4 class="modal-title" id="myModalLabe2">设置可选岗位
                            </h4>
                        </div>
                        <table>
                            <tr>
                                <td>当前所选的专业是：<span id="Specialtie" style="color:blue; font-weight:bold;"></span></td>
                            </tr>
                            <tr>
                                <td>已选择<input id="1" type="radio" name="rad" value="1"  checked="checked" /></td>
                                <td>未选择<input id="2" type="radio" name="rad"value="2"  /></td>
                                <td>全部<input id="3" type="radio" name="rad"value="3"  /></td>
                                <td>
                                    <button type="button" class="btn btn-info" id="btnStationsQuery">查询</button>
                                    <button type="button" class="btn btn-primary" id="btnStationsAdd">保存</button>
                                </td>

                            </tr>

                        </table>
                        <div class="modal-body">
                            <table class="table table-striped " id="StationInfo">
                                <thead>
                                    <tr>
                                        <th>
                                            <input type="checkbox" id="chk_all" onchange="chk_Chu()" /></th>
                                        <th class="auto-style5">岗位名称</th>
                                        <th class="auto-style5">岗位职责</th>
                                        <th class="auto-style5">所需技术</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>

                    </div>
                    <!-- /.modal-content -->
                </div>
            </div>
        </div>
    </form>
</body>
</html>
