using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
  public   class TrainClassesInfo
    {
        /// <summary>
        /// 实训班级编号
        /// </summary>
        public int TC_ID { get; set; }

        public string  TC_Name { get; set; }

        public string TC_Grade { get; set; }
        public DateTime  TC_BeginTime { get; set; }
        public DateTime TC_EndTime { get; set; }

        public string TC_MaxAmount { get; set; }

        public string TC_MaleAmount { get; set; }


        public string TC_FemaleAmount { get; set; }

        public string TC_Period { get; set; }
    }
}
