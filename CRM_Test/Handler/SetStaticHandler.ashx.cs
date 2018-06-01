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
    /// SetStaticHandler 的摘要说明
    /// </summary>
    public class SetStaticHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Method = context.Request["Method"].ToString();
            switch (Method)
            {
                case "Schoolquery":  // 查询所有学校信息
                    Schoolquery(context);
                    break;
                case "SchQuery":    //根据校区编号查询所有专业信息
                    SchQuery(context);
                    break;
                case "StdQuery":    //查询所有岗位信息
                    StdQuery(context);
                    break;
                case "StationAdd":    //向专业岗位添加数据
                    StationAdd(context);
                    break;
                case "StationsQuery":  // 查询单选按钮的事件
                    StationsQuery(context);
                    break;

                    

            }
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }
        /// <summary>
        /// 查询所有学校信息
        /// </summary>
        /// <param name="context"></param>
        public void Schoolquery(HttpContext context)
        {
            string Scode = context.Request["Scode"].ToString();
            string Sname = context.Request["Sname"].ToString();
            DataTable dt = BLL.SetStatic_BLL.SetSchollQuery(Scode, Sname);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);

        }
        /// <summary>
        /// //根据校区编号查询所有专业信息
        /// </summary>
        /// <param name="context"></param>
        public void SchQuery(HttpContext context)
        {
            int Sid = int.Parse( context.Request["Sid"].ToString());
            DataTable dt = BLL.SetStatic_BLL.SchoolidQuery(Sid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);

        }

        /// <summary>
        /// //根据校区编号查询所有专业信息
        /// </summary>
        /// <param name="context"></param>
        public void StdQuery(HttpContext context)
        {
            DataTable dt = BLL.SetStatic_BLL.StationsQuery();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);

        }
        /// <summary>
        /// //向专业岗位添加数据
        /// </summary>
        /// <param name="context"></param>
        public void StationAdd(HttpContext context)
        {
            int sid = int.Parse(context.Request["Sid"]);
            int zid = int.Parse(context.Request["Zid"]);
            string str = context.Request["strr"].ToString();
            string[] num = str.Split(';');//转化为一个数组
            string sql = "";
            if (num.Length > 0)
            {
                if (num[0].ToString() != "")
                {
                    for (int i = 0; i < num.Length; i++)
                    {
                        sql += "select " + zid + "," + num[i] + "," + sid + " union ";
                    }
                    sql = sql.Substring(0, sql.Length - 6);
                }
                else
                {
                  sql += "select " + zid + ",null," + sid + "";
                }

            }
            bool bo = BLL.SetStatic_BLL.SpecialtyStation(sid, zid, sql);
            string a = "";
            if (bo)
            {
                a = "1";
            }
            else
            {
                a = "0";
            }
            string json = JsonConvert.SerializeObject(a);
            context.Response.Write(json);

        }

        /// <summary>
        /// 查询单选按钮的事件
        /// </summary>
        /// <param name="context"></param>
        public void StationsQuery(HttpContext context)
        {
            int  Sid =int.Parse( context.Request["Sid"].ToString());
            int Zid = int.Parse(context.Request["Zid"].ToString());
            int S= int.Parse(context.Request["S"].ToString());
            DataTable dt = BLL.SetStatic_BLL.StationSchool1(Sid, Zid, S);
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