using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    /// <summary>
    /// 校区管理实体类
    /// </summary>
   public  class SchoolsInfo
    {
        /// <summary>
        /// 校区编号
        /// </summary>
        public int School_ID { get; set; }  

        /// <summary>
        /// 省份编号
        /// </summary>
        public int P_ID { get; set; }
        /// <summary>
        /// 校区代码
        /// </summary>
        public string School_Code { get; set; }
        /// <summary>
        /// 校区名称
        /// </summary>
        public string  School_Name { get; set; }
        /// <summary>
        /// 校区备注
        /// </summary>
        public string  School_Remark { get; set; }





    }
}
