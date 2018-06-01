﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace DAL
{
    public class DBHelper12
    {
        private static string strConn = ConfigurationManager.ConnectionStrings["CRM"].ConnectionString;//获取配置文件中的链接数据库字符串
        //用于进行增删改的方法
        //执行strsql语句，返回影响的行数
        public static int ExecuteNonQuery(string strsql, bool isStoredProcedure, SqlParameter[] para)
        {
            SqlConnection conn = new SqlConnection(strConn);
            SqlCommand cmd = new SqlCommand(strsql, conn);
            conn.Open();
            if (para != null)
            {

                cmd.Parameters.AddRange(para);//防注入式攻击
            }
            if (isStoredProcedure)
            {
                //表示调用的是存储过程
                cmd.CommandType = CommandType.StoredProcedure;
            }
            int x = cmd.ExecuteNonQuery();
            conn.Close();
            return x;
        }

        //用于执行查询的方法
        //执行查询，使用的sql语句是strsql,查询的结果返回

        public static DataTable GetDataTable(string strsql,bool isStoredProcedure, SqlParameter[] para )
        {
            SqlDataAdapter da = new SqlDataAdapter(strsql, strConn);
            if (para != null)
            {
                da.SelectCommand.Parameters.AddRange(para);
            }
            if (isStoredProcedure)
            {
                //表示要执行的是存储过程
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
            }
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }
}
