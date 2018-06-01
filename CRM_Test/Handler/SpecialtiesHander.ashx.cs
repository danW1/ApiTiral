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
    /// Specialties 的摘要说明
    /// </summary>
    public class Specialties : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Method = context.Request["Method"].ToString();
            switch (Method)
            {
                case "SpecialtQuery":
                    SpecialtQuery(context);
                    break;
                case "SpUpdateQuery":   //修改时获取值
                    SpUpdateQuery(context);
                    break;
                    
               case "SpUpdate":   //修改专业表内容
                    SpUpdate(context);
                    break;
                case "SpecialAdd":   //添加专业表内容
                    SpecialAdd(context);
                    break;
                case "SpDelete":   //添加专业表内容
                    SpDelete(context);
                    break;
                    
            }
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }
        /// <summary>
        /// 查询所有专业信息
        /// </summary>
        /// <param name="context"></param>
        public void SpecialtQuery(HttpContext context)
        {
            DataTable dt = BLL.Specialties_BLL.SpecialQuery();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        /// 修改时获取值
        /// </summary>
        /// <param name="context"></param>
        public void SpUpdateQuery(HttpContext context)
        {
            int Sid = int.Parse(context.Request["Sid"].ToString());
            DataTable dt = BLL.Specialties_BLL.SpecialUpdateQuery(Sid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        /// 修改专业信息
        /// </summary>
        /// <param name="context"></param>
        public void SpUpdate(HttpContext context)
        {
           
            int Spid =int.Parse( context.Request["Spid"].ToString());
            string Sption = context.Request["Sption"].ToString();
            string SpName = context.Request["SpName"].ToString();

            SpecialtiesInfo S = new SpecialtiesInfo();
            S.Specialty_ID = Spid;
            S.Specialty_Name = SpName;
            S.Specialty_Description = Sption;

            bool b = BLL.Specialties_BLL.SpecialUpdate(S);
            string s = "";
            if (b)
            {
                s = "1";
            }
            else
            {
                s = "0";
            }

            string json = JsonConvert.SerializeObject(s);
            context.Response.Write(json);
        }


        /// <summary>
        /// 修改专业信息
        /// </summary>
        /// <param name="context"></param>
        public void SpecialAdd(HttpContext context)
        {
            string Sption = context.Request["Sption"].ToString();
            string SpName = context.Request["SpName"].ToString();

            SpecialtiesInfo S = new SpecialtiesInfo();
            S.Specialty_Name = SpName;
            S.Specialty_Description = Sption;

            bool b = BLL.Specialties_BLL.SpecialAdd(S);
            string s = "";
            if (b)
            {
                s = "1";
            }
            else
            {
                s = "0";
            }

            string json = JsonConvert.SerializeObject(s);
            context.Response.Write(json);
        }

        /// <summary>
        /// 删除专业信息
        /// </summary>
        /// <param name="context"></param>
        public void SpDelete(HttpContext context)
        {
            int Sid =int.Parse( context.Request["Spid"].ToString());
            bool b = BLL.Specialties_BLL.SpecialDelete(Sid);
            string s = "";
            if (b)
            {
                s = "1";
            }
            else
            {
                s = "0";
            }

            string json = JsonConvert.SerializeObject(s);
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