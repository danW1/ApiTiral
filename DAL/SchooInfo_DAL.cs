using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Model;
using System.Data.SqlClient;
namespace DAL
{
    public class SchooInfo_DAL
    {
        /// <summary>
        /// 根据校区编号删除学校
        /// </summary>
        /// <param name="Code"></param>
        /// <returns></returns>
        public static bool Schooldelete(int Pid,string School_ID)
        {
          
                string sql = "delete from Schools where School_ID=@School_ID and P_ID=@P_ID";
                SqlParameter[] para = {

                new SqlParameter ("P_ID",Pid),
                new SqlParameter ("School_ID",School_ID)
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
        /// <summary>
        /// 根据校区编号修改学校
        /// </summary>
        /// <param name="School_ID"></param>
        /// <returns></returns>
        public static bool SchoolidUpdate(SchoolsInfo S)
        {
            string sql = "update Schools set School_Code=@School_Code, School_Name=@School_Name,School_Remark=@School_Remark where School_ID=@School_ID and P_ID=@P_ID";
            SqlParameter[] para = {
                new SqlParameter ("P_ID",S.P_ID),
                new SqlParameter ("School_Code",S.School_Code),
                new SqlParameter ("School_Name",S.School_Name),
                new SqlParameter ("School_Remark",S.School_Remark),
                new SqlParameter ("School_ID",S.School_ID)
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

        /// <summary>
        /// 根据校区编号添加学校
        /// </summary>
        /// <param name="School_ID"></param>
        /// <returns></returns>
        public static bool SchoolidAdd(SchoolsInfo S)
        {
            string sql = "insert into Schools(P_ID,School_Code,School_Name,School_Remark) values(@P_ID,@School_Code,@School_Name,@School_Remark)";
            SqlParameter[] para = {
                new SqlParameter  ("P_ID",S.P_ID),
                new SqlParameter ("School_Code",S.School_Code),
                new SqlParameter ("School_Name",S.School_Name),
                new SqlParameter ("School_Remark",S.School_Remark)
             
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
        /// <summary>
        /// 根据校区id，查询校区信息
        /// </summary>
        /// <returns></returns>
        public static DataTable SchoolIdQuery(int SchoolID)
        {
            string sql = "select * from Schools where School_ID=@School_ID";
            SqlParameter[] para = {
                new SqlParameter ("School_ID",SchoolID)
            };
            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;
        }

    }
}
