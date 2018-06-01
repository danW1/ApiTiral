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
   public  class SchoolStudentS_DAL
    {

        /// <summary>
        /// 省份和校区的联合查询
        /// </summary>
        /// <param name="P_id"></param>
        /// <param name="SName"></param>
        /// <returns></returns>
        public static DataTable ProvinceSchol(int P_id, string SName)
        {
            string whereJ = "";
            if (P_id != 0)
            {
                whereJ += "  and Provinces.P_ID = "+ P_id;
            }
            if (SName!="")
            {
                whereJ += "  and School_Name = '"+ SName + "'";
            }
            string sql = "SELECT* FROM Schools,Provinces where Schools.P_ID = Provinces.P_ID "+ whereJ;
            DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;
        }

        /// <summary>
        /// 查询所有省份信息
        /// </summary>
        /// <returns></returns>
        public static DataTable ProvinceQuery()
        {
            string sql = "SELECT* FROM Provinces";
            DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;
        }

        /// <summary>
        /// 根据校区编号查询所有校区专业班级信息
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable SchoolClassQuery(int Sid,int SP_id ,string Cname)
        {
            string where = "";
            if (SP_id != 0)
            {
                where += "   and Specialty_ID= " + SP_id;

            }
            else if (Cname != "")
            {
                where += "  and School_Name='"+ Cname + "'";
            }
            string sql = " select * from Schools c left join (select a.SC_ID,a.SC_Name,a.School_ID,a.SC_FemaleAmount,a.SC_MaleAmount,a.SC_Supervisor,a.SC_Teacher,b.Specialty_ID,b.Specialty_Name from SchoolClasses a,Specialties b where a.Specialty_ID=b.Specialty_ID) h on c.School_ID=h.School_ID where c.School_ID=@School_ID "+where;
            SqlParameter[] para = {

                new SqlParameter ("School_ID",Sid)
            };
            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;
        }


        /// <summary>
        /// 查询所有专业名称
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable SpecialtiesQuery()
        {
            string sql = "  select * from Specialties";
           
            DataTable dt = DBHelper.GetDataTable(sql,null);
            return dt;
        }

        /// <summary>
        /// 跟据条件查询所属校区班级学生信息
        /// </summary>
        /// <param name="Stu_id"></param>
        /// <param name="sc_id"></param>
        /// <param name="sp_id"></param>
        /// <returns></returns>
        public static DataTable StudentQuery(int Stu_id,int sc_id,int sp_id)
        {
            string sql = " select * from Students c left join (select a.SC_ID,a.School_ID,a.SC_Name,b.Specialty_ID from SchoolClasses a ,Specialties b where a.Specialty_ID=b.Specialty_ID) d on c.SC_ID=d.SC_ID where 1=1 and Student_ID=@Student_ID and d.SC_ID=@SC_ID and d.Specialty_ID=@Specialty_ID";
            SqlParameter[] para = {
                new SqlParameter ("Student_ID",Stu_id),
                new SqlParameter ("SC_ID",sc_id),
                new SqlParameter ("Specialty_ID",sp_id)
            };

            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;
        }
    }
}
