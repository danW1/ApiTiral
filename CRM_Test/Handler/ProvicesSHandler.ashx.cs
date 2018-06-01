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
    /// PrivicesHandler 的摘要说明
    /// </summary>
    public class PrivicesHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Method = context.Request["Method"].ToString();
            switch (Method)
            {
                case "ProviceQuery":   //学校和省的连接查询
                    ProviceQuery(context);
                    break;

                    
               case "ProeQuery":   // //学校和省的连接查询
                    ProeQuery(context);
                    break;
                case "provice":   // //根据省份ID查询所在其省份的学校
                    provice(context);
                    break;
                case "StationPeriodsShoolID":   //通过校区ID查询选岗周期表（三表连接查询）
                    StationPeriodsShoolID(context);
                    break;
                case "SpecialtiesQ":   //查询所有专业信息
                    SpecialtiesQ(context);
                    break;
                    
                case "SchoolAdduery":   //添加选岗宣讲
                    SchoolAdduery(context);
                    break;

            }
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }
        /// <summary>
        /// 学校和省的连接查询
        /// </summary>
        /// <param name="context"></param>
        public void ProviceQuery(HttpContext context)
        {
            int  PName =0;
            int Sid = 0;
            try
            {
                PName = int.Parse(context.Request["PName"].ToString());
                Sid = int.Parse(context.Request["Sid"].ToString());
            }
            catch 
            {
            }
            DataTable dt = BLL.ProviceS_BLL.ProvicesQueryS(PName, Sid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);

        }

        /// <summary>
        ///查询所有省份信息
        /// </summary>
        /// <param name="context"></param>
        public void ProeQuery(HttpContext context)
        {
            DataTable dt = BLL.ProviceS_BLL.ProvicesQuery();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        ///根据省份ID查询所在其省份的学校
        /// </summary>
        /// <param name="context"></param>
        public void provice(HttpContext context)
        {
            int Pid =int.Parse( context.Request["Pid"].ToString());
            DataTable dt = BLL.ProviceS_BLL.Provice(Pid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        ///根据校区ID查询选岗设置表
        /// </summary>
        /// <param name="context"></param>
        public void StationPeriodsShoolID(HttpContext context)
        {
            int Sid = int.Parse(context.Request["Sid"].ToString());
            DataTable dt = BLL.ProviceS_BLL.StationPeriodsQuery(Sid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        ///查询所有专业信息
        /// </summary>
        /// <param name="context"></param>
        public void SpecialtiesQ(HttpContext context)
        {
            DataTable dt = BLL.ProviceS_BLL.SpecialtiesQUery();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
       //添加选岗宣讲
        public void SchoolAdduery(HttpContext context)
        {
            int Sid = int.Parse(context.Request["Sid"].ToString());
            int Spid= int.Parse(context.Request["Spid"].ToString());
           string PreachDate =context.Request["PreachDate"].ToString();
            string OverDay = context.Request["OverDay"].ToString();

            SelectStationPeriodsInfo S = new SelectStationPeriodsInfo();
            S.School_ID = Sid;
            S.Specialty_ID = Spid;
            S.SSP_PreachDate = PreachDate;
            S.SSP_OverDay = OverDay;
            string str = "";
            bool b = BLL.ProviceS_BLL.SchoolAdduery(S);
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