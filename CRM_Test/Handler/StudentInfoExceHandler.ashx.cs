using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
namespace CRM_Test.Handler
{
    /// <summary>
    /// StudentInfoExceHandler 的摘要说明
    /// </summary>
    public class StudentInfoExceHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Mothod = context.Request["Mothod"].ToString();
            switch (Mothod)
            {
                case "ClassQuery":  //查询所有实训班级信息
                    ClassQuery(context);
                    break;
                case "StationStudentQuery":  //查询所有实训班级信息
                    StationStudentQuery(context);
                    break;
                    
            }
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }
        /// <summary>
        ///查询所有实训班级信息
        /// </summary>
        /// <param name="context"></param>
        public void ClassQuery(HttpContext context)
        {
            string CTime = context.Request["CTime"].ToString();
            DataTable dt = BLL.StudentInfoExce_BLL.ClassQuery(CTime);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        ///查询所有实训班级信息
        /// </summary>
        /// <param name="context"></param>
        public void StationStudentQuery(HttpContext context)
        {
            int CT_ID = int.Parse( context.Request["CT_ID"].ToString());
            DataTable dt = BLL.StudentInfoExce_BLL.StudentQueryeexcel(CT_ID);
            string json = JsonConvert.SerializeObject(dt);
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