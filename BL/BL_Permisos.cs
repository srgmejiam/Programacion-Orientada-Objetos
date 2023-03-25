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
    public static class BL_Permisos
    {
        public static int Insertar(Permisos Entidad)
        {
            return DAL_Permisos.Insertar(Entidad);
        }

 public static int Actualizar(Permisos Entidad)
        {
            return DAL_Permisos.Actualizar(Entidad);
        }
        public static DataTable Select(Permisos Entidad)
        {
            return DAL_Permisos.Select(Entidad);
        }
        public static bool Anular(Permisos Entidad)
        {
            return DAL_Permisos.Anular(Entidad);
        }

    }
}
