using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Model;
namespace DAL
{
   public class TrainClassStudent_DAL
    {

        /// <summary>
        /// 查询所有省份信息
        /// </summary>
        /// <returns></returns>
        public static DataTable ProvincesQuery()
        {
            string sql = " select * from Provinces";
            DataTable dt = DBHelper.GetDataTable(sql, null);
            return dt;
        }

        /// <summary>
        /// 查询所有校区信息
        /// </summary>
        /// <returns></returns>
        public static DataTable SchoolsQuery(int P_id)
        {
            string sql = "  select * from Provinces a,Schools b where b.P_ID=a.P_ID and b.P_ID=@P_ID";
            SqlParameter[] para = {
                new SqlParameter ("P_ID",P_id)
            };
            DataTable dt = DBHelper.GetDataTable(sql, para);
            return dt;
        }

        /// <summary>
        /// 根据校区编号查询班级信息
        /// </summary>
        /// <returns></returns>
        public static DataTable SchoolsClassQuery(int Sch_id)
        {
            string sql = " select * from Schools a, SchoolClasses b where a.School_ID=b.School_ID and a.School_ID=@School_ID";
            SqlParameter[] para = {
                new SqlParameter ("School_ID",Sch_id)
            };

            DataTable dt = DBHelper.GetDataTable(sql, para);
            return dt;
        }


        /// <summary>
        /// 显示所有岗位
        /// </summary>
        /// <returns></returns>
        public static DataTable StationsQuery()
        {
            string sql = " select * from Stations";
          
            DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;
        }

       /// <summary>
       /// 查询所有分班管理信息
       /// </summary>
       /// <returns></returns>
        public static DataTable TrainClassStudentQuery(int classstu,int P_id,int Sid,int Scid,int StionID )
        {
            string sql = "";
            string whereJoao = "";
            if (P_id != 0)
            {
                whereJoao += "  and P_ID = "+ P_id;
            }
            if (Sid != 0)
            {
                whereJoao += "  and School_ID ="+ Sid;
            }
            if (Scid != 0)
            {
                whereJoao += "  and SC_ID = " + Scid;
            }
            if (StionID != 0)
            {
                whereJoao += "  and Station_ID =" + StionID;
            }

            if (classstu == 1)  //未分班
            {
                sql = "select * from view_Stu where Student_ID not in(select Student_ID from TrainClassStudents) " + whereJoao;
            }
            else if (classstu == 2)  //已分班
            {
                sql = "select * from view_Stu where Student_ID in(select Student_ID from TrainClassStudents) " + whereJoao;
            }
            else  //全部
            {
                sql = "   select * from view_Stu  where 1=1" + whereJoao;
            }
            
            DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;
        }

        /// <summary>
        /// 查询所有实训班级信息
        /// </summary>
        /// <returns></returns>
        public static DataTable TrainClass()
        {
            string sql = "select b.TC_ID,b.TC_Name from TrainClassStudents a,TrainClasses b where a.TC_ID=b.TC_ID";
            DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;
        }

        /// <summary>
        /// 查询学生所在实训班级信息
        /// </summary>
        /// <returns></returns>
        public static DataTable TrainClassQquery(int Tcid)
        {
            string sql = "select * from TrainClassStudents a,TrainClasses b where a.TC_ID=b.TC_ID and a.TC_ID=@TC_ID" ;
            SqlParameter[] para = {
                new SqlParameter ("TC_ID",Tcid)
            };
            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;
        }

        /// <summary>
        /// 换班（根据学生编号修改班级）
        /// </summary>
        /// <param name="T"></param>
        /// <returns></returns>
        public static bool  StudentctClassUpdate(int tcidh,int Tcid,int Sid)
        {
            string sql;
            if (tcidh != 0)
            {
                sql = "update TrainClassStudents set TC_ID=@TC_ID where Student_ID=@Student_ID";
        
            }
            else
            {
                sql = "insert into TrainClassStudents(Student_ID,TC_ID,R_ID,Student_IsHasAllotRoom) values(@Student_ID,@TC_ID,null,'true')";

            }
            SqlParameter[] para = {
                     new SqlParameter ("TC_ID",Tcid),
                     new SqlParameter ("Student_ID",Sid),
                      };
            int i = DBHelper.ExecuteNonQuery(sql,para);
            if (i > 0)
            {
                return true;
            }
            else {
                return false;
            }
        }


        /// <summary>
        /// 分班（根据学生编号修改班级）
        /// </summary>
        /// <param name = "T" ></ param >
        /// < returns ></ returns >
        public static int StudentClassUpdate(string sqldel, string strsql)
        {
            //string sql = "delete from  TrainClassStudents where Student_ID=@Student_ID;insert into TrainClassStudents" + strsql;
            //定义一个添加语句
            string sql = "" + sqldel + "insert into TrainClassStudents " + strsql;
            return DBHelper.ExecuteNonQuery(sql, null);
        }

    }
}
