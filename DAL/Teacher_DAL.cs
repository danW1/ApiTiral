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
    public class Teacher_DAL
    {

        /// <summary>
        /// 登录系统时，进行验证（根据登录名和密码查询Teacher信息）
        /// </summary>
        /// <param name="Login_Name"></param>
        /// <param name="Pwd"></param>
        /// <returns></returns>
        public static DataTable teacherLogin (string Login_Name,string Pwd)
        {
           
            string sql = "select * from Teachers where T_LoginName=@T_LoginName and T_Pwd=@T_Pwd";
            SqlParameter[] para = {
                new SqlParameter ("T_LoginName",Login_Name),
                new SqlParameter ("T_Pwd",Pwd)
            };

            DataTable dt = DBHelper.GetDataTable(sql,para);
            return dt;

        }
        /// <summary>
        /// 模糊查询所有Teacher表信息
        /// </summary>
        /// <returns></returns>
        public static DataTable TeacherQuery(string Name ,string T_LoginName,string T_Tel,int T_Category)
        {
            string WhereJiao = "";
            if (Name != "")
            {
                WhereJiao += "   and  T_Name like '%"+ Name + "%' ";
            }
            if (T_LoginName != "")
            {
                WhereJiao += "   and T_LoginName like '%"+ T_LoginName + "%'";
            }
            if (T_Tel != "" )
            {
                WhereJiao += "   and T_Tel like '%" + T_Tel + "%'";
            }
           if (T_Category == 0 || T_Category == 1)
            {
                WhereJiao += "  and T_Category like '%" + T_Category + "%'";
            }

            string sql ="select * from Teachers where 1=1 " + WhereJiao;
            DataTable dt = DBHelper.GetDataTable(sql,null);
          
            return dt;


        }
        /// <summary>
        /// 添加Teacher表的信息
        /// </summary>
        /// <param name="T"></param>
        /// <returns></returns>
        public static bool TeacherAdd(TeachersInfo T)
        {
           
                string sql = "insert into Teachers (T_Name,T_Sex,T_Tel,T_Category,T_LoginName,T_Pwd,T_Role,T_IsEnabled,T_LastLoginTime) values(@T_Name,@T_Sex,@T_Tel,@T_Category,@T_LoginName,1,@T_Role,1,null)";
                SqlParameter[] para = {
                new SqlParameter ("T_Name",T.T_Name),
                new SqlParameter ("T_Sex",T.T_Sex),
                new SqlParameter ("T_Tel",T.T_Tel),
                new SqlParameter ("T_Category",T.T_Category),
                new SqlParameter ("T_LoginName",T.T_LoginName),
                new SqlParameter ("T_Role",T.T_Role),
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
        /// 根据编号查询所有信息
        /// </summary>
        /// <param name="Tid"></param>
        /// <returns></returns>
        public static DataTable TeacherTId(int Tid)
        {
            string sql = "select * from Teachers where T_ID=@T_ID";
            SqlParameter[] para = {
                new SqlParameter ("T_ID",Tid)
            };
            DataTable dt = DBHelper.GetDataTable(sql, para);
            return dt;
            

        }

        /// <summary>
        /// 修改Teacher表的信息
        /// </summary>
        /// <param name="T"></param>
        /// <returns></returns>
        public static bool TeacherUpdate(TeachersInfo T)
        {

            try
            {
                string sql = "update Teachers set T_Name=@T_Name,T_Sex=@T_Sex,T_Tel=@T_Tel,T_Category=@T_Category,T_LoginName=@T_LoginName,T_Pwd=1,T_Role=@T_Role,T_IsEnabled=1,T_LastLoginTime=null where T_ID=@T_ID";

                SqlParameter[] para = {
                new SqlParameter ("T_ID",T.T_ID),
                new SqlParameter ("T_Name",T.T_Name),
                new SqlParameter ("T_Sex",T.T_Sex),
                new SqlParameter ("T_Tel",T.T_Tel),
                new SqlParameter ("T_Category",T.T_Category),
                new SqlParameter ("T_LoginName",T.T_LoginName),
                new SqlParameter ("T_Role",T.T_Role),
           
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
        /// 根据员工编号删除Teacher表信息
        /// </summary>
        /// <param name="T_ID"></param>
        /// <returns></returns>
        public static bool TeacherDelete(int T_ID)
        {
            try
            {
                string sql = "delete from TrainClassTeachers where T_ID=@T_ID;delete from OperationLogs where T_ID = @T_ID; delete from Teachers where T_ID=@T_ID";
                SqlParameter[] para = {
                new SqlParameter ("T_ID",T_ID )
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
       /// 修改用户登录时间
       /// </summary>
       /// <param name="time"></param>
       /// <param name="t_id"></param>
       /// <returns></returns>
        public static bool UpdateLastTime(string time, int t_id)
        {
            string strSql = "update Teachers set T_LastLoginTime=@T_LastLoginTime where T_ID=@T_ID";
            SqlParameter[] para = {
                new SqlParameter("T_LastLoginTime",time),
                 new SqlParameter("T_ID",t_id)
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
        /// 根据编号修改密码（重置密码）
        /// </summary>
        /// <param name="T_id"></param>
        /// <returns></returns>
        public static bool UpdateTeactPwd(int T_id)
        {
            try
            {
                string sql = "update Teachers set T_Pwd=123 where T_ID=@T_ID";
                SqlParameter[] para = {

                new SqlParameter ("T_ID",T_id)
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
        /// 禁启用
        /// </summary>
        /// <param name="T_IsEnabled"></param>
        /// <param name="Tid"></param>
        /// <returns></returns>
        public static bool TeacherIsEnabled(string T_IsEnabled,int Tid)
        {
            string sql = "";
            if (T_IsEnabled == "0")
            {
                sql = "update Teachers set T_IsEnabled='1' where T_ID=@T_ID";

            }
            else
            {
                sql = "update Teachers set T_IsEnabled='0' where T_ID=@T_ID";
            }

            SqlParameter[] para = {
                new SqlParameter ("T_IsEnabled",T_IsEnabled),
                 new SqlParameter ("T_ID",Tid)
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

    }
}
