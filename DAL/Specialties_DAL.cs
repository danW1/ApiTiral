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
   public class Specialties_DAL
    {
        /// <summary>
        /// 查询所有专业
        /// </summary>
        /// <returns></returns>
        public static DataTable SpecialQuery()
        {
            string str = "select * from Specialties";
            DataTable dt = DBHelper.GetDataTable(str,null);
            return dt;
        }


        /// <summary>
        /// 修改时获取值
        /// </summary>
        /// <returns></returns>
        public static DataTable SpecialUpdateQuery(int  Sid)
        {
            string str = "select * from Specialties where Specialty_ID=@Specialty_ID";
            SqlParameter[] para = {
                new SqlParameter ("Specialty_ID",Sid)
            };
            DataTable dt = DBHelper.GetDataTable(str,para);
            return dt;
        }

        /// <summary>
        /// 修改专业表内容
        /// </summary>
        /// <param name="S"></param>
        /// <returns></returns>
        public static bool SpecialUpdate(SpecialtiesInfo S)
        {
            try
            {
                String sql = "update Specialties set Specialty_Name=@Specialty_Name,Specialty_Description=@Specialty_Description  where Specialty_ID=@Specialty_ID";
                SqlParameter[] para = {
                new SqlParameter ("Specialty_Name",S.Specialty_Name),
                new SqlParameter ("Specialty_Description",S.Specialty_Description),
                new SqlParameter ("Specialty_ID",S.Specialty_ID)
            };
                int i = DBHelper.ExecuteNonQuery(sql, para);
                if (i > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch 
            {
                return false;
            }
        }

        /// <summary>
        /// 添加专业表内容
        /// </summary>
        /// <param name="S"></param>
        /// <returns></returns>
        public static bool SpecialAdd(SpecialtiesInfo S)
        {
            try
            {
                String sql = "insert into Specialties(Specialty_Name,Specialty_Description) values(@Specialty_Name,@Specialty_Description)";
                SqlParameter[] para = {
                new SqlParameter ("Specialty_Name",S.Specialty_Name),
                new SqlParameter ("Specialty_Description",S.Specialty_Description),
            };
                int i = DBHelper.ExecuteNonQuery(sql, para);
                if (i > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// 根据专业编号删除专业
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static bool SpecialDelete(int Sid)
        {
            
                string sql = "delete from SelectStationPeriods where Specialty_ID=@Specialty_ID;delete from SpecialtyStations where Specialty_ID = @Specialty_ID; delete from Specialties where Specialty_ID = @Specialty_ID; ";
                SqlParameter[] para = {
                new SqlParameter ("Specialty_ID",Sid)
            };

            int i = DBHelper .ExecuteNonQuery(sql,para);
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
