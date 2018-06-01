<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrainClass.aspx.cs" Inherits="CRM_Test.TrainClass" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            TrainClassQuery();

            //点击查询按钮
            $("#btnclassquery").click(function () {
                TrainClassQuery()
            });

            //点击新增按钮
            $("#btnclassAdd").click(function () {
                var str =$(".ddlT_T_Categorye").val();
                TrainCag(str);
                var s = $(".ddlT_T_Categoryt").val();
                TrainCag(s);
                $("#myModal").modal({ backdrop: "static" });
                $("#myModalLabel").text("新增实训班级");
                $("#btnSUpdate").hide();
            
                $("#btnSAdd").show();
                Tc_Name: $("#txtTc_Name").val("");
                TC_Grade: $("#txtTC_Grade").val("");
                TC_BeginTime: $("#txtTC_BeginTime").val("");
                TC_EndTime: $("#txtTC_EndTime").val("");
                TC_MaxAmount: $("#txtTC_MaxAmount").val("");
                Provice: $("#txtProvice").val("");
                Categoryt: $(".ddlT_T_Categoryt").val(0);
                Categorye: $(".ddlT_T_Categorye").val(1);
            });
            //点击新增模态框按钮
            $("#btnSAdd").click(function () {
                $.ajax({
                    type: "post",
                    url: "Handler/TrainClassHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "TrainclassAdd",
                        Tc_Name: $("#txtTc_Name").val(),
                        TC_Grade: $("#txtTC_Grade").val(),
                        TC_BeginTime: $("#txtTC_BeginTime").val(),
                        TC_EndTime: $("#txtTC_EndTime").val(),
                        TC_MaxAmount: $("#txtTC_MaxAmount").val(),
                        Provice: $("#txtProvice").val(),
                        Categoryt: $(".ddlT_T_Categoryt").val(),
                        Categorye: $(".ddlT_T_Categorye").val(),
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("添加成功！！");
                            TrainClassQuery();
                            Tc_Name: $("#txtTc_Name").val("");
                            TC_Grade: $("#txtTC_Grade").val("");
                            TC_BeginTime: $("#txtTC_BeginTime").val("");
                            TC_EndTime: $("#txtTC_EndTime").val("");
                            TC_MaxAmount: $("#txtTC_MaxAmount").val("");
                            Provice: $("#txtProvice").val("");
                            Categoryt: $(".ddlT_T_Categoryt").val(0);
                            Categorye: $(".ddlT_T_Categorye").val(1);
                            $("#myModal").modal("hide");//隐藏弹框

                        } else {
                            alert("添加失败！！");
                        }
                    }

                });
            });
            //点击模态框修改按钮
            $("#btnSUpdate").click(function () {
                $.ajax({
                    type: "post",
                    url: "Handler/TrainClassHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "TeacherClassUpdate",
                        Tc_Name: $("#txtTc_Name").val(),
                        TC_Grade: $("#txtTC_Grade").val(),
                        TC_BeginTime: $("#txtTC_BeginTime").val(),
                        TC_EndTime: $("#txtTC_EndTime").val(),
                        TC_MaxAmount: $("#txtTC_MaxAmount").val(),
                        Provice: $("#txtProvice").val(),
                        Categoryt: $(".ddlT_T_Categoryt").val(),
                        Categorye: $(".ddlT_T_Categorye").val(),
                        Tc_ID: $("#HidTc_id").val(),
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("修改成功！！");
                            TrainClassQuery();
                            Tc_Name: $("#txtTc_Name").val("");
                            TC_Grade: $("#txtTC_Grade").val("");
                            TC_BeginTime: $("#txtTC_BeginTime").val("");
                            TC_EndTime: $("#txtTC_EndTime").val("");
                            TC_MaxAmount: $("#txtTC_MaxAmount").val("");
                            Categoryt: $(".ddlT_T_Categoryt").val(0);
                            Categorye: $(".ddlT_T_Categorye").val(1);
                            Provice: $("#txtProvice").val("");
                            $("#myModal").modal("hide");//隐藏弹框

                        } else {
                            alert("修改失败！！");
                        }
                    }
                });

            });
        });
        //查询所有实训班级信息
        function TrainClassQuery() {
            $("#TrainClassInfo tr:gt(0)").remove();
            $.ajax({
                type: "get",
                url: "Handler/TrainClassHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TrainClassQuery",
                    CName: $("#txtClassName").val(),
                    T_id: $(".ddlT_Name").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, x) {
                        str += "<tr>";
                        str += "<td>" + x.TC_Name + "</td>";
                        str += "<td>" + x.TC_BeginTime + "</td>";
                        str += "<td>" + x.TC_EndTime + "</td>";
                        str += "<td>" + x.TC_MaxAmount + "</td>";
                        str += "<td>" + x.TC_MaleAmount + "</td>";
                        str += "<td>" + x.TC_FemaleAmount + "</td>";
                        str += "<td>" + x.TC_Period + "</td>";
                        str += "<td>" + x.jyName + "</td>";
                        str += "<td>" + x.ddName + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-primary\" onclick='TeacherUpdate(" + x.TC_ID+ ")'>修改</button>";
                        str += "<button type=\"button\" class=\"btn btn-danger\" onclick='TeacherDelete(" + x.TC_ID + ")'>删除</button>";
                        str += "</td>";
                        str += "</tr>";
                    });
                    $("#TrainClassInfo tr:gt(0)").remove();
                    $("#TrainClassInfo").append(str);
                }
            });
        }

        //修改
        function TeacherUpdate(id) {
            $("#myModal").modal({ backdrop: "static" });
            $("#myModalLabel").text("修改实训班级");
          
            $("#btnSAdd").hide();
            $("#btnSUpdate").show();
            $("#HidTc_id").val(id);
            $(".ddlT_T_Categorye").val(1);
            $(".ddlT_T_Categoryt").val(0);
            Tc_Name: $("#txtTc_Name").val("");
            TC_Grade: $("#txtTC_Grade").val("");
            TC_BeginTime: $("#txtTC_BeginTime").val("");
            TC_EndTime: $("#txtTC_EndTime").val("");
            TC_MaxAmount: $("#txtTC_MaxAmount").val("");
            Provice: $("#txtProvice").val("");
           
            var str = $(".ddlT_T_Categorye").val();
            TrainCag(str);
            var s = $(".ddlT_T_Categoryt").val();
            TrainCag(s);
            TreacherTcidquery();
        }
        //删除
        function TeacherDelete(id) {
            $.ajax({
                type: "post",
                url: "Handler/TrainClassHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TeacherDelete",
                    TcId: id

                },
                success: function (data) {
                    if (data == "1") {
                        alert("删除成功！");
                        TrainClassQuery();
                    } else {
                        alert("删除失败！");
                    }
                }

            });
        }

        //单击单选按钮时的触发事件
        function TrainCatet(id) {
            
            $.ajax({
                type: "get",
                url: "Handler/TrainClassHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TrainCatet",
                    CateId: id
                    //CateId: $("input[name=rad]:checked").val()
                },
                success: function (data) {

                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<option value='" + i.T_ID + "'>" + i.T_Name + "</option>";
                    });
                    //alert(str);
                    //$("#ddlT_Name option:gt(0)").remove();
                    //$("#ddlT_Name").append(str);

                    $(".ddlT_Name option:gt(0)").remove();
                    $(".ddlT_Name").append(str);

                }
            });
        }
        //给模态框的下拉列表赋值
        function TrainCag(id)
        {
          
            $.ajax({
                type: "get",
                url: "Handler/TrainClassHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TrainCatet",
                    CateId: id
                    //CateId: $("input[name=rad]:checked").val()
                },
                success: function (data) {

                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<option value='" + i.T_ID + "'>" + i.T_Name + "</option>";
                    });
                    if (id==0) {
                        $(".ddlT_T_Categoryt option:gt(0)").remove();
                        $(".ddlT_T_Categoryt").append(str);
                    }
                    if (id ==1) {
                        $(".ddlT_T_Categorye option:gt(0)").remove();
                        $(".ddlT_T_Categorye").append(str);
                    }
                   
                   
                }

              
            });
        }

        //通过班级编号获取值
        function TreacherTcidquery()
        {
            $.ajax({
                type: "get",
                url: "Handler/TrainClassHandler.ashx",
                dataType: "json",
                data: {
                    Method: "TreacherTcidquery",
                    Tcid: $("#HidTc_id").val()
                },
                success: function (data)
                {
                    $("#txtTc_Name").val(data[0].TC_Name);
                    $("#txtTC_Grade").val(data[0].TC_Grade);
                    $("#txtTC_BeginTime").val(data[0].TC_BeginTime);
                    $("#txtTC_EndTime").val(data[0].TC_EndTime);
                    $("#txtTC_MaxAmount").val(data[0].TC_MaxAmount);
                    $("#txtProvice").val(data[0].TC_Period);
                    if (data[0].jyid !=0)
                    {
                        $(".ddlT_T_Categoryt").val(data[0].jyid);
                      
                    }
                    //else
                    //{
                    //    $(".ddlT_T_Categorye").val(data[0].ddid);
                    
                    //}
                    if (data[0].ddid != 0) {
                        $(".ddlT_T_Categorye").val(data[0].ddid);
                    }
                    //else {
                    //    $(".ddlT_T_Categoryt").val(data[0].jyid);
                     
                    //}
                   
                  
                }
            });
        }
    </script>

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
            <div>
                <h1>实训班级</h1>
                <table>
                    <tr>
                        <td>班级名称：<input id="txtClassName" type="text" /></td>
                        <td>教师： <input id="Radio1" type="radio" name="rad" value="0" onchange="TrainCatet(0)" />教员
                            <input id="Radio2" type="radio" name="rad" value="1" onchange="TrainCatet(1)" />督导
                        </td>
                        <td>
                            <select class="ddlT_Name ">
                                <option  value="0">--请选择--</option>
                            </select>
                        </td>
                        
                        <td>
                            <button type="button" class="btn btn-success" id="btnclassquery">查询</button>
                            <button type="button" class="btn btn-warning" id="btnclassAdd">新增</button>

                        </td>
                    </tr>
                </table>
                <table class="table table-hover" id="TrainClassInfo">
                    <thead>
                        <tr>
                            <th>实训班级名称</th>
                            <th class="auto-style1">进入实训时间</th>
                            <th>景宁就业时间</th>
                            <th>实训允许最大人数</th>
                            <th>实际男生人数</th>
                            <th>实际女生人数</th>
                            <th>实训周期</th>
                            <th>教员</th>
                            <th>督导</th>
                            <th>操作</th>
                        </tr>

                    </thead>
                </table>

            </div>
        <input id="HidT_id" type="hidden" />
        <input id="HidTc_id" type="hidden" />
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
                                    <td>班级名称：<input id="txtTc_Name" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>年&nbsp;&nbsp;级：<input id="txtTC_Grade" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>实训开始时间：<input id="txtTC_BeginTime" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>实训结束时间：<input id="txtTC_EndTime" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>最&nbsp;大&nbsp;人 &nbsp;数：<input id="txtTC_MaxAmount" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>实&nbsp; 训 &nbsp; 周&nbsp; 期：<input id="txtProvice" type="text" />月</td>
                                </tr>
                                <tr>
                                    <td>教&nbsp;&nbsp;&nbsp;&nbsp;员：<select class="ddlT_T_Categoryt "  >
                                            <option value="0">--请选择--</option>
                                    </select></td>
                                </tr>
                                <tr>
                                    <td>督&nbsp;&nbsp;&nbsp;&nbsp;导：<select class="ddlT_T_Categorye " >
                                        <option value="1">--请选择--</option>
                                    </select></td>
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
                </div>
            </div>
        
    </form>
</body>
</html>
