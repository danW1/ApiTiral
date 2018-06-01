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
    public  class TrainClass_DAL
    {
        /// <summary>
        /// 查询所有实训班级信息
        /// </summary>
        /// <param name="T_Name"></param>
        /// <param name="T_Category"></param>
        /// <returns></returns>
        public static DataTable TrainClassQuery(string T_Name,int T_id)
        {
            string whereJIao = "";
            if ( T_Name != "")
            {
                whereJIao += "   and TC_Name like '%"+ T_Name + "%'";
            }
            if(T_id != 0)
            {
                whereJIao += "   and T_ID ="+ T_id;
            }
          
                string sql = "   select * from stu_TeacherQURY where 1=1" + whereJIao;
                DataTable dt = DBHelper.GetDataTable(sql, null);
                return dt;
           
        }
        /// <summary>
        /// 根据教师身份查询教师姓名
        /// </summary>
        /// <param name="Category"></param>
        /// <returns></returns>
        public static DataTable TraintCategory(int Category)
        {
            string sql = "select * from Teachers where T_Category=@T_Category";
            SqlParameter[] para = {
                new SqlParameter ("T_Category",Category)
            };
            DataTable dt = DBHelper.GetDataTable(sql, para);
            return dt;

        }
        /// <summary>
        /// 根据班级编号删除数据
        /// </summary>
        /// <param name="Tc_id"></param>
        /// <returns></returns>
        public static bool TrainClassDELETE(int Tc_id)
        {
            string sql = "delete from  TrainClassStudents where TC_ID=@TC_ID;delete from  TrainClassTeachers where TC_ID=@TC_ID;delete from  TrainClasses where TC_ID=@TC_ID";
            SqlParameter[] para = {
                new SqlParameter ("TC_ID",Tc_id)
            };
            int i = DBHelper.ExecuteNonQuery(sql,para);
            if (i > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        /// <summary>
        /// 新增一个实训班级信息
        /// </summary>
        /// <param name="T"></param>
        /// <param name="C"></param>
        /// <returns></returns>
        public static bool TeacherClassAdd(TrainClassesInfo T,int jyid,int ddid)
        {
            string sql = "insert into TrainClasses(TC_Name, TC_Grade, TC_BeginTime,TC_EndTime, TC_MaxAmount, TC_MaleAmount, TC_FemaleAmount, TC_Period)values(@TC_Name, @TC_Grade, @TC_BeginTime, @TC_EndTime, @TC_MaxAmount, '4', '1',@TC_Period); select @@IDENTITY as id;";
            SqlParameter[] para = {
                new SqlParameter ("TC_Name",T.TC_Name),
                new SqlParameter ("TC_Grade",T.TC_Grade),
                new SqlParameter ("TC_BeginTime",T.TC_BeginTime),
                new SqlParameter ("TC_EndTime",T.TC_EndTime),
                new SqlParameter ("TC_MaxAmount",T.TC_MaxAmount),
                new SqlParameter ("TC_Period",T.TC_Period)
                //new SqlParameter ("T_ID",C.T_ID)
            };
            DataTable dt = DBHelper.GetDataTable(sql, para);

            string strSql = "insert into TrainClassTeachers ";
            //如果jyid，ddid不等于0时执行sql语句，可以同时追加两条
            if (jyid != 0)
            {
                strSql += "select " + dt.Rows[0][0] + "," + jyid + " union ";
            }
            if(ddid!=0)
            {
                strSql += " select " + dt.Rows[0][0] + "," + ddid + " union ";

            }
            strSql = strSql.Substring(0, strSql.Length - 6);//去掉最后一个union(union)的字段为6
            int i = DBHelper.ExecuteNonQuery(strSql, null);
            if (i > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        /// <summary>
        /// 通过班级编号获取信息
        /// </summary>
        /// <param name="Tc_id"></param>
        /// <returns></returns>
        public static DataTable TeacherqueryTcid(int Tc_id)
        {
            //string sql = " SELECT  * FROM dbo.TrainClasses where TC_ID=@TC_ID";
           string sql = "  select * from stu_TeacherQURY where TC_ID=@TC_ID";
            SqlParameter[] para = {
                new SqlParameter ("TC_ID",Tc_id)
            };
            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;

        }
        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="T"></param>
        /// <param name="jyid"></param>
        /// <param name="ddid"></param>
        /// <param name="T_id"></param>
        /// <returns></returns>
        public static bool TeacherUpdate(TrainClassesInfo T, int jyid, int ddid)
        {
            int T_ID;
            if (jyid != 0)
            {
                T_ID = jyid;
            }
            else
            {
                T_ID = ddid;
            }
            string sql = "update TrainClasses set TC_Name=@TC_Name,TC_Grade=@TC_Grade,TC_BeginTime=@TC_BeginTime,TC_EndTime=@TC_EndTime,TC_MaxAmount=@TC_MaxAmount,TC_Period=@TC_Period where TC_ID=@TC_ID;delete from TrainClassTeachers where TC_ID=@TC_ID and T_ID=@T_ID;insert into TrainClassTeachers(TC_ID,T_ID)values(@TC_ID,@T_ID)";
            SqlParameter[] para = {
                new SqlParameter ("TC_Name",T.TC_Name),
                new SqlParameter ("TC_Grade",T.TC_Grade),
                new SqlParameter ("TC_BeginTime",T.TC_BeginTime),
                new SqlParameter ("TC_EndTime",T.TC_EndTime),
                new SqlParameter ("TC_MaxAmount",T.TC_MaxAmount),
                new SqlParameter ("TC_Period",T.TC_Period),
                new SqlParameter ("TC_ID",T.TC_ID),
                new SqlParameter ("T_ID",T_ID)
          
            };
            int  dt = DBHelper.ExecuteNonQuery (sql, para);
            if (dt > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
