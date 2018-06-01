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
    /// StaticHandler 的摘要说明
    /// </summary>
    public class StaticHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Method = context.Request["Method"].ToString();
            switch (Method)
            {
                case "StaticQuery":   //根据专业名称模糊查询所有岗位信息
                    StaticQuery(context);
                    break;
                case "StaticUpdateQuery":    //根据编号查询所有岗位信息
                    StaticUpdateQuery(context);
                    break;
                case "StaticSUpdate":    //根据编号修改岗位信息
                    StaticSUpdate(context);
                    break;
                case "StaticSAdd":    //根据编号修改岗位信息
                    StaticSAdd(context);
                    break;
                case "StaticDelete":    //根据编号修改岗位信息
                    StaticDelete(context);
                    break;
                    


            }

            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }
        /// <summary>
        /// 根据专业名称模糊查询所有岗位信息
        /// </summary>
        /// <param name="context"></param>
        public void StaticQuery(HttpContext context)
        {
            string Sname = context.Request["Sname"].ToString();
            DataTable dt = BLL.Static_BLL.StaticQuery(Sname);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);

        }
        //根据编号查询所有岗位信息
        public void StaticUpdateQuery(HttpContext context)
        {
            int Sid =int.Parse( context.Request["Sid"].ToString());
            DataTable dt = BLL.Static_BLL.StaticUpdataQuery(Sid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);

        }

        //根据编号修改专业信息
        public void StaticSUpdate(HttpContext context)
        {
            int Sid= int.Parse(context.Request["Sid"].ToString());
            string Sname = context.Request["Sname"].ToString();
            string SDuty = context.Request["SDuty"].ToString();
            string STeachnique = context.Request["STeachnique"].ToString();
            StationsInfo s = new StationsInfo();
            s.Station_ID = Sid;
            s.Station_Name = Sname;
            s.Station_Duty = SDuty;
            s.Station_NeedTechnique = STeachnique;
            bool b = BLL.Static_BLL.StaticUpdata(s);
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


        //根据编号新增信息
        public void StaticSAdd(HttpContext context)
        {
            string Sname = context.Request["Sname"].ToString();
            string SDuty = context.Request["SDuty"].ToString();
            string STeachnique = context.Request["STeachnique"].ToString();
            StationsInfo s = new StationsInfo();
            s.Station_Name = Sname;
            s.Station_Duty = SDuty;
            s.Station_NeedTechnique = STeachnique;
            bool b = BLL.Static_BLL.StaticAdd(s);
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


        //根据编号删除信息
        public void StaticDelete(HttpContext context)
        {
            int Sid =int.Parse( context.Request["Sid"].ToString());
           
            bool b = BLL.Static_BLL.StaticDelete(Sid);
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