using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
namespace DAL
{
    public class SetStatic_DAL
    {
        /// <summary>
        /// 查询所有校区信息
        /// </summary>
        /// <param name="Scode"></param>
        /// <param name="Sname"></param>
        /// <returns></returns>
        public static DataTable SetSchollQuery(string Scode, string Sname)
        {
            string Wherejiao = "";
            if (Scode != "" || Scode != null)
            {
                Wherejiao += "  and School_Code like '%" + Scode + "%'";
            }
            if (Sname != "" || Sname != null)
            {
                Wherejiao += "  and School_Name like '%" + Sname + "%'";
            }
            string sql = "select * from Schools where 1=1 " + Wherejiao;
            DataTable dt = DBHelper.GetDataTable(sql, null);
            return dt;

        }
        /// <summary>
        /// 根据校区编号查询专业信息
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable SchoolidQuery(int Sid)
        {
            string sql = "select distinct(c.Specialty_ID),c.Specialty_Name,c.Specialty_Description,a.School_ID from Schools a,SpecialtyStations b,Specialties c where a.School_ID=b.School_ID and b.Specialty_ID=c.Specialty_ID and a.School_ID=@School_ID";
            SqlParameter[] para = {
                new SqlParameter ("School_ID",Sid)
            };
            DataTable dt = DBHelper.GetDataTable(sql, para);
            return dt;
        }

        /// <summary>
        ///查询所有岗位信息
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable StationsQuery()
        {
            string sql = "select * from Stations";
            DataTable dt=DBHelper.GetDataTable(sql,null);
            return dt;
        }
        /// <summary>
        /// 向专业岗位插入数据（点击保存时）
        /// </summary>
        /// <param name="schloolid"></param>
        /// <param name="zid"></param>
        /// <param name="sql"></param>
        /// <returns></returns>
        public static bool SpecialtyStation(int schloolid, int zid, string sql)
        {
            string strSql = "delete from SpecialtyStations where  School_ID=@School_ID and Specialty_ID=@Specialty_ID;insert into SpecialtyStations " + sql;
            SqlParameter[] para = {
                new SqlParameter("School_ID",schloolid),
                 new SqlParameter("Specialty_ID",zid)
            };
            int i = DBHelper.ExecuteNonQuery(strSql, para);
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
        ///(单选按钮的单击事件) 查询获取复选框值
        /// </summary>
        /// <returns></returns>
        public static DataTable StationSchool1(int  Sid,int Zid, int S)
        {
            string sql = "";
            if (S == 1)
            {
                sql = "select * from Stations where Station_ID in(select Station_ID  from SpecialtyStations  where School_ID=@School_ID and Specialty_ID=@Specialty_ID)";
            }
            else if (S == 2)
            {
              sql = "select * from Stations where Station_ID not in(select Station_ID  from SpecialtyStations  where School_ID=@School_ID and Specialty_ID=@Specialty_ID)";
            }
            else {
                sql = "select * from Stations left join SpecialtyStations on Stations.Station_ID =SpecialtyStations.Station_ID";
            }
           
            SqlParameter[] para = {
                new SqlParameter ("School_ID",Sid),
                new SqlParameter ("Specialty_ID",Zid)
            };
            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;

        }

   

       
    }
}
