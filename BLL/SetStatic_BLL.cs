using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class SetStatic_BLL
    {
        /// <summary>
        /// 查询所有校区信息
        /// </summary>
        /// <param name="Scode"></param>
        /// <param name="Sname"></param>
        /// <returns></returns>
        public static DataTable SetSchollQuery(string Scode, string Sname)
        {
            return DAL.SetStatic_DAL.SetSchollQuery(Scode, Sname);
        }

        /// <summary>
        /// 根据校区编号查询专业信息
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable SchoolidQuery(int Sid)
        {
            return DAL.SetStatic_DAL.SchoolidQuery(Sid);
        }

        /// <summary>
        ///查询所有岗位信息
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable StationsQuery()
        {
            return DAL.SetStatic_DAL.StationsQuery();
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
            return DAL.SetStatic_DAL.SpecialtyStation(schloolid,zid,sql);
        }


        /// <summary>
        ///(单选按钮的单击事件) 查询获取复选框值
        /// </summary>
        /// <returns></returns>
        public static DataTable StationSchool1(int Sid, int Zid, int S)
        {
            return DAL.SetStatic_DAL.StationSchool1(Sid, Zid, S);

        }

     
    }
}
