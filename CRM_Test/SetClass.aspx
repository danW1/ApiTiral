<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetClass.aspx.cs" Inherits="CRM_Test.SetClass" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            TeacherQuery();

            //点击查询
            $("#btnclassquery").click(function () {
                TeacherQuery();
            });

            //点击模态框查询按钮时
            $("#btnClassQuery").click(function () {
                ClassQuery();
            });

            //点击保存按钮时
            $("#btnClassAdd").click(function () {
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
                    url: "Handler/SetClassHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "StationAdd",
                        T_id: $("#HidT_id").val(),
                        T_Category:$("#HidCategory").val(),
                        strr: str
                    },
                    success: function (data) {
                        if (data == "1") {

                            alert("保存成功");
                            ClassQuery();
                         
                        }
                        else {
                            alert("保存失败");
                        }
                    }

                });

            });
        });

        //查询所有老师信息
        function TeacherQuery() {
            $.ajax({
                type: "get",
                url: "Handler/SetClassHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TeacherQuery",
                    T_Name: $("#txtTeacheerName").val(),
                    T_id: $(".ddlT_id").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, o) {

                        if (o.T_Category == 0) {
                            o.T_Category = "教员";
                        } else {
                            o.T_Category = "督导";
                        }
                        str += "<tr>";
                        str += "<td>" + o.T_Name + "</td>";
                        str += "<td>" + o.T_Sex + "</td>";
                        str += "<td>" + o.T_Tel + "</td>";
                        str += "<td>" + o.T_Category + "</td>";                                                                 
                        str += "<td><button type=\"button\" class=\"btn btn-success\" onclick='StationUpdate(&quot;" + o.T_ID + "&quot;,&quot;" + o.T_Category + "&quot;)'>设置所带实训班级</button> ";
                        str += "</td>";
                        str += "</tr>";
                    });
                    $("#TeaxherInfo tr:gt(0)").remove();
                    $("#TeaxherInfo").append(str);

                 
                }
            });
        }

        //点击设置所带实训班级时
        function StationUpdate(id, T_Category) {
            $("#HidT_id").val(id);
            $("#myModal").modal({ backdrop: "static" });
            $("#ClassCategory").text(T_Category);
            if (T_Category == "教员")
            {
                $("#HidCategory").val(0);
            } else
            {
                $("#HidCategory").val(1);
            }
            ClassQuery();

        }

        //查询老师所带实训班级信息
        function ClassQuery()
        {
            $.ajax({
                type: "get",
                url: "Handler/SetClassHandler.ashx",
                dataType: "json",
                data: {
                    Method: "ClassQueryss",
                    Class: $("input[name=class]:checked").val(),
                    Category: $("#HidCategory").val(),
                    T_id: $("#HidT_id").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, x) {
                        if (x.T_Name == null)
                        {
                            x.T_Name = "<span style=\"color:crimson\" >未分配</span>";
                        }
                        str += "<tr>";
                        str += "<td><input type=\"checkbox\" class=\"chk\" value='" + x.TC_ID + "' /></td>";
                        str += "<td>" + x.TC_Name + "</td>";
                        str += "<td>" + x.T_Name + "</td>";
                        str += "</tr>";
                    });
                    $("#classInfo tr:gt(0)").remove();
                    $("#classInfo").append(str);
                  
                }

            });
        }

        //多选按钮的触发事件
        function Check() {
            if ($("#Checkyy").prop("checked")) {
                $(".chk ").prop("checked", "checked");
            }
            else {
                $(".chk").prop("checked", false);
            }
        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <h1>带班管理</h1>
                <table>
                    <tr>
                        <td>教师姓名：<input id="txtTeacheerName" type="text" /></td>
                        <td>教员/督导： 
                            <select class="ddlT_id ">
                                <option value="3">--请选择--</option>
                                <option value="0">教员</option>
                                <option value="1">督导</option>
                            </select>
                        </td>

                        <td>
                            <button type="button" class="btn btn-success" id="btnclassquery">查询</button>
                        </td>
                    </tr>
                </table>
                <table class="table table-hover" id="TeaxherInfo">
                    <thead>
                        <tr>
                            <th>老师姓名</th>
                            <th class="auto-style1">性别</th>
                            <th>电话</th>
                            <th>教员/督导</th>
                            <th>操作</th>
                        </tr>

                    </thead>
                </table>

            </div>

            <input id="HidTc_id" type="hidden" />
            <input id="HidT_id" type="hidden" />
            <input id="HidCategory" type="hidden" />
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel">设置所带实训班级
                            </h4>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tr>
                                   
                                    <td>当前所选的角色是：<span id="ClassCategory" style="color:blue; font-weight:bold;" ></span></td>
                                </tr>
                                <tr>

                                    <td>
                                        <input id="1" type="radio" name="class" checked="checked" value="1" />未分配班级<input id="2" type="radio" name="class" value="2" />所带班级
                                        <input id="3" type="radio" name="class" value="3" />全部班级</td>
                                    <td>
                                        <button type="button" class="btn btn-primary" id="btnClassQuery">
                                            查询
                                        </button>
                                        <button type="button" class="btn btn-primary" id="btnClassAdd">
                                            保存
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <table class="table table-hover" id="classInfo">
                                <thead>
                                    <tr>
                                        <th>
                                            <input id="Checkyy" type="checkbox" onchange="Check()"  /></th>
                                        <th class="auto-style1">实班级名称</th>
                                        <th>实训班级老师</th>
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
