using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class Static_BLL
    {
        /// <summary>
        /// 查询所有岗位信息
        /// </summary>
        /// <param name="Sname"></param>
        /// <returns></returns>
        public static DataTable StaticQuery(string Sname)
        {
            return DAL.Static_DAL.StaticQuery(Sname);
        }

        /// <summary>
        /// 根据专业编号查询查询所有岗位信息
        /// </summary>
        /// <param name="Sname"></param>
        /// <returns></returns>
        public static DataTable StaticUpdataQuery(int Sid)
        {
            return DAL.Static_DAL.StaticUpdataQuery(Sid);
        }

        /// <summary>
        /// 根据编号修改岗位信息
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static bool StaticUpdata(StationsInfo s)
        {
            return DAL.Static_DAL.StaticUpdata(s);
        }

        /// <summary>
        /// 根据编号新增专业信息
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static bool StaticAdd(StationsInfo s)
        {
            return DAL.Static_DAL.StaticAdd(s);
        }

        /// <summary>
        /// 根据编号删除专业信息
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static bool StaticDelete(int Sid)
        {
            return DAL.Static_DAL.StaticDelete(Sid);
        }
    }
}
