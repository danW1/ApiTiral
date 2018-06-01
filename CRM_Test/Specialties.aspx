<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Specialties.aspx.cs" Inherits="CRM_Test.Specialties" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type ="text/javascript">
        $(function () {
            SpecialtQuery();
            //点击模态框里的修改按钮时
            $("#btnSpUpdate").click(function ()
            {
                var id = $("#HidSpecialty_ID").val();
                $.ajax({
                    type: "post",
                    url: "Handler/SpecialtiesHander.ashx",
                    dataType: "json",
                    data: 
                   {
                        Method: "SpUpdate",
                        SpName: $("#txtSpName").val(),
                        Sption: $("#txtSpDescription").val(),
                        Spid: $("#HidSpecialty_ID").val()
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("修改成功！！");
                            SpecialtQuery();
                            $("#myModal").modal("hide");
                            $("#txtSpName").val("");
                            $("#txtSpDescription").val("");
                        } else {
                            alert("修改失败！！");
                        }

                    }
                });
            });
            //点击添加按钮
            $("#btnSpecialAdd").click(function () {
                $("#myModal").modal({ backdrop: "static" });
                $("#myModalLabel").text("添加用户");
                $("#btnSpAdd").show();
                $("#btnSpUpdate").hide();
                $("#txtSpName").val("");
                $("#txtSpDescription").val("");
              
            });
            //点击模态框的添加按钮时
            $("#btnSpAdd").click(function ()
            {
                $.ajax({
                    type: "post",
                    url: "Handler/SpecialtiesHander.ashx",
                    dataType: "json",
                    data: {
                        Method: "SpecialAdd",
                        SpName: $("#txtSpName").val(),
                        Sption: $("#txtSpDescription").val()
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("添加成功！！");
                            SpecialtQuery();
                            $("#myModal").modal("hide");
                            $("#txtSpName").val("");
                            $("#txtSpDescription").val("");
                        } else {
                            alert("添加失败！！");
                        }

                    }
                });
            })
        });
        //显示所有专业信息
        function SpecialtQuery()
        {
            $.ajax({
                type: "get",
                url: "Handler/SpecialtiesHander.ashx",
                dataType: "json",
                data: {
                    Method: "SpecialtQuery",
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<tr>";
                        str += "<td>" + i.Specialty_Name + "</td>";
                        str += "<td>" + i.Specialty_Description + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-warning\" onclick='SpUpdate(" + i.Specialty_ID + ")'>修改</button>";
                        str += "<button type=\"button\" class=\"btn btn-danger\"  onclick='SpDelete(" + i.Specialty_ID + ")'>删除</button>";
                        str += "</td>";
                        str += "</tr>";
                    });
                    $("#TeacherInfo tr:gt(0)").remove();
                    $("#TeacherInfo").append(str);
                }
            });
        }
        //删除专业信息
        function SpDelete(id)
        {
            if (confirm("您确定要删除吗？"))
            {
                $.ajax({
                    type: "post",
                    url:"Handler/SpecialtiesHander.ashx",
                    dataType:"json",
                    data: {
                        Method: "SpDelete",
                        Spid:id
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("删除成功！！");
                            SpecialtQuery();
                           
                        } else {
                            alert("删除失败！！");
                        }

                    }
                });
            }
        }
        //点击修改按钮时获取值
        function SpUpdate(id)
        {  
            $("#myModal").modal({ backdrop: "static" });
            $("#myModalLabel").text("修改用户");
            $("#btnSpUpdate").show();
            $("#btnSpAdd").hide();
            $("#HidSpecialty_ID").val(id);
            $.ajax({
                type: "get",
                url: "Handler/SpecialtiesHander.ashx",
                dataType: "json",
                data: {
                    Method: "SpUpdateQuery",
                    Sid:id 
                },
                success: function (data) {
                    $("#txtSpName").val(data[0].Specialty_Name);
                    $("#txtSpDescription").val(data[0].Specialty_Description);
                    $("#HidSpecialty_ID").val(id);
                }
            });
        }
    </script>
    <title></title>
</head>
<body>
   
    <form id="form1" runat="server">
    <div>
      <table>
                <tr>
                   
                    <td>
                        <button type="button" class="btn btn-success" id="btnSpecialAdd">新增</button>

                    </td>
                </tr>
            </table>
            <table class="table table-hover" id="TeacherInfo">
                <thead>
                    <tr>
                        <th>专业名称</th>
                        <th>专业描述</th>
                        <th> 操作</th>
                    </tr>

                </thead>
            </table>
    </div>
 <asp:HiddenField ID="HidSpecialty_ID" runat="server" />
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
                                <td>专业名称：</td>
                                <td>
                                    <input id="txtSpName" type="text" /></td>
                            </tr>
                             <tr>
                                <td>专业描述：</td>
                                <td>
                                    <input id="txtSpDescription" type="text" /></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                            data-dismiss="modal">
                            返回列表
                        </button>
                         <button type="button" class="btn btn-primary" id="btnSpUpdate">
                          修改
                        </button>
                        <button type="button" class="btn btn-primary" id="btnSpAdd">
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
