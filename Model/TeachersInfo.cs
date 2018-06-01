using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class TeachersInfo
    {
        public int T_ID { get; set; }

        public string  T_Name { get; set; }
        public string  T_Sex { get; set; }
        public string  T_Tel { get; set; }
        public int T_Category { get; set; }

        public string  T_LoginName { get; set; }

        public string  T_Pwd { get; set; }

        public int T_Role { get; set; }

        public int T_IsEnabled { get; set; }
        public string  T_LastLoginTime { get; set; }


    }
}
