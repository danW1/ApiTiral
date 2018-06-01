using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
  public  class TrainClassStudent_BLL
    {

        /// <summary>
        /// 查询所有省份信息
        /// </summary>
        /// <returns></returns>
        public static DataTable ProvincesQuery()
        {
            return DAL.TrainClassStudent_DAL.ProvincesQuery();
        }

        /// <summary>
        /// 查询所有校区信息
        /// </summary>
        /// <returns></returns>
        public static DataTable SchoolsQuery(int P_id)
        {
            return DAL.TrainClassStudent_DAL.SchoolsQuery(P_id);
        }

        /// <summary>
        /// 根据校区编号查询班级信息
        /// </summary>
        /// <returns></returns>
        public static DataTable SchoolsClassQuery(int Sch_id)
        {
            return DAL.TrainClassStudent_DAL.SchoolsClassQuery(Sch_id);

        }

        /// <summary>
        /// 显示所有岗位
        /// </summary>
        /// <returns></returns>
        public static DataTable StationsQuery()
        {
            return DAL.TrainClassStudent_DAL.StationsQuery();
        }
        /// <summary>
        /// 查询所有分班管理信息
        /// </summary>
        /// <returns></returns>
        /// <summary>
        /// 查询所有分班管理信息
        /// </summary>
        /// <returns></returns>
        public static DataTable TrainClassStudentQuery(int classstu,int P_id, int Sid, int Scid, int StionID)
        {
            return DAL.TrainClassStudent_DAL.TrainClassStudentQuery( classstu,P_id, Sid,Scid,StionID);
        }

        /// <summary>
        /// 查询所有实训班级信息
        /// </summary>
        /// <returns></returns>
        public static DataTable TrainClass()
        {
            return DAL.TrainClassStudent_DAL.TrainClass();
        }

        /// <summary>
        /// 查询学生所在实训班级信息
        /// </summary>
        /// <returns></returns>
        public static DataTable TrainClassQquery(int Tcid)
        {

            return DAL.TrainClassStudent_DAL.TrainClassQquery(Tcid);
        }

        /// <summary>
        /// 换班（根据学生编号修改班级）
        /// </summary>
        /// <param name="T"></param>
        /// <returns></returns>
        public static bool StudentctClassUpdate(int tcidh,int Tcid, int Sid)
        {
            return DAL.TrainClassStudent_DAL.StudentctClassUpdate(tcidh,Tcid, Sid);
        }


        /// <summary>
        /// 分班（根据学生编号修改班级）
        /// </summary>
        /// <param name = "T" ></ param >
        /// < returns ></ returns >
        public static int StudentClassUpdate(string sqldel, string strsql)
        {
            return DAL.TrainClassStudent_DAL.StudentClassUpdate(sqldel, strsql);
        }
    }
}
