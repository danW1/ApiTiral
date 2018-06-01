<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StationPeriods.aspx.cs" Inherits="CRM_Test.StationPeriods" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {

            ProviceQuery();

            //查询省份（下拉列表）
            $.ajax({
                type:"get",
                url: "Handler/ProvicesSHandler.ashx",
                dataType: "json",
                data: {
                    Method: "ProeQuery"
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<option value='"+i.P_ID+"' >" + i.P_Name + "</option>";
                    });
                    $("#ddlT_Provice option:gt(0)").remove();
                    $("#ddlT_Provice").append(str);
                }
            });
            //点击查询按钮时
            $("#btnProvincesQuery").click(function () {
                ProviceQuery()
            });
            //点击保存按钮时
            $("#btnShoolsSeach").click(function () {
              
                $.ajax({
                    type: "post",
                    url: "Handler/ProvicesSHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "SchoolAdduery",
                        Sid: $("#Hid_Sid").val(),  //学校编号
                        Spid: $("#ddlSpecialtyAdd").val(),  //专业id
                        PreachDate: $("#txtPreachDate").val(),   //宣讲时间
                        OverDay: $("#txtProviceOverDay").val(),   //结束选岗天数
                    },
                    success: function (data) {
                        if (data == "1") 
                        {
                            alert("保存成功！！"); 
                            StationPeriodsShoolID($("#Hid_Sid").val());
                            Spid: $("#ddlSpecialtyAdd").val("");  //专业id
                            PreachDate: $("#txtPreachDate").val("");                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                //宣讲时间
                            OverDay: $("#txtProviceOverDay").val("")   //结束选岗天数
                        } else                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                        {
                            alert("保存失败！！");
                        }

                    }
                });

            });
           
       
        });
        //学校和省的连接查询
        function ProviceQuery() {
            $.ajax({
                type: "get",
                url: "Handler/ProvicesSHandler.ashx",
                dataType: "json",
                data: {
                    Method: "ProviceQuery",
                    PName: $("#ddlT_Provice ").val(),
                    Sid: $("#ddlT_SchName").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, o) {
                        str += "<tr>";
                        str += "<td>" + o.School_Name + "</td>";
                        str += "<td>" + o.School_Code + "</td>";
                        str += "<td>" + o.School_Remark + "</td>";
                        str += "<td>" + o.P_Name + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-success\" onclick='StationPeriodsShoolID(" + o.School_ID + ")' >选岗设置</button>"
                        str += "</td>";
                        str += "</tr>";
                    });
                    $("#ProviceInfo tr:gt(0)").remove();
                    $("#ProviceInfo").append(str);
                    //$("#Hid_Sid").val(data[0], S.School_ID);
                }
            });
        }

        //点击选岗设置时
        function StationPeriodsShoolID(id)
        {
            
            $("#Hid_Sid").val(id);
           
            $("#myModal").modal({ backdrop: "static" });
            SpecialtiesQUery();
            $.ajax({
                type: "get",
                url:"Handler/ProvicesSHandler.ashx",
                dataType:"json",
                data: {
                    Method: "StationPeriodsShoolID",
                    Sid:id
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, S) {
                        str += "<tr>";
                        str += "<td>" + S.School_Name + "</td>";
                        str += "<td>" + S.Specialty_Name + "</td>";
                        str += "<td>" + S.SSP_PreachDate + "</td>";
                        str += "<td>" + S.SSP_OverDay + "</td>";
                        str += "</tr>";
                    });
                    $("#ProvicePeriods tr:gt(0)").remove();
                    $("#ProvicePeriods").append(str);
                  

                }
              
            });
           
        }
        //根据省份ID查询所在其省份的学校
        function provice()
        {
            $.ajax({
                type: "get",
                url: "Handler/ProvicesSHandler.ashx",
                dataType: "json",
                data: {
                    Method: "provice",
                    Pid: $("#ddlT_Provice").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index,o) {
                        str += "<option value='" + o.School_ID + "' >" + o.School_Name + "</option>";
                    });
                    
                    $("#ddlT_SchName option:gt(0)").remove();
                    $("#ddlT_SchName").append(str);
                    //empty//下拉列表清空
                }
            });
        }
        //查询所有专业信息
        function SpecialtiesQUery()
        {
            $.ajax({
                type:"get",
                url:"Handler/ProvicesSHandler.ashx",
                dataType: "json",
                data: {
                    Method: "SpecialtiesQ"
                },
                success: function (data)
                {
                    var str = "";
                    $.each(data, function (index, o) {
                        str += "<option value='" + o.Specialty_ID + "'>" + o.Specialty_Name + "</option>";
                    });
                    
                    $("#ddlSpecialtyAdd option:gt(0)").remove();
                    $("#ddlSpecialtyAdd").append(str);
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



                <h1>选岗设置</h1>
                <table>
                    <tr>
                        <td>选择省份：<select id="ddlT_Provice" onchange="provice()"> <%-- //onchange当文本框内容改变的时候--%>
                            <option value="0">--请选择--</option>
                            
                        </select></td>
                        <td>选择校区：<select id="ddlT_SchName">
                            <option value="0">--请选择--</option>
                        </select></td>
                        <td>
                            <button type="button" class="btn btn-info" id="btnProvincesQuery">查询</button>
                        </td>

                    </tr>

                </table>
                <table class="table table-striped " id="ProviceInfo">
                    <thead>
                        <tr>
                            <th class="auto-style5">校区名称</th>
                            <th class="auto-style5">校区代码</th>
                            <th class="auto-style5">校区备注</th>
                            <th class="auto-style5">省份名称</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                </table>

            </div>
            <input id="Hid_Sid" type="hidden" />
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel">选岗设定
                            </h4>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tr>
                                    <td>专业:
                                        <select id="ddlSpecialtyAdd">
                                            <option value="3">--请选择--</option>
                                        </select></td>
                                    <td>宣讲时间：<input id="txtPreachDate" type="text" /></td>
                                    <td>结束选岗天数：<input id="txtProviceOverDay" type="text" /></td>
                                    <td>
                                        <button type="button" class="btn btn-info" id="btnShoolsSeach">保存</button>
                                    </td>
                                </tr>
                            </table>
                            <table class="table table-striped " id="ProvicePeriods">
                                <thead>
                                    <tr>
                                        <th class="auto-style5">校区名称</th>
                                        <th class="auto-style5">专业名称</th>
                                        <th class="auto-style5">宣讲时间</th>
                                        <th class="auto-style5">选岗结束天数</th>
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
