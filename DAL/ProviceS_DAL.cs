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
    public class ProviceS_DAL
    {
        /// <summary>
        /// 学校和省的连接查询
        /// </summary>
        /// <param name="Pid"></param>
        /// <param name="School_Name"></param>
        /// <returns></returns>
        public static DataTable ProvicesQueryS(int  Pid, int School_ID)
        {
            string whereJi = "";

            if (Pid != 0)
            {
                whereJi += "  and Provinces.P_ID like'%" + Pid + "%' ";

            }
            if (School_ID != 0)
            {
                whereJi += " and School_ID like '%" + School_ID + "%'";
            }


            string sql = " select * from Schools , Provinces where Schools.P_ID = Provinces.P_ID and 1=1  " + whereJi;
            DataTable dt = DBHelper.GetDataTable(sql, null);
            return dt;
        }
        /// <summary>
        /// 查询省份信息
        /// </summary>
        /// <returns></returns>
        public static DataTable ProvicesQuery()
        {
            string sql = "  select * from Provinces";
            DataTable dt = DBHelper.GetDataTable(sql, null);
            return dt;

        }
        /// <summary>
        /// 根据省份ID查询所在其省份的学校
        /// </summary>
        /// <param name="P_id"></param>
        /// <returns></returns>
        public static DataTable Provice(int P_id)
        {
            string sql = " select * from Schools inner join Provinces on Schools.P_ID = Provinces.P_ID where 1 = 1 and Provinces.P_ID = @P_ID";
            SqlParameter[] para = {
                new SqlParameter ("P_ID",P_id)
            };
            DataTable dt = DBHelper.GetDataTable(sql, para);
            return dt;
        }

        /// <summary>
        /// 通过校区ID查询选岗周期表（三表连接查询）
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable StationPeriodsQuery(int Sid)
        {
            string sql = "SELECT  * FROM dbo.Schools INNER JOIN dbo.SelectStationPeriods ON dbo.Schools.School_ID = dbo.SelectStationPeriods.School_ID INNER JOIN dbo.Specialties ON dbo.SelectStationPeriods.Specialty_ID = dbo.Specialties.Specialty_ID where dbo.Schools.School_ID = @School_ID";
            SqlParameter[] para = {
                new SqlParameter ("School_ID",Sid)
            };
            DataTable dt = DBHelper.GetDataTable(sql, para);
            return dt;

        }
        /// <summary>
        /// 查询所有专业信息
        /// </summary>
        public static DataTable SpecialtiesQUery()
        {
            string sql = "select * from Specialties";
            DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;
        }
        /// <summary>
        /// 添加选岗信息
        /// </summary>
        public static bool  SchoolAdduery(SelectStationPeriodsInfo S)
        {
            string sql = "insert into SelectStationPeriods(School_ID,Specialty_ID,SSP_PreachDate,SSP_OverDay) values(@School_ID,@Specialty_ID,@SSP_PreachDate,@SSP_OverDay)";
            SqlParameter[] para = {
                new SqlParameter ("School_ID",S.School_ID),
                new SqlParameter ("Specialty_ID",S.Specialty_ID),
                new SqlParameter ("SSP_PreachDate",S.SSP_PreachDate),
                new SqlParameter ("SSP_OverDay",S.SSP_OverDay)
            };
           int dt = DBHelper.ExecuteNonQuery(sql,para);
          
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
