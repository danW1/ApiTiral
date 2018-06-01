using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
namespace DAL
{
   public  class OperationLogs_DAL
    {
        /// <summary>
        /// 查询所有所有用户操作日志
        /// </summary>
        /// <returns></returns>
        public static DataTable OperationLogsQuery(string T_Name,string PL_Operation,string  PL_Timee ,string PL_Time)
        {
            string whereJiao = "";
            if (T_Name != "")
            {
                whereJiao += "  and T_Name like '%"+ T_Name + "%'";
            }
            if (PL_Operation !="0" )
            {
                whereJiao += "  and PL_ID =" + PL_Operation ;
            }
            if (PL_Timee != "" )
            {
                whereJiao += "  and PL_Time >='"+PL_Timee+"'";
            }
            if(PL_Time!="")
            {
                whereJiao += " and PL_Time <='"+PL_Time+"'";
            }
             

            string sql = "select * from Teachers a , OperationLogs b where a.T_ID=b.T_ID "+whereJiao;
            DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;
        }


        /// <summary>
        /// 查询所有教师操作日志
        /// </summary>
        /// <returns></returns>
        public static DataTable OperatQuery()
        {
            string sql = " select * from OperationLogs";
            DataTable dt = DBHelper.GetDataTable(sql, null);
            return dt;
        }

    }
}
