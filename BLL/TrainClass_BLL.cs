using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class TrainClass_BLL
    {
        /// <summary>
        /// 查询所有实训班级信息
        /// </summary>
        /// <param name="T_Name"></param>
        /// <param name="T_Category"></param>
        /// <returns></returns>
        public static DataTable TrainClassQuery(string T_Name, int T_id)
        {
            return DAL.TrainClass_DAL.TrainClassQuery(T_Name, T_id);
        }

        /// <summary>
        /// 根据教师身份查询教师姓名
        /// </summary>
        /// <param name="Category"></param>
        /// <returns></returns>
        public static DataTable TraintCategory(int Category)
        {
            return DAL.TrainClass_DAL.TraintCategory(Category);
        }

        /// <summary>
        /// 根据班级编号删除数据
        /// </summary>
        /// <param name="Tc_id"></param>
        /// <returns></returns>
        public static bool TrainClassDELETE(int Tc_id)
        {
            return DAL.TrainClass_DAL.TrainClassDELETE(Tc_id);

        }

        /// <summary>
        /// 新增一个实训班级信息
        /// </summary>
        /// <param name="T"></param>
        /// <param name="C"></param>
        /// <returns></returns>
        public static bool TeacherClassAdd(TrainClassesInfo T, int jyid,int ddid)
        {
            return DAL.TrainClass_DAL.TeacherClassAdd(T,jyid,ddid);
        }

        /// <summary>
        /// 通过班级编号获取信息
        /// </summary>
        /// <param name="Tc_id"></param>
        /// <returns></returns>
        public static DataTable TeacherqueryTcid(int Tc_id)
        {
            return DAL.TrainClass_DAL.TeacherqueryTcid(Tc_id);
        }
        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="T"></param>
        /// <param name="jyid"></param>
        /// <param name="ddid"></param>
        /// <param name="T_id"></param>
        /// <returns></returns>
        public static bool TeacherUpdate(TrainClassesInfo T, int jyid, int ddid)
        {
            return DAL.TrainClass_DAL.TeacherUpdate(T,jyid,ddid);
        }
    }
}
