using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class SchooInfo_BLL
    {
        /// <summary>
        /// 根据校区代码删除学校
        /// </summary>
        /// <param name="Code"></param>
        /// <returns></returns>
        public static bool Schooldelete(int Pid ,string School_ID)
        {
            return DAL.SchooInfo_DAL.Schooldelete(Pid,School_ID);
        }
        /// <summary>
        /// 根据校区编号添加学校
        /// </summary>
        /// <param name="School_ID"></param>
        /// <returns></returns>
        public static bool SchoolidAdd(SchoolsInfo S)
        {
            return DAL.SchooInfo_DAL.SchoolidAdd(S);
        }
        /// <summary>
        /// 根据校区id，查询校区信息
        /// </summary>
        /// <returns></returns>
        public static DataTable SchoolIdQuery(int SchoolID)
        {
            return DAL.SchooInfo_DAL.SchoolIdQuery(SchoolID);

        }

        /// <summary>
        /// 根据校区编号修改学校
        /// </summary>
        /// <param name="School_ID"></param>
        /// <returns></returns>
        public static bool SchoolidUpdate(SchoolsInfo S)
        {
            return DAL.SchooInfo_DAL.SchoolidUpdate(S);
        }
    }
}
