using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class Teacher_BLL
    {
        /// <summary>
        /// 用户登录进行验证
        /// </summary>
        /// <param name="Login_Name"></param>
        /// <param name="Pwd"></param>
        /// <returns></returns>
        public static DataTable teacherLogin(string Login_Name, string Pwd)
        {
            return DAL.Teacher_DAL.teacherLogin(Login_Name, Pwd);
        }
        /// <summary>
        /// 模糊查询所有Teacher表信息
        /// </summary>
        /// <returns></returns>
        public static DataTable TeacherQuery(string Name, string T_LoginName, string T_Tel, int T_Category)
        {
            return DAL.Teacher_DAL.TeacherQuery(Name, T_LoginName,T_Tel, T_Category);
        }
        /// <summary>
        /// 添加Teacher表的信息
        /// </summary>
        /// <param name="T"></param>
        /// <returns></returns>
        public static bool TeacherAdd(TeachersInfo T)
        {
            return DAL.Teacher_DAL.TeacherAdd(T);
        }


        /// <summary>
        /// 修改Teacher表的信息
        /// </summary>
        /// <param name="T"></param>
        /// <returns></returns>
        public static bool TeacherUpdate(TeachersInfo T)
        {
            return DAL.Teacher_DAL.TeacherUpdate(T);

        }

        /// <summary>
        /// 根据员工编号删除Teacher表信息
        /// </summary>
        /// <param name="T_ID"></param>
        /// <returns></returns>
        public static bool TeacherDelete(int T_ID)
        {
            return DAL.Teacher_DAL.TeacherDelete(T_ID);
        }

        /// <summary>
        /// 根据编号查询所有信息
        /// </summary>
        /// <param name="Tid"></param>
        /// <returns></returns>
        public static DataTable TeacherTId(int Tid)
        {
            return DAL.Teacher_DAL.TeacherTId(Tid);
        }
        /// <summary>
        /// 修改用户登录时间
        /// </summary>
        /// <param name="time"></param>
        /// <param name="t_id"></param>
        /// <returns></returns>
        public static bool UpdateLastTime(string time, int t_id)
        {
            return DAL.Teacher_DAL.UpdateLastTime(time, t_id);

        }
        /// <summary>
        /// 根据编号修改密码（重置密码）
        /// </summary>
        /// <param name="T_id"></param>
        /// <returns></returns>
        public static bool UpdateTeactPwd(int T_id)
        {
            return DAL.Teacher_DAL.UpdateTeactPwd(T_id);
        }
        /// <summary>
        /// 禁启用
        /// </summary>
        /// <param name="T_IsEnabled"></param>
        /// <param name="Tid"></param>
        /// <returns></returns>
        public static bool TeacherIsEnabled(string T_IsEnabled, int Tid)
        {
            return DAL.Teacher_DAL.TeacherIsEnabled(T_IsEnabled, Tid);
        }
    }
}
