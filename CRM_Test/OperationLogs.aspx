<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OperationLogs.aspx.cs" Inherits="CRM_Test.OperationLogs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
      <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {

            //查询所有教师操作日志
            OperationLogs();
            //点击查询按钮时
            $("#btnclassquery").click(function () {
                //查询所有教师操作日志
                OperationLogs();
            });

            $("#btnclass").click(function () {
                TName: $("#txtTeacheerName").val("");
                T_id: $(".ddlT_id").val("");
                TtdateDateK: $("#txtdateDate").val("");
                TdateDateaj: $("#txtdateDatea").val("");

            });

            OperaQuery();
        });
        //查询所有教师操作日志
        function OperationLogs()
        {
            $.ajax({
                type: "get",
                url: "Handler/OperationLogsHandler.ashx",
                dataType: "json",
                data: {
                    Method: "OperationLogsQuery",
                    TName: $("#txtTeacheerName").val(),
                    T_id: $(".ddlT_id").val(),
                    TtdateDateK: $("#txtdateDate").val(),
                    TdateDateaj: $("#txtdateDatea").val()

                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, o) {
                        str += "<tr>";
                        str += "<td>" + o.T_Name + "</td>";
                        str += "<td>" + o.PL_TableName + "</td>";
                        str += "<td>" + o.PL_Operation + "</td>";
                        str += "<td>" + o.PL_Description + "</td>";
                        str += "<td>" + o.PL_Time + "</td>";
                        str += "</tr>";
                    });
                    $("#OperationInfo tr:gt(0)").remove();
                    $("#OperationInfo").append(str);

                }
            });
        }

        //查询所有实际操作信息
        function OperaQuery()
        {
            $.ajax({
                type: "get",
                url: "Handler/OperationLogsHandler.ashx",
                dataType: "json",
                data: {
                    Method: "OperaQuery"
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<option value='" + i.PL_ID + "' >" + i.PL_Operation + "</option>";
                    });
                    $(".ddlT_id option:gt(0)").remove();
                    $(".ddlT_id").append(str);

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
                <h1>用户操作日志</h1>
                <table>
                    <tr>
                        <td>教师姓名：<input id="txtTeacheerName" type="text" /></td>
                        <td>操作类型： 
                            <select class="ddlT_id ">
                                <option value="0">--请选择--</option>
                            </select>
                        </td>
                        <td>操作时间：<input id="txtdateDate" type="date" />至<input id="txtdateDatea" type="date" /></td>
                        <td>
                            <button type="button" class="btn btn-success" id="btnclassquery">查询</button>
                        </td>
                         <td>
                            <button type="button" class="btn btn-success" id="btnclass">清空</button>
                        </td>
                    </tr>
                </table>
                <table class="table table-hover" id="OperationInfo">
                    <thead>
                        <tr>
                            <th>老师姓名</th>
                            <th class="auto-style1">操作表</th>
                            <th>实际操作</th>
                            <th>描述</th>
                            <th>操作时间</th>
                        </tr>

                    </thead>
                </table>

            </div>
    </div>
    </form>
</body>
</html>
