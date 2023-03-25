using DAL;
using EL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class BL_Roles
    {
        public static int Insertar(Roles Entidad)
        {
            return DAL_Roles.Insertar(Entidad);
        }

     public static int Actualizar(Roles Entidad)
        {
            return DAL_Roles.Actualizar(Entidad);
        }
        public static DataTable Select(Roles Entidad)
        {
            return DAL_Roles.Select(Entidad);
        }
        public static bool Anular(Roles Entidad)
        {
            return DAL_Roles.Anular(Entidad);
        }

    }
}
