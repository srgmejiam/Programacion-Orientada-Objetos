using DAL;
using EL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public static class BL_RolFormulario
    {
        public static int Insertar(RolFormulario Entidad)
        {
            return DAL_RolFormularios.Insertar(Entidad);
        }
        public static int Actualizar(RolFormulario Entidad)
        {
            return DAL_RolFormularios.Actualizar(Entidad);
        }

        public static bool Anular(RolFormulario Entidad)
        {
            return DAL_RolFormularios.Anular(Entidad);
        }

    }
}
