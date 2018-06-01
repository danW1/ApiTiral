using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Newtonsoft.Json;

namespace CRM_Test.Handler
{
    /// <summary>
    /// OperationLogsHandler 的摘要说明
    /// </summary>
    public class OperationLogsHandler : IHttpHandler
    {



        public void ProcessRequest(HttpContext context)
        {
            string Method = context.Request["Method"].ToString();
            switch (Method)
            {
                case "OperationLogsQuery":  // 查询所有所有用户操作日志
                    OperationLogsQuery(context);
                    break;
                case "OperaQuery":  // 查询所有教师操作日志
                    OperaQuery(context);
                    break;
                    
            }
        }



        /// <summary>
        /// 查询所有所有用户操作日志
        /// </summary>
        /// <returns></returns>
        public void OperationLogsQuery(HttpContext context)
        { 
            string TName = context.Request["TName"].ToString();
            string T_id = context.Request["T_id"].ToString();
            string TtdateDateK = context.Request["TtdateDateK"].ToString();
            string TdateDateaj = context.Request["TdateDateaj"].ToString();
            DataTable dt = BLL.OperationLogs_BLL.OperationLogsQuery(TName, T_id, TtdateDateK, TdateDateaj);
            string json = JsonConvert.SerializeObject(dt);
            //context.Response.ContentType = "text/plain";
            context.Response.Write(json);
        }

        /// <summary>
        ///查询所有教师操作日志
        /// </summary>
        /// <returns></returns>
        public void OperaQuery(HttpContext context)
        {
            DataTable dt =BLL.OperationLogs_BLL.OperatQuery();
            string json = JsonConvert.SerializeObject(dt);
            //context.Response.ContentType = "text/plain";
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