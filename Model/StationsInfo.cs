using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
   public  class StationsInfo
    {
        /// <summary>
        /// 岗位编号
        /// </summary>
        public int Station_ID { get; set; }

        /// <summary>
        /// 岗位名称
        /// </summary>
        public string  Station_Name { get; set; }

        /// <summary>
        /// 岗位职责
        /// </summary>
        public string  Station_Duty { get; set; }

        /// <summary>
        /// 所需技术
        /// </summary>
        public string  Station_NeedTechnique { get; set; }

    }
}
