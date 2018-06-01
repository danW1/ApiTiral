using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class ProviceS_BLL
    {
        /// <summary>
        /// 学校和省的连接查询
        /// </summary>
        /// <param name="Pid"></param>
        /// <param name="School_Name"></param>
        /// <returns></returns>
        public static DataTable ProvicesQueryS(int PName, int School_ID)
        {
            return DAL.ProviceS_DAL.ProvicesQueryS(PName, School_ID);
        }

        /// <summary>
        /// 查询省份信息
        /// </summary>
        /// <returns></returns>
        public static DataTable ProvicesQuery()
        {
            return DAL.ProviceS_DAL.ProvicesQuery();
        }
        /// <summary>
        /// 根据省份ID查询所在其省份的学校
        /// </summary>
        /// <param name="P_id"></param>
        /// <returns></returns>
        public static DataTable Provice(int P_id)
        {

            return DAL.ProviceS_DAL.Provice(P_id);
        }

        /// <summary>
        /// 通过校区ID查询选岗周期表（三表连接查询）
        /// </summary>
        /// <param name="Sid"></param>
        /// <returns></returns>
        public static DataTable StationPeriodsQuery(int Sid)
        {
            return DAL.ProviceS_DAL.StationPeriodsQuery(Sid);
        }

        /// <summary>
        /// 查询所有专业信息
        /// </summary>
        public static DataTable SpecialtiesQUery()
        {
            return DAL.ProviceS_DAL.SpecialtiesQUery();
        }
        /// <summary>
        /// 添加选岗信息
        /// </summary>
        public static bool SchoolAdduery(SelectStationPeriodsInfo S)
        {
            return DAL.ProviceS_DAL.SchoolAdduery(S);

        }
    }
}
