using DAL;
using EL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class BL_RolPermisos
    {
        public static int Insertar(RolPermisos Entidad)
        {
            return DAL_RolPermisos.Insertar(Entidad);
        }
        public static int Actualizar(RolPermisos Entidad)
        {
            return DAL_RolPermisos.Actualizar(Entidad);
        }
        public static bool Anular(RolPermisos Entidad)
        {
            return DAL_RolPermisos.Anular(Entidad);
        }

    }
}
