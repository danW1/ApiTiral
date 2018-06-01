using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public class StudentInfoExce_BLL
    {
        /// <summary>
        /// 查看所有实训班级信息
        /// </summary>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static DataTable ClassQuery(string dateTime)
        {
            return DAL.StudentInfoExce_DAL.ClassQuery(dateTime);
        }

        /// <summary>
        /// 根据班级编号查询所有班级信息
        /// </summary>
        /// <param name="Tc_id"></param>
        /// <returns></returns>
        public static DataTable StudentQueryeexcel(int Tc_id)
        {
            return DAL.StudentInfoExce_DAL.StudentQueryeexcel(Tc_id);
        }
    }
}
