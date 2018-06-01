<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SchoolStudentS.aspx.cs" Inherits="CRM_Test.SchoolStudentS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Excel/jquery.table2excel.js"></script>
    <script type="text/javascript">
        $(function () {
            SchProvicesQuery();
            ProvicesQuery();

            //点击查询时
            $("#btnSeach").click(function () {
                SchProvicesQuery();
            });

            //点击导出
            $("#btnclasschu").click(function () {
                $("#ClassStudentInfo").table2excel({
                    exclude: ".noExl",
                    name: "Excel Document Name",
                    filename: "myFileName",
                    exclude_img: true,
                    exclude_links: true,
                    exclude_inputs: true
                });
            });
            //模态框1的查询
            $("#btnclassSeach").click(function () {
                ClassStudent();
                $(".ddlSp_id").val(0);
             
            });
        });
        //// 省份和校区的联合查询
        function SchProvicesQuery() {
            $.ajax({
                type: "get",
                url: "Handler/SchoolStudentSHandler.ashx",
                dataType: "json",
                data: {
                    Mothod: "SchProvicesQuery",
                    P_id: $(".ddlP_id").val(),
                    SName: $("#txtSName").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, x) {
                        str += "<tr>";
                        str += "<td>" + x.School_Code + "</td>";
                        str += "<td>" + x.School_Name + "</td>";
                        str += "<td>" + x.P_Name + "</td>";
                        str += "<td>" + x.School_Remark + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-success\" onclick='SchoolStdentQuery(" + x.School_ID + ")'>查看</button> ";
                        str += "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-warning\" onclick='StationUpdate(" + x.School_ID + ")'>导入Excel</button></td> ";
                        str += "</tr>";
                    });
                    $("#SchoolProviceInfo tr:gt(0)").remove();
                    $("#SchoolProviceInfo").append(str);
                }

            });

        }

        //查询所有省份(下拉列表)
        function ProvicesQuery() {
            $.ajax({
                type: "get",
                url: "Handler/SchoolStudentSHandler.ashx",
                dataType: "json",
                data: {
                    Mothod: "ProvicesQuery"
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, o) {
                        str += " <option value='" + o.P_ID + "'>" + o.P_Name + "</option>";
                    });
                    $(".ddlP_id tr:gt(0)").remove();
                    $(".ddlP_id").append(str);
                }
            });
        }

        //点击查看(查询校区班级信息)
        function SchoolStdentQuery(Sid) {

            $("#myModal").modal({ backdrop: "static" });
            $("#hid_Sid").val(Sid);
            ClassStudent();
            SpecialtiesQuery()
            $(".ddlSp_id").val(0);
            $(".ddlSp_id").val("");

        }
        //查询校区班级信息
        function ClassStudent() {
            $.ajax({
                type: "get",
                url: "Handler/SchoolStudentSHandler.ashx",
                dataType: "json",
                data: {
                    Mothod: "SchoolStdentQuery",
                    Sid: $("#hid_Sid").val(),
                    Sp_id: $(".ddlSp_id").val(),
                    CName: $("#txtCName").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<tr>";
                        str += "<td>" + i.School_Name + "</td>";
                        str += "<td>" + i.Specialty_Name + "</td>";
                        str += "<td>" + i.SC_Name + "</td>";
                        str += "<td>" + (i.SC_MaleAmount + i.SC_FemaleAmount) + "</td>";
                        str += "<td>" + i.SC_FemaleAmount + "</td>";
                        str += "<td>" + i.SC_MaleAmount + "</td>";
                        str += "<td><button type=\"button\" class=\"btn btn-info\" onclick='StudentInfoQuery(&quot;" + i.Specialty_ID + "&quot;,&quot;" + i.SC_ID + "&quot;)' >查看</button></td>";
                        str += "</tr>"
                    });
                    $("#ClassStudentInfo tr:gt(0)").remove();
                    $("#ClassStudentInfo").append(str);
                }
            });
        }
        //点击模态框1的查看，查看模态框2的班级学生信息
        function StudentInfoQuery(Spid,Scid)
        {
            
            $("#myModa2").modal({ backdrop: "static" });
            $("#Hid_Spid").val(Spid);
            $("#Hid_Scid").val(Scid);
            StuentQuery();
        }
        //跟据条件查询所属校区班级学生信息
        function StuentQuery()
        {
            $.ajax({
                type: "get",
                url: "Handler/SchoolStudentSHandler.ashx",
                dataType: "json",
                data: {
                    Mothod: "StuentQuery",
                    stuid: $("#hid_Sid").val(),
                    scid: $("#Hid_Scid").val(),
                    spid: $("#Hid_Spid").val()
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, a) {
                        str += "<tr>";
                        str += "<td>" + a.Student_Name + "</td>";
                        str += "<td>" + a.SC_Name+ "</td>";
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
        //查询所有专业名称（下拉列表）
        function SpecialtiesQuery() {
            $.ajax({
                type: "get",
                url: "Handler/SchoolStudentSHandler.ashx",
                dataType: "json",
                data: {
                    Mothod: "SpecialtiesQuery"
                },
                success: function (data) {
                    var str = "";
                    $.each(data, function (index, i) {
                        str += "<option value='" + i.Specialty_ID + "' >" + i.Specialty_Name + "</option>";
                    });
                    $(".ddlSp_id tr:gt(0)").remove();
                    $(".ddlSp_id").append(str);
                }
            });
            $(".ddlSp_id").val("");
        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <input id="Hid_Spid" type="hidden" />
                <input id="Hid_Scid" type="hidden" />
                <input id="hid_Sid" type="hidden" />
                <table>
                    <tr>

                        <td>省份名称：<select class="ddlP_id">
                            <option value="0">--请选择--</option>
                        </select>
                        </td>
                        <td>校区名称：<input id="txtSName" type="text" /></td>

                        <td>
                            <button type="button" class="btn btn-success" id="btnSeach">查询</button>
                        </td>
                    </tr>
                </table>


                <table class="table table-hover" id="SchoolProviceInfo">
                    <thead>
                        <tr>
                            <th>校区代码</th>
                            <th class="auto-style1">校区名称</th>
                            <th>省份名称</th>
                            <th>校区备注</th>
                            <th>操作</th>
                        </tr>

                    </thead>
                </table>

            </div>

            <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" style="width: 1000px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel">查看校区班级
                            </h4>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tr>
                                    <td>专业名称：<select class="ddlSp_id ">
                                        <option value="0">--请选择--</option>
                                    </select></td>
                                </tr>
                                <tr>
                                    <td>班级名称：<input id="txtCName" type="text" /></td>

                                    <td>
                                        <button type="button" class="btn btn-success" id="btnclassSeach">查询</button>
                                    </td>
                                     <td>
                                        <button type="button" class="btn btn-success" id="btnclasschu">导出</button>
                                    </td>
                                </tr>
                            </table>


                            <table class="table table-hover" id="ClassStudentInfo">
                                <thead>
                                    <tr>
                                        <th>校区名称</th>
                                        <th class="auto-style1">专业名称</th>
                                        <th>校区班级名称</th>
                                        <th>班级总人数</th>
                                        <th>男生人数</th>
                                        <th>女生人数</th>
                                        <th>操作</th>
                                    </tr>

                                </thead>
                            </table>
                        </div>


                    </div>
                </div>
            </div>

            <div class="modal fade" id="myModa2" tabindex="-1" role="dialog"
                aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" style="width:600px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabe2">查看校区班级学生
                            </h4>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tr>
                                    <td>姓名：<input id="txtStuName" type="text" /></td>

                                    <td>
                                        <button type="button" class="btn btn-success" id="btnstudentQuery">查询</button>
                                    </td>
                                </tr>
                            </table>
                            <div style="width:500px; overflow-x:scroll;overflow-y:hidden;">  <%-- 宽度滚动设宽度，高度滚动设高度--%>
                                 <table class="table table-hover" id="StudentInfo">
                                <thead>
                                    <tr>
                                        <th>学生姓名</th>
                                        <th class="auto-style1">班级名称</th>
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
