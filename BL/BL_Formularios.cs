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
    public static class BL_Formularios
    {
        public static int Insertar(Formularios Entidad)
        {
            return DAL_Formularios.Insertar(Entidad);
        }

        public static int Actualizar(Formularios Entidad)
        {
            return DAL_Formularios.Actualizar(Entidad);
        }
        public static DataTable Select(Formularios Entidad)
        {
            return DAL_Formularios.Select(Entidad);
        }
        public static bool Anular(Formularios Entidad)
        {
            return DAL_Formularios.Anular(Entidad);
        }

    }
}
