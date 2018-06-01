using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public class SchoolStudentS_BLL
    {

        /// <summary>
        /// 省份和校区的联合查询
        /// </summary>
        /// <param name="P_id"></param>
        /// <param name="SName"></param>
        /// <returns></returns>
        public static DataTable ProvinceSchol(int P_id, string SName)
        {
            return DAL.SchoolStudentS_DAL.ProvinceSchol(P_id,SName);
        }

        /// <summary>
        /// 查询所有省份信息
        /// </summary>
        /// <returns></returns>
        public static DataTable ProvinceQuery()
        {
            return DAL.SchoolStudentS_DAL.ProvinceQuery();
        }

        /// <summary>
        /// 根据校区编号查询所有校区专业班级信息
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable SchoolClassQuery(int Sid, int SP_id, string Cname)
        {
            return DAL.SchoolStudentS_DAL.SchoolClassQuery(Sid, SP_id, Cname);
        }


        /// <summary>
        /// 查询所有专业名称
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable SpecialtiesQuery()
        {
            return DAL.SchoolStudentS_DAL.SpecialtiesQuery();
        }

        /// <summary>
        /// 跟据条件查询所属校区班级学生信息
        /// </summary>
        /// <param name="Stu_id"></param>
        /// <param name="sc_id"></param>
        /// <param name="sp_id"></param>
        /// <returns></returns>
        public static DataTable StudentQuery(int Stu_id, int sc_id, int sp_id)
        {
            return DAL.SchoolStudentS_DAL.StudentQuery(Stu_id,sc_id,sp_id);
        }
    }
}
