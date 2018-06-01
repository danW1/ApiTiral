using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using System.Data;
using Model;

using System.Web.SessionState;
using System.IO;

namespace CRM_Test.Handler
{
    /// <summary>
    /// TeachersHandler 的摘要说明
    /// </summary>
    public class TeachersHandler : IHttpHandler,IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
           
            string method = context.Request["Method"].ToString();
            switch (method) {
                case "TeacherAdmin":   //登录验证所
                    TeacherAdmin(context);
                    break;
                   
                 case "TeacherQuery":   //模糊查询所有信息
                    TeacherQuery(context);
                    break;
                case "TeacherDelete":   //删除
                    TeacherDelete(context);
                    break;
                case "TeacherAdd":  //添加
                    TeacherAdd(context);
                    break;
                    
                case "TeacherUpdateid":  //根据编号获取信息
                    TeacherUpdateid(context);
                    break;
                case "TeacherUpdate":   //修改
                    TeacherUpdate(context);
                    break;
                case "UpdateTeacherTid":  //重置密码（123）
                    UpdateTeacherTid(context);
                    break;
                case "TeacherIsEnabled":  //禁启用
                    TeacherIsEnabled(context);
                    break;
                case "GetName":  //登录时获取用户名
                    GetName(context);
                    break;
                //case "TeacherQueryrt":    //导出
                //    TeacherQueryrt(context);
                //    break;


            }


        }
        /// <summary>
        /// 获取登录的用户名
        /// </summary>
        /// <param name="context"></param>
        public void GetName(HttpContext context)
        {
          
        }
        /// <summary>
        /// 登录验证
        /// </summary>
        /// <param name="context"></param>
        public void TeacherAdmin(HttpContext context)
        {

            string LoginName = context.Request["loginName"].ToString();
            string Pwd = context.Request["Pwd"].ToString();

            DataTable dt = BLL.Teacher_BLL.teacherLogin(LoginName, Pwd);
            int i = 0;
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["T_IsEnabled"].ToString() == "True")//判断账户是否可用
                {

                    i = int.Parse(dt.Rows[0][7].ToString());
                    string time = System.DateTime.Now.ToString();
                    bool bo = BLL.Teacher_BLL.UpdateLastTime(time, int.Parse(dt.Rows[0][0].ToString()));
                    context.Session["dt"] = dt;
                    
                }
                else
                {
                    i = 5;   //用户被禁用
                }
            }
            else
            {
                i = 0;   //用户名和密码不存在或错误
            }
            string json = JsonConvert.SerializeObject(i);
            //context.Response.ContentType = "text/plain";
            context.Response.Write(json);
        }
       
        /// <summary>
        ///根据条件查询所有Teacher 表信息
        /// </summary>
        /// <param name="context"></param>
        public void TeacherQuery(HttpContext context)
        {
            string Name = context.Request["Name"].ToString();
            string LoginName = context.Request["LoginName"].ToString();
            string Tel = context.Request["Tel"].ToString();
            int Category = int.Parse( context.Request["Category"].ToString());

            DataTable dt = BLL.Teacher_BLL.TeacherQuery(Name, LoginName, Tel, Category);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);

        }
        /// <summary>
        /// 根据教师ID查询全部信息，返回一张数据表
        /// </summary>
        /// <param name="context"></param>
        public void TeacherUpdateid(HttpContext context)
        {
            int uid =int.Parse( context.Request["uid"].ToString());

            DataTable dt = BLL.Teacher_BLL.TeacherTId(uid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        /// 添加
        /// </summary>
        /// <param name="context"></param>
        public void TeacherAdd(HttpContext context)
        {
          
            string T_name = context.Request["T_Name"].ToString();
            string T_Sex = context.Request["T_Sex"].ToString();
            string T_Tel = context.Request["T_Tel"].ToString();
            int T_Category = int.Parse( context.Request["T_Category"].ToString());
            string T_LoginName = context.Request["T_LoginName"].ToString();
            int  T_Role =int.Parse( context.Request["T_Role"].ToString());
            TeachersInfo T = new TeachersInfo();
            T.T_Name = T_name;
            T.T_Sex = T_Sex;
            T.T_Tel = T_Tel;
            T.T_Category = T_Category;
            T.T_LoginName = T_LoginName;
            T.T_Role = T_Role;
            bool b = BLL.Teacher_BLL.TeacherAdd(T);
            string str = "";
            if (b)
            {
                str = "1";
            }
            else
            {
                str = "0";
            }
            string json = JsonConvert.SerializeObject(str);
            context.Response.Write(json);

        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="context"></param>
        public void TeacherUpdate(HttpContext context)
        {

            string T_name = context.Request["T_Name"].ToString();
            string T_Sex = context.Request["T_Sex"].ToString();
            string T_Tel = context.Request["T_Tel"].ToString();
            int T_Category = int.Parse(context.Request["T_Category"].ToString());
            string T_LoginName = context.Request["T_LoginName"].ToString();
            int T_Role = int.Parse(context.Request["T_Role"].ToString());
            int Tid = int.Parse(context.Request["T_ID"].ToString());

            TeachersInfo T = new TeachersInfo();
            T.T_Name = T_name;
            T.T_Sex = T_Sex;
            T.T_Tel = T_Tel;
            T.T_Category = T_Category;
            T.T_LoginName = T_LoginName;
            T.T_Role = T_Role;
            T.T_ID = Tid;
            bool b = BLL.Teacher_BLL.TeacherUpdate(T);
            string str = "";
            if (b)
            {
                str = "1";
            }
            else
            {
                str = "0";
            }
            string json = JsonConvert.SerializeObject(str);
            context.Response.Write(json);

        }
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="context"></param>
        public void TeacherDelete(HttpContext context)
        {
            int T_id =int.Parse( context.Request["uid"].ToString());

            bool b = BLL.Teacher_BLL.TeacherDelete(T_id);
            string str = "";

            if (b)
            {
                str = "1";  //删除成功
            }
            else
            {
                str = "0";   //删除失败
            }
            string json = JsonConvert.SerializeObject(str);
            context.Response.Write(json);

        }

        /// <summary>
        /// 重置密码（123）
        /// </summary>
        /// <param name="context"></param>
        public void UpdateTeacherTid(HttpContext context)
        {
            int T_id = int.Parse(context.Request["Tid"].ToString());
            bool b = BLL.Teacher_BLL.UpdateTeactPwd(T_id);

            string str = "";

            if (b)
            {
                str = "1";  
            }
            else
            {
                str = "0";  
            }
            string json = JsonConvert.SerializeObject(str);
            context.Response.Write(json);

        }
        /// <summary>
        /// 禁启用
        /// </summary>
        /// <param name="context"></param>
        public void TeacherIsEnabled(HttpContext context)
        {
            int uid =int.Parse( context.Request["uid"].ToString());
            string  IsEnabled =context.Request["IsEnabled"].ToString();
            bool b = BLL.Teacher_BLL.TeacherIsEnabled(IsEnabled, uid);

            string str = "";

            if (b)
            {
                str = "1";
            }
            else
            {
                str = "0";
            }
            string json = JsonConvert.SerializeObject(str);
            context.Response.Write(json);
        }

        //导出
        //public void TeacherQueryrt(HttpContext context)
        //{
        //    DataTable dt = BLL.Teacher_BLL.TeacherQuery("","","",3);
        //    //string excelPath = ExcelUtility.Export.ToExcel(dt, "导出结果");
        //    //Assert.IsTrue(File.Exists(excelPath));
        //    //创建Excel文件的对象
        //    NPOI.HSSF.UserModel.HSSFWorkbook book = new NPOI.HSSF.UserModel.HSSFWorkbook();
        //    //添加一个sheet
        //    NPOI.SS.UserModel.ISheet sheet1 = book.CreateSheet("Sheet1");

        //    //给sheet1添加第一行的头部标题
        //    NPOI.SS.UserModel.IRow row1 = sheet1.CreateRow(0);
        //    row1.CreateCell(0).SetCellValue("老师姓名");
        //    row1.CreateCell(1).SetCellValue("性别");
        //    row1.CreateCell(2).SetCellValue("电话");
        //    int num = 0;
        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        NPOI.SS.UserModel.IRow rowtemp = sheet1.CreateRow(i + 1);
        //        rowtemp.CreateCell(0).SetCellValue(dt.Rows[i]["T_Name"].ToString());
        //        rowtemp.CreateCell(1).SetCellValue(dt.Rows[i]["T_Sex"].ToString());
        //        rowtemp.CreateCell(2).SetCellValue(dt.Rows[i]["T_Tel"].ToString());
        //        num++;
        //    }
        //    // 写入到客户端 
        //    FileStream fs = new FileStream("C:\\Users\\Administrator\\Desktop\\11.14.xls", FileMode.Create);
        //    book.Write(fs);
        //    fs.Close();
        //}
        
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}