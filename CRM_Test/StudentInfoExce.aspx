<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentInfoExce.aspx.cs" Inherits="CRM_Test.StudentInfoExce" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Excel/jquery.table2excel.js"></script>
    <script  type ="text/javascript" >
        $(function () {
            ClassQuery();

            //点击查询时，按日期查询
            $("#btnStudentQuery").click(function () {
                ClassQuery()
                $("#txtSDateTime").val("");
            });

            //导出
            $("#btnStudentExecl").click(function () {
                $("#ClassInfo").table2excel({
                    exclude: ".noExl",
                    name: "Excel Document Name",
                    filename: "myFileName",
                    exclude_img: true,
                    exclude_links: true,
                    exclude_inputs: true
                });
            });
        });
        //查询所有实训班级信息
        function ClassQuery()
        {
            $.ajax({
                type:"get",
                url:"Handler/StudentInfoExceHandler.ashx",
                dataType: "json",
                data: {
                    Mothod: "ClassQuery",
                    CTime: $("#txtSDateTime").val()
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
                        str += "<td>" + (x.TC_MaleAmount + x.TC_FemaleAmount) + "</td>";
                        str += "<td>" + x.TC_Period + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-primary\" onclick='StationStudentQuery(" + x.TC_ID + ")'>查看</button> ";
                        str += "<button type=\"button\" class=\"btn btn-warning\" >导出此班学生信息</button>";
                        str += "</td>";
                        str += "</tr>";
                    });
                    $("#ClassInfo tr:gt(0)").remove();
                    $("#ClassInfo").append(str);
                }


            });
        }

        //点击查看
        function StationStudentQuery(Tc_id)
        {
            $("#myModa2").modal({backdrop:"static"});
            $.ajax({
                type: "get",
                url: "Handler/StudentInfoExceHandler.ashx",
                dataType: "json",
                data: {
                    Mothod: "StationStudentQuery",
                    CT_ID: Tc_id
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, a) {
                        str += "<tr>";
                        str += "<td>" + a.Student_Name + "</td>";
                        str += "<td>" + a.Student_NO + "</td>";
                        str += "<td>" + a.Student_Sex + "</td>";
                        str += "<td>" + a.Student_IdentityNumber + "</td>";
                        str += "<td>" + a.Student_State + "</td>";
                        str += "<td>" + a.Student_Exam + "</td>";
                        str += "<td>" + a.Student_Education + "</td>";
                        str += "<td>" + a.Student_Specialty + "</td>";
                        str += "<td>" + a.Student_Schoolofgraduation + "</td>";
                        str += "<td>" + a.Student_PersonalTel + "</td>";
                        str += "<td>" + a.Student_FamilyTel + "</td>";
                        str += "<td>" + a.Student_QQ + "</td>";
                        str += "<td>" + a.Student_Address + "</td>";
                        str += "<td>" + a.Student_PostCode + "</td>";
                        str += "<td>" + a.Student_EducationMoney + "</td>";
                        str += "<td>" + a.Student_SkillTrainingMoney + "</td>";
                        str += "<td>" + a.Student_TrainResideMoney + "</td>";
                        str += "<td>" + a.Student_Evaluate1 + "</td>";
                        str += "<td>" + a.Student_Evaluate2 + "</td>";
                        str += "<td>" + a.Student_Remark + "</td>";
                        str += "<td>" + a.Station_ID + "</td>";
                        str += "<td>" + a.Stationt_SelectStationCount + "</td>";
                        str += "</tr>";
                    });

                    $("#StudentInfo tr:gt(0)").remove();
                    $("#StudentInfo").append(str);
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
                <table>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 请选择时间：<input id="txtSDateTime" type="date" /></td>

                        <td>
                            <button type="button" class="btn btn-success" id="btnStudentQuery">查询</button>

                        </td>
                       <td>
                              <button type="button" class="btn btn-success" id="btnStudentExecl">导出</button>
                        </td>
                    </tr>
                </table>


                <table class="table table-hover" id="ClassInfo">
                    <thead>
                        <tr>
                            <th>实训班级名称</th>
                            <th class="auto-style1">进人实训时间</th>
                            <th>景宁就业时间</th>
                            <th>实训允许最大人数</th>
                            <th>实际男生人数</th>
                            <th class="auto-style1">实际女生人数</th>
                            <th>总人数</th>
                            <th>实训周期</th>
                            <th>操作</th>
                        </tr>

                    </thead>
                </table>

            </div>

         <div class="modal fade" id="myModa2" tabindex="-1" role="dialog"
                aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog"  style="width:600px" >
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabe2">查看班级学生
                            </h4>
                        </div>
                        <div class="modal-body"  >
                            <table>
                                <tr>
                                    <td>姓名：<input id="txtStuName" type="text" /></td>

                                    <td>
                                        <button type="button" class="btn btn-success" id="btnstudentQuery">查询</button>
                                    </td>
                                </tr>
                            </table>
                            <div style="width:500px; overflow-x:scroll; overflow-y:hidden;"> <%-- 宽度滚动设宽度，高度滚动设高度--%>

                            <table class="table table-hover" id="StudentInfo" >
                                <thead>
                                    <tr>
                                        <th>学生姓名</th>
                                        <th>学号</th>
                                        <th>性别</th>
                                        <th>身份证号</th>
                                        <th>学生状态</th>
                                        <th>已通过认证</th>
                                        <th>学历</th>
                                        <th>专业</th>
                                        <th>毕业学校</th>
                                        <th>个人手机</th>
                                        <th>家庭座机</th>
                                        <th>QQ号</th>
                                        <th>通信地址</th>
                                        <th>邮编</th>
                                        <th>学历费</th>
                                        <th>技能培训费</th>
                                        <th>实训住宿费</th>
                                        <th>技能评价</th>
                                        <th>班主任评价</th>
                                        <th>备注</th>
                                        <th>最终选择的岗位</th>
                                        <th>选岗次数</th>
                                    </tr>

                                </thead>
                            </table>
                                
                            </div>
                        </div>


                    </div>
                </div>
            </div>
    </div>
    </form>
</body>
</html>
