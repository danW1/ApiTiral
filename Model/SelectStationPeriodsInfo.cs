using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    /// <summary>
    /// 选岗周期
    /// </summary>
    public class SelectStationPeriodsInfo
    {
        /// <summary>
        /// 周期编号
        /// </summary>
        public int SSP_ID { get; set; }
        /// <summary>
        /// 校区编号
        /// </summary>
        public int School_ID { get; set; }
        /// <summary>
        /// 专业编号
        /// </summary>
        public int Specialty_ID { get; set; }
        /// <summary>
        /// 宣讲日期
        /// </summary>
        public string  SSP_PreachDate { get; set; }
        /// <summary>
        /// 过期天数
        /// </summary>
        public string  SSP_OverDay { get; set; }
    }
}
