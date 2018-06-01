using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Newtonsoft.Json;

namespace CRM_Test.Handler
{
    /// <summary>
    /// SetClassHandler 的摘要说明
    /// </summary>
    public class SetClassHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Method = context.Request["Method"].ToString();
            switch (Method)
            {
                case "TeacherQuery":  // 查询所有老师信息
                    TeacherQuery(context);
                    break;
                case "ClassQueryss":  // 查询所带实训班级信息
                    ClassQueryss(context);
                    break;
                case "StationAdd":  // 根据班级编号添加
                    StationAdd(context);
                    break;
                    


            }
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }
        /// <summary>
        /// 查询所有老师信息
        /// </summary>
        /// <param name="context"></param>
        public void TeacherQuery(HttpContext context)
        {
            string T_Name = context.Request["T_Name"].ToString();
            int Tid =int.Parse( context.Request["T_id"].ToString());
            DataTable dt = BLL.SetClassTeacher_BLL.TeacherQuery(T_Name, Tid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        /// 查询所带实训班级信息
        /// </summary>
        /// <param name="context"></param>
        public void ClassQueryss(HttpContext context)
        {
           
            int Classn=int.Parse(context.Request["Class"].ToString());
            int Category = int.Parse(context.Request["Category"].ToString());
            int T_id = int.Parse(context.Request["T_id"].ToString());
            DataTable dt = BLL.SetClassTeacher_BLL.ClassQuery(Classn, Category, T_id);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        /// <summary>
        /// 根据实训班级编号参加
        /// </summary>
        /// <param name="context"></param>
        public void StationAdd(HttpContext context)
        {
            int T_id = int.Parse(context.Request["T_id"].ToString());
          
            int T_Category = int.Parse(context.Request["T_Category"].ToString());
            string str = context.Request["strr"].ToString();
            string[] num = str.Split(';');//转化为一个数组
            string sql = "";
            if (num.Length > 0)
            {
                if (num[0].ToString() != "")
                {
                    for (int i = 0; i < num.Length; i++)
                    {
                        sql += "select   " + num[i] + " , " + T_id + "union ";
                    }
                    sql = sql.Substring(0, sql.Length - 6);
                }
                else
                {
                    sql += "select   " + T_id + ",null";
                }

            }
            bool bo = BLL.SetClassTeacher_BLL.ClassAdd(num, T_Category, T_id,sql);
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
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}