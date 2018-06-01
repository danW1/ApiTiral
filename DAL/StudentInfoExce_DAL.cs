using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
namespace DAL
{
   public  class StudentInfoExce_DAL
    {
        /// <summary>
        /// 查看所有实训班级信息
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static DataTable ClassQuery(string dateTime)
        {
            string whereJia = "";
            if (dateTime != "")
            {
                whereJia += "   and TC_BeginTime='"+ dateTime + "'";
            }
            string sql = "select * from TrainClasses where 1=1"+whereJia;
           DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;
        }

        /// <summary>
        /// 根据班级编号查询所有班级信息
        /// </summary>
        /// <param name="Tc_id"></param>
        /// <returns></returns>
        public static DataTable StudentQueryeexcel(int Tc_id)
        {
            string sql = "select * from Students d inner join (select a.Student_ID, b.TC_ID from TrainClassStudents a,TrainClasses b where a.TC_ID=b.TC_ID)c on c.Student_ID=d.Student_ID and TC_ID=@TC_ID";
            SqlParameter[] para = {
                new SqlParameter ("TC_ID",Tc_id)
            };
            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;
        }
    }
}
