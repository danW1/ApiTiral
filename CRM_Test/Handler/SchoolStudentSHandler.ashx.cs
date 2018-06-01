using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Newtonsoft.Json;
namespace CRM_Test.Handler
{
    /// <summary>
    /// SchoolStudentSHandler 的摘要说明
    /// </summary>
    public class SchoolStudentSHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Mothod = context.Request["Mothod"].ToString();
            switch (Mothod)
            {
                case "SchProvicesQuery":  // 省份和校区的联合查询
                    SchProvicesQuery(context);
                    break;
                case "ProvicesQuery":  // 省份查询
                    ProvicesQuery(context);
                    break;
                case "SchoolStdentQuery":  // 查询校区班级信息
                    SchoolStdentQuery(context);
                    break;
                case "SpecialtiesQuery":  // 查询所有专业名称
                    SpecialtiesQuery(context);
                    break;
                case "StuentQuery":  //跟据条件查询所属校区班级学生信息
                    StuentQuery(context);
                    break;
                    



            }
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }
        /// <summary>
        /// // 省份和校区的联合查询
        /// </summary>
        /// <param name="context"></param>
        public void SchProvicesQuery(HttpContext context)
        {
            int P_id = 0;
            try
            {
                P_id = int.Parse(context.Request["P_id"].ToString());
            }
            catch 
            {
            }
            string Sname= context.Request["SName"].ToString();
            DataTable dt = BLL.SchoolStudentS_BLL.ProvinceSchol(P_id, Sname);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        /// // 省份的查询
        /// </summary>
        /// <param name="context"></param>
        public void ProvicesQuery(HttpContext context)
        {
            DataTable dt = BLL.SchoolStudentS_BLL.ProvinceQuery();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }


        /// <summary>
        /// // 查询校区班级信息
        /// </summary>
        /// <param name="context"></param>
        public void SchoolStdentQuery(HttpContext context)
        {

            string CName = context.Request["CName"].ToString();
            int  Sp_id =int.Parse( context.Request["Sp_id"].ToString());
            int Sid = int.Parse(context.Request["Sid"].ToString());
            DataTable dt = BLL.SchoolStudentS_BLL.SchoolClassQuery(Sid, Sp_id, CName);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        /// // 查询校区班级信息
        /// </summary>
        /// <param name="context"></param>
        public void SpecialtiesQuery(HttpContext context)
        {
            DataTable dt = BLL.SchoolStudentS_BLL.SpecialtiesQuery();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        /// // 查询校区班级信息
        /// </summary>
        /// <param name="context"></param>
        public void StuentQuery(HttpContext context)
        {
            int stuid =int.Parse( context.Request["stuid"].ToString());
            int scid = 0;
            int spid = 0;
            try
            {
               scid = int.Parse(context.Request["scid"].ToString());
               spid = int.Parse(context.Request["spid"].ToString());
            }
            catch 
            {

            }
            
            DataTable dt = BLL.SchoolStudentS_BLL.StudentQuery(stuid,scid,spid);
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