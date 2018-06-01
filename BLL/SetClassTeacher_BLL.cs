using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class SetClassTeacher_BLL
    {

        /// <summary>
        /// 查询所有老师信息
        /// </summary>
        /// <returns></returns>
        public static DataTable TeacherQuery(string TName, int Tid)
        {
            return DAL.SetClassTeacher_DAL.TeacherQuery(TName,Tid);
        }


        /// <summary>
        /// 查询所带实训班级信息
        /// </summary>
        /// <param name="classid"></param>
        /// <param name="Category"></param>
        /// <returns></returns>
        public static DataTable ClassQuery(int classid, int Category, int T_id)
        {
            return DAL.SetClassTeacher_DAL.ClassQuery(classid,Category, T_id);
        }

        /// <summary>
        /// 根据班级编号参加
        /// </summary>
        /// <param name="Tc_id"></param>
        /// <param name="sqll"></param>
        /// <returns></returns>
        public static bool ClassAdd(string[] num, int Category, int T_id, string sqll)
        {
            return DAL.SetClassTeacher_DAL.ClassAdd(num, Category, T_id, sqll);
        }
    }
}
