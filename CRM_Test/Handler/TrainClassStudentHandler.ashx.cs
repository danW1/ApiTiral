using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Newtonsoft.Json;

namespace CRM_Test.Handler
{
    /// <summary>
    /// TrainClassStudentHandler 的摘要说明
    /// </summary>
    public class TrainClassStudentHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Method = context.Request["Method"].ToString();
            switch (Method)
            {
                case "PrivicesQuery":     //查询所有省份信息
                    PrivicesQuery(context);
                    break;
                case "StudentSQueryd":  //查询所有校区信息
                    StudentSQueryd(context);
                    break;
                case "SchoolClassQuery":  //查询所有班级信息
                    SchoolClassQuery(context);
                    break;
                case "StationsQuery":  //显示所有岗位
                    StationsQuery(context);
                    break;
                case "TrainClassStudentQuery":  //查询所有分班管理信息
                    TrainClassStudentQuery(context);
                    break;
                case "TrainClass":  //查询所有实训班级信息
                    TrainClass(context);
                    break;
                case "TrainClassQuery":  //根据学生所在实训班级查询实训班级信息
                    TrainClassQuery(context);
                    break;
                case "StudentClassUpdate":  //根据学生编号修改班级
                    StudentClassUpdate(context);
                    break;
                case "StudenUpdate":  //根据学生编号分班级
                    StudenUpdate(context);
                    break;
                    


            }

            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }

        //查询所有省份信息
        public void PrivicesQuery(HttpContext context)
        {
            DataTable dt = BLL.TrainClassStudent_BLL.ProvincesQuery();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        //查询所有校区信息
        public void StudentSQueryd(HttpContext context)
        {
            int P_id = 0;
            try
            {
                P_id = int.Parse(context.Request["P_id"].ToString());
            }
            catch (Exception)
            {
                
                throw;
            }
            DataTable dt = BLL.TrainClassStudent_BLL.SchoolsQuery(P_id);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        //查询所有班级信息
        public void SchoolClassQuery(HttpContext context)
        {
            int S_id = 0;
            try
            {
                S_id = int.Parse(context.Request["S_id"].ToString());
            }
            catch (Exception)
            {
              
                throw;
            }
            DataTable dt = BLL.TrainClassStudent_BLL.SchoolsClassQuery(S_id);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        //显示所有岗位
        public void StationsQuery(HttpContext context)
        {
          
            DataTable dt = BLL.TrainClassStudent_BLL.StationsQuery();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        
        //查询所有分班管理信息
        public void TrainClassStudentQuery(HttpContext context)
        {
            int P_id = 0, S_id = 0, Scid = 0, Stionid = 0;

            int classstu = int.Parse(context.Request["classstu"].ToString());
            try
            {
                 P_id = int.Parse(context.Request["P_id"].ToString());
                  S_id = int.Parse(context.Request["S_id"].ToString());
                  Scid = int.Parse(context.Request["Scid"].ToString());
                  Stionid = int.Parse(context.Request["Stionid"].ToString());
            }
            catch 
            {
            }
             DataTable dt = BLL.TrainClassStudent_BLL.TrainClassStudentQuery(classstu,P_id, S_id, Scid, Stionid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        //查询所有分班管理信息
        public void TrainClass(HttpContext context)
        {
            DataTable dt = BLL.TrainClassStudent_BLL.TrainClass();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        /// 根据学生所在实训班级查询实训班级信息
        /// </summary>
        /// <param name="context"></param>
        public void TrainClassQuery(HttpContext context)
        {
            int tcid = 0;

            try
            {
                tcid = int.Parse(context.Request["tcid"].ToString());
            }
            catch 
            {

            }
            DataTable dt = BLL.TrainClassStudent_BLL.TrainClassQquery(tcid);
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }

        //根据学生编号修改班级
        public void StudentClassUpdate(HttpContext context)
        {
            int tcidh = 0;
           int  Tcid = int.Parse(context.Request["Tcid"].ToString());
            int Sid = int.Parse(context.Request["Sid"].ToString());
            
            try
            {
                tcidh = int.Parse(context.Request["tcidh"].ToString());
               
            }
            catch
            {
            }
            bool b = BLL.TrainClassStudent_BLL.StudentctClassUpdate(tcidh,Tcid, Sid);
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

        //根据学生编号分班级
        public void StudenUpdate(HttpContext context)
        {
            int Tcid = 0;
            try
            {
                Tcid = int.Parse(context.Request["Tcid"].ToString());
            }
            catch (Exception)
            {

                throw;
            }
            string[] Student_ID = context.Request["Stuid"].ToString().Split(';');
            //定义一个  传递的sql语句
            string sql = "";
            string sqldel = "";
            //循环 给sql中传递参数
            foreach (string item in Student_ID)
            {
                if (item != "")
                {
                    sqldel += " delete from TrainClassStudents where Student_ID=" + item + ";";
                    sql += " select " + item + "," + Tcid + ",null,null union ";
                }
            }
            sql = sql.Substring(0, sql.Length - 6);


            int i = BLL.TrainClassStudent_BLL.StudentClassUpdate(sqldel,sql );
            string json = JsonConvert.SerializeObject(i);
            context.Response.Write(json);
            //string sql = "";
            //if (num.Length > 0)
            //{
            //    if (num[0].ToString() != "")
            //    {
            //        for (int i = 0; i < num.Length; i++)
            //        {
            //            sql += "select " + num[i] + "," +Tcid + "," + null + ","+true+" union ";
            //        }
            //        sql = sql.Substring(0, sql.Length - 6);
            //    }
            //    else
            //    {
            //        sql += "select  snull ," + Tcid + "," + null + "," + true +"" ;
            //    }

            //}
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