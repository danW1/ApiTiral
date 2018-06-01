using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
namespace DAL
{
    public class SetClassTeacher_DAL
    {
        /// <summary>
        /// 查询所有老师信息
        /// </summary>
        /// <returns></returns>
        public static DataTable TeacherQuery(string TName, int Tid)
        {
            string WhereJ = "";
            if (TName != "")
            {
                WhereJ += " and T_Name like '%" + TName + "%'";
            }
            if (Tid == 0 || Tid == 1)
            {
                WhereJ += " and T_Category=" + Tid;
            }

            string sql = "select* from Teachers a left join OperationLogs b on a.T_ID = b.T_ID  where 1=1" + WhereJ;
            DataTable dt = DBHelper.GetDataTable(sql, null);
            return dt;
        }

        /// <summary>
        /// 查询所带实训班级信息
        /// </summary>
        /// <param name="classid"></param>
        /// <param name="Category"></param>
        /// <returns></returns>
        public static DataTable ClassQuery(int classid,int Category,int T_id)
        {
            string sql = "";

            if (classid == 1)
            {
                sql = "select* from TrainClasses a where a.TC_ID not in (select a.TC_ID from TrainClassTeachers a, Teachers b where a.T_ID = b.T_ID and b.T_Category = @T_Category)";
            }
            else if (classid == 2)
            {
                sql = "select* from  TrainClasses d inner join (select a.TC_ID, b.T_ID, b.T_Category, b.T_Name from TrainClassTeachers a, Teachers b where a.T_ID = b.T_ID) c on d.TC_ID = c.TC_ID and c.T_ID =@T_ID and c.T_Category = @T_Category";

            }
            else
            {
                sql = "select* from  TrainClasses d left join (select a.TC_ID, b.T_ID, b.T_Category, b.T_Name from TrainClassTeachers a, Teachers b where a.T_ID = b.T_ID) c  on d.TC_ID = c.TC_ID";
            }

            SqlParameter[] para = {
                new SqlParameter ("T_Category",Category),
                 new SqlParameter ("T_ID",T_id)
            };

            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;
        }

        /// <summary>
        /// 根据班级编号参加
        /// </summary>
        /// <param name="Tc_id"></param>
        /// <param name="sqll"></param>
        /// <returns></returns>
        public static bool ClassAdd(string[]num,int Category,int T_id,string sqll)
        {
            int i = 0;
            for (int x = 0; x < num.Length; x++)
            {

            
            string sql = " delete TrainClassTeachers where TC_ID =@TC_ID and T_ID in (select a.T_ID from TrainClassTeachers a, Teachers b where a.T_ID = b.T_ID and b.T_Category = @T_Category and a.TC_ID =@TC_ID ); insert into TrainClassTeachers " + sqll;
            SqlParameter[] para = {
                new SqlParameter ("TC_ID",num[x]),
                 new SqlParameter ("T_Category",Category),
                   new SqlParameter ("T_ID",T_id)
            };

             i = DBHelper.ExecuteNonQuery(sql,para);
            }
            if (i > 0)
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
