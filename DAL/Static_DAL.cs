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
   public  class Static_DAL
    {
        /// <summary>
        /// 查询所有岗位信息
        /// </summary>
        /// <param name="Sname"></param>
        /// <returns></returns>
        public static DataTable StaticQuery(string Sname)
        {
            string whereji = "";
            if (Sname != "" || Sname != null)
            {
                whereji += "and Station_Name like '%"+Sname+"%'";
            }
            string sql = "select * from Stations where 1=1 "+ whereji;
            DataTable dt = DBHelper.GetDataTable(sql, null);
            return dt;

        }

        /// <summary>
        /// 根据专业编号查询查询所有岗位信息
        /// </summary>
        /// <param name="Sname"></param>
        /// <returns></returns>
        public static DataTable StaticUpdataQuery(int Sid)
        {
          
            string sql = "select * from Stations where Station_ID=@Station_ID";
            SqlParameter[] para = {
                new SqlParameter ("Station_ID",Sid)

            };
            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;

        }

        /// <summary>
        /// 根据编号修改岗位信息
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static bool StaticUpdata(StationsInfo s)
        {
            String sql = "update Stations set Station_Name=@Station_Name,Station_Duty=@Station_Duty,Station_NeedTechnique=@Station_NeedTechnique where Station_ID=@Station_ID";
            SqlParameter[] para = {
                new SqlParameter ("Station_Name",s.Station_Name),
                new SqlParameter ("Station_Duty",s.Station_Duty),
                new SqlParameter ("Station_NeedTechnique",s.Station_NeedTechnique),
                new SqlParameter ("Station_ID",s.Station_ID)
            };
            int i = DBHelper.ExecuteNonQuery(sql,para);
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
        /// 根据编号新增专业信息
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static bool StaticAdd(StationsInfo s)
        {
            String sql = "insert into Stations(Station_Name,Station_Duty,Station_NeedTechnique) values(@Station_Name,@Station_Duty,@Station_NeedTechnique)";
            SqlParameter[] para = {
                new SqlParameter ("Station_Name",s.Station_Name),
                new SqlParameter ("Station_Duty",s.Station_Duty),
                new SqlParameter ("Station_NeedTechnique",s.Station_NeedTechnique)
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
        /// 根据编号删除专业信息
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static bool StaticDelete(int Sid) {
            string sql = "delete from Stations where Station_ID=@Station_ID";
            SqlParameter[] para = {
                new SqlParameter ("Station_ID",Sid)
            };
            int i = DBHelper.ExecuteNonQuery(sql,para);

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
