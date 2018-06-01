using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Newtonsoft.Json;
using Model;
namespace CRM_Test.Handler
{
    /// <summary>
    /// TrainClassHandler 的摘要说明
    /// </summary>
    public class TrainClassHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Method = context.Request["Method"].ToString();
            switch (Method)
            {

                case "TrainClassQuery":  // 查询所有实训班级信息
                    TrainClassQuery(context);
                      break;
                case "TrainCatet":   // 根据教师身份查询教师姓名
                    TrainCatet(context);
                    break;
                case "TeacherDelete":  // 根据班级编号删除数据
                    TeacherDelete(context);
                    break;
              
                case "TrainclassAdd":   // 根据班级编号添加班级信息
                    TrainclassAdd(context);
                    break;
                case "TreacherTcidquery": // 根据班级编号查询所有信息
                    TreacherTcidquery(context);
                    break;
                case "TeacherClassUpdate": // 根据班级编号修改班级实训信息
                    TeacherClassUpdate(context);
                    break;


                
            }
               
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            }

        /// <summary>
        /// 查询所有实训班级信息
        /// </summary>
        /// <param name="context"></param>
        public void TrainClassQuery(HttpContext context)
        {
            string Cname = context.Request["CName"].ToString();
            int T_id = 0;
            try
            {
                T_id = int.Parse(context.Request["T_id"].ToString());
            }
            catch 
            {

            }
            DataTable dt = BLL.TrainClass_BLL.TrainClassQuery(Cname, T_id);
            // 创建一个新列

            DataColumn myColumn = new DataColumn();

            myColumn.ColumnName = " CustID ";

            myColumn.DataType = System.Type.GetType("System.Int32");

            // 设置自动递增

            myColumn.AutoIncrement = true;

            myColumn.AutoIncrementSeed = 1;

            myColumn.AutoIncrementStep = 1;
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        /// 根据教师身份查询教师姓名
        /// </summary>
        /// <param name="context"></param>
        public void TrainCatet(HttpContext context)
        {
            int T_Category = 0;
            try
            {
                T_Category = int.Parse(context.Request["CateId"].ToString());
            }
            catch
            {
            }
            DataTable dt = BLL.TrainClass_BLL.TraintCategory(T_Category);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        /// 根据班级编号删除数据
        /// </summary>
        /// <param name="context"></param>
        public void TeacherDelete(HttpContext context)
        {
            int TcId = int.Parse(context.Request["TcId"].ToString());
            bool i = BLL.TrainClass_BLL.TrainClassDELETE(TcId);
            string str = "";
            if (i)
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
        ///  新增
        /// </summary>
        /// <param name="context"></param>
        public void TrainclassAdd(HttpContext context)
        { 
            string Tc_Name = context.Request["Tc_Name"].ToString();
            string TC_Grade = context.Request["TC_Grade"].ToString();
            DateTime TC_BeginTime = DateTime.Parse(context.Request["TC_BeginTime"].ToString());
            DateTime TC_EndTime = DateTime.Parse(context.Request["TC_EndTime"].ToString());
            string TC_MaxAmount = context.Request["TC_MaxAmount"].ToString();
            string Provice = context.Request["Provice"].ToString();
            int  Categoryt = int.Parse(context.Request["Categoryt"].ToString());
            int Categorye = int.Parse(context.Request["Categorye"].ToString());

            TrainClassesInfo T = new TrainClassesInfo();
            T.TC_Name = Tc_Name;
            T.TC_Grade = TC_Grade;
            T.TC_BeginTime = TC_BeginTime;
            T.TC_EndTime= TC_EndTime;
            T.TC_MaxAmount = TC_MaxAmount;
            T.TC_Period = Provice;
            T.TC_Grade = TC_Grade;
            //  TrainClassTeachersInfo c = new TrainClassTeachersInfo();
            int jyID = 0;
            int ddID = 0;
            if (Categoryt != 0)
            {
                jyID = Categoryt;
            }
            if(Categorye!=0)
            {
                ddID = Categorye;
            }
            string str = "";

           bool b= BLL.TrainClass_BLL.TeacherClassAdd(T,jyID,ddID);
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
        /// 通过班级编号获取值
        /// </summary>
        /// <param name="context"></param>
        public void TreacherTcidquery(HttpContext context) {
            int Tc_id =int.Parse( context.Request["Tcid"].ToString());
            DataTable dt = BLL.TrainClass_BLL.TeacherqueryTcid(Tc_id);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="context"></param>
        public void TeacherClassUpdate(HttpContext context)
        {
            string Tc_Name = context.Request["Tc_Name"].ToString();
            string TC_Grade = context.Request["TC_Grade"].ToString();
            DateTime  TC_BeginTime =DateTime.Parse( context.Request["TC_BeginTime"].ToString());
            DateTime TC_EndTime = DateTime.Parse(context.Request["TC_EndTime"].ToString());
            string TC_MaxAmount = context.Request["TC_MaxAmount"].ToString();
            string Provice = context.Request["Provice"].ToString();
            int Categoryt = 0;
            int Categorye = 1;
            try
            {
                  Categoryt = int.Parse(context.Request["Categoryt"].ToString());
                 Categorye = int.Parse(context.Request["Categorye"].ToString());
            }
            catch 
            {
            }
            int Tc_ID = int.Parse(context.Request["Tc_ID"].ToString());
      
            TrainClassesInfo T = new TrainClassesInfo();
            T.TC_Name = Tc_Name;
            T.TC_Grade = TC_Grade;
            T.TC_BeginTime = TC_BeginTime;
            T.TC_EndTime = TC_EndTime;
            T.TC_MaxAmount = TC_MaxAmount;
            T.TC_Period = Provice;
            T.TC_Grade = TC_Grade;
            T.TC_ID = Tc_ID;
           
            int jyID = 0;
            int ddID = 0;
            if (Categoryt != 0)
            {
                jyID = Categoryt;
            }
            if (Categorye != 0)
            {
                ddID = Categorye;
            }
            String str = "";
            bool b = BLL.TrainClass_BLL.TeacherUpdate(T, jyID, ddID);
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
        
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}