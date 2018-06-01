using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class Provinces_BLL
    {
      
        /// 显示所有省份信息
        /// </summary>
        /// <param name="P"></param>
        /// <returns></returns>
        public static DataTable ProvinceQuery(string PName)
        {
            return DAL.Provinces_DAL.ProvinceQuery(PName);
        }


        /// <summary>
        /// 根据省份编号查询所有校区信息
        /// </summary>
        /// <param name="Pid"></param>
        /// <returns></returns>
        public static DataTable ProvincePid(int Pid, string School_Code, string School_Name)
        {
            return DAL.Provinces_DAL.ProvincePid(Pid, School_Code, School_Name);
        }
        /// <summary>
        /// 根据校区编号查询所有校区信息
        /// </summary>
        /// <param name="Pid"></param>
        /// <returns></returns>
        public static DataTable ProvinceSid(int Pid, string School_Code, string School_Name)
        {
            return DAL.Provinces_DAL.ProvinceSid(Pid,School_Code, School_Name);
        }
    }
}
