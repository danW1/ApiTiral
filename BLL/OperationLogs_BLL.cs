using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public class OperationLogs_BLL
    {
        /// <summary>
        /// 查询所有所有用户操作日志
        /// </summary>
        /// <returns></returns>
        public static DataTable OperationLogsQuery(string T_Name, string PL_Operation, string PL_Timee, string PL_Time)
        {
            return DAL.OperationLogs_DAL.OperationLogsQuery(T_Name, PL_Operation, PL_Timee, PL_Time);
        }


        /// <summary>
        /// 查询所有教师操作日志
        /// </summary>
        /// <returns></returns>
        public static DataTable OperatQuery()
        {
            return DAL.OperationLogs_DAL.OperatQuery();
        }
    }
}
