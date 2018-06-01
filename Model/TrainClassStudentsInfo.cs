using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    /// <summary>
    /// 分班信息表
    /// </summary>
    public class TrainClassStudentsInfo
    {
        /// <summary>
        /// 学生编号
        /// </summary>
        public int Student_ID { get; set; }

        /// <summary>
        /// 实训班级编号
        /// </summary>
        public int TC_ID { get; set; }

        /// <summary>
        /// 房间编号
        /// </summary>
        public int R_ID { get; set; }
        /// <summary>
        /// 是否已分配寝室
        /// </summary>
        public int Student_IsHasAllotRoom { get; set; }

    }
}
