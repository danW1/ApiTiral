using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class Specialties_BLL
    {
        /// <summary>
        /// 查询所有专业
        /// </summary>
        /// <returns></returns>
        public static DataTable SpecialQuery()
        {
            return DAL.Specialties_DAL.SpecialQuery();
        }
        /// <summary>
        /// 修改时获取值
        /// </summary>
        /// <returns></returns>
        public static DataTable SpecialUpdateQuery(int Sid)
        {
            return DAL.Specialties_DAL.SpecialUpdateQuery(Sid);
        }

        /// <summary>
        /// 修改专业表内容
        /// </summary>
        /// <param name="S"></param>
        /// <returns></returns>
        public static bool SpecialUpdate(SpecialtiesInfo S)
        {
            return DAL.Specialties_DAL.SpecialUpdate(S);
        }


        /// <summary>
        /// 添加专业表内容
        /// </summary>
        /// <param name="S"></param>
        /// <returns></returns>
        public static bool SpecialAdd(SpecialtiesInfo S)
        {
            return DAL.Specialties_DAL.SpecialAdd(S);
        }

        /// <summary>
        /// 根据专业编号删除专业
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static bool SpecialDelete(int Sid)
        {
            return DAL.Specialties_DAL.SpecialDelete(Sid);
        }
    }
}
