using HospitalAppAdmin.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HospitalAppAdmin.Utils
{
    class Manager
    {
        public static User loginedUser { get; set; }
        public static HospitalAppAdmin.Entities.User user { get; set; }
    }
}
