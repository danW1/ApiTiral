using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using System.Data.SqlClient;

namespace DAL
{
    /// <summary>
    /// 省份，数据访问层
    /// </summary>
   public  class Provinces_DAL
    {
        /// <summary>
        /// 显示所有省份信息
        /// </summary>
        /// <param name="P"></param>
        /// <returns></returns>
        public static DataTable ProvinceQuery( string PName)
        {
            string Wherejiao = "";
            if (PName != "" || PName != null)
            {
                Wherejiao += "and P_Name like '%"+ PName + "%'";
            }
            string sql =string.Format( "select * from Provinces where 1=1 "+ Wherejiao);
            DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;


        }

        /// <summary>
        /// 根据省份编号查询所有校区信息
        /// </summary>
        /// <param name="Pid"></param>
        /// <returns></returns>
        public static DataTable ProvincePid(int Pid ,string School_Code, string School_Name)
        {
            string WhereJia = "";
        
            if (School_Code != null || School_Code != "")
            {
                WhereJia += "   and School_Code like '%" + School_Code + "%' ";
            }
            if (School_Name != null || School_Name != "")
            {
                WhereJia += "    and School_Name like '%" + School_Name + "%'";
            }
            string sql = "select School_ID, School_Code,School_Name,School_Remark from Schools inner join Provinces on Schools.P_ID = Provinces.P_ID where Provinces.P_ID = @P_ID " + WhereJia;
            SqlParameter[] para = {
               new SqlParameter ("P_ID",Pid),
                new SqlParameter ("School_Code",School_Code),
                new SqlParameter ("School_Name",School_Name)
            };
            DataTable dt = DBHelper.GetDataTable(sql, para);
            return dt;
        }
        /// <summary>
        /// 根据校区编号查询所有校区信息
        /// </summary>
        /// <param name="Pid"></param>
        /// <returns></returns>
        public static DataTable ProvinceSid(int Pid ,string School_Code, string School_Name)
        {
            string WhereJia = "";
           
            if (School_Code != null || School_Code != "")
            {
                WhereJia += "   and School_Code like '%" + School_Code + "%' ";
            }
            if (School_Name != null || School_Name != "")
            {
                WhereJia += "    and School_Name like '%" + School_Name + "%'";
            }
            string sql = "select School_ID, School_Code,School_Name,School_Remark from Schools inner join Provinces on Schools.P_ID = Provinces.P_ID where Provinces.P_ID = @P_ID  " + WhereJia;
            SqlParameter[] para = {
               
                new SqlParameter ("School_Code",School_Code),
                new SqlParameter ("School_Name",School_Name)
            };
            DataTable dt = DBHelper.GetDataTable(sql, para);
            return dt;
        }
    }
}
 