using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Model;
using System.Data;
using Newtonsoft.Json;

namespace CRM_Test.Handler
{
    /// <summary>
    /// SchoolsHandler 的摘要说明
    /// </summary>
    public class SchoolsHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Method = context.Request["Method"].ToString();
            switch (Method) {
                case "ProvinceQuery":
                    ProvinceQuery(context);
                    break;
                    
                case "SchoolsProvices":   // 根据省份编号查询所有校区信息
                    SchoolsProvices(context);
                    break;
                //case "SchoolsQueryId":   // 根据省份编号查询所有校区信息
                //    SchoolsQueryId(context);
                //    break;
                    
                case "SchoolsidDelete":
                    SchoolsidDelete(context);
                    break;
                case "SchoolsidUpdate":
                    SchoolsidUpdate(context);
                    break;
                    
                case "btnSchoolUpdate":
                    btnSchoolUpdate(context);
                    break;

                    
                 case "btnSchoolAdd":
                    btnSchoolAdd(context);
                    break;
            }

            //context.Response.Write("Hello World");
        }

        /// <summary>
        /// 根据校区代码，删除学校
        /// </summary>
        /// <param name="context"></param>
        public void SchoolsidDelete(HttpContext context)
        {
            int Pid =int.Parse(context.Request["Pid"].ToString());
            string Sid = context.Request["Sid"].ToString();
            bool b = BLL.SchooInfo_BLL.Schooldelete(Pid,Sid);
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
        /// 显示所有省份信息
        /// </summary>
        /// <param name="context"></param>
        public void ProvinceQuery(HttpContext context)
        {
            string PName = context.Request["PName"].ToString();
            DataTable dt = BLL.Provinces_BLL.ProvinceQuery(PName);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }


        ///// <summary>
        ///// 根据学校编号查询所有校区信息
        ///// </summary>
        ///// <param name="context"></param>
        public void SchoolsQueryId(HttpContext context)
        {

            int Pid = int.Parse(context.Request["Pid"].ToString());
            string Code = context.Request["Code"].ToString();
            string SchoolName = context.Request["SchoolName"].ToString();
            DataTable dt = BLL.Provinces_BLL.ProvinceSid(Pid, Code, SchoolName);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        /// 根据省份编号查询所有校区信息
        /// </summary>
        /// <param name="context"></param>
        public void SchoolsProvices(HttpContext context)
        {
           
           int Pid=int.Parse( context.Request["Pid"].ToString());
            string Code = context.Request["Code"].ToString();
            string SchoolName = context.Request["SchoolName"].ToString();
            DataTable dt = BLL.Provinces_BLL.ProvincePid(Pid,Code, SchoolName);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        /// 根据校区id，查询校区信息
        /// </summary>
        /// <param name="context"></param>
        public void SchoolsidUpdate(HttpContext context)
        {
            int  Sid = int.Parse(context.Request["Sid"].ToString());
            DataTable dt = BLL.SchooInfo_BLL.SchoolIdQuery(Sid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        /// 根据校区代码，修改学校
        /// </summary>
        /// <param name="context"></param>
        public void btnSchoolUpdate(HttpContext context)
        {
           string Code=context.Request["Code"].ToString();
           string Name= context.Request["Name"].ToString();
           string Remark= context.Request["Remark"].ToString();
            int  Sid =int.Parse( context.Request["sid"].ToString());
            int Pid = int.Parse(context.Request["Pid"].ToString());
            SchoolsInfo S = new SchoolsInfo();
            S.School_Code = Code;
            S.School_ID = Sid;
            S.School_Name = Name;
            S.School_Remark = Remark;
            S.P_ID = Pid;
            bool b = BLL.SchooInfo_BLL.SchoolidUpdate(S);
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
        /// 添加学校
        /// </summary>
        /// <param name="context"></param>
        public void btnSchoolAdd(HttpContext context)
        {
            string Code = context.Request["Code"].ToString();
            string Name = context.Request["Name"].ToString();
            string Remark = context.Request["Remark"].ToString();
            int Pid = int.Parse(context.Request["Pid"].ToString());

            SchoolsInfo S = new SchoolsInfo();
            S.School_Code = Code;
            S.P_ID = Pid;
            S.School_Name = Name;
            S.School_Remark = Remark;
            bool b = BLL.SchooInfo_BLL.SchoolidAdd(S);
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
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}