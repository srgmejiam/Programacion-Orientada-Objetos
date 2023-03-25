﻿using EL;
using DAL;
using System.Data;

namespace BL
{
    public class BL_Usuarios
    {
        public int Insertar(Usuarios Entidad)
        {
            return DAL_Usuarios.Insertar(Entidad);
        }
        public static int Actualizar(Usuarios Entidad)
        {
            return DAL_Usuarios.Actualizar(Entidad);
        }
        public static int Anular(Usuarios Entidad)
        {
            return DAL_Usuarios.Anular(Entidad);
        }
        public static DataTable Select(Usuarios Entidad)
        {
            return DAL_Usuarios.Select(Entidad);
        }
        public static int Bloqueo(Usuarios Entidad)
        {
            return DAL_Usuarios.Bloqueo(Entidad);
        }
        public static int ActualizarPassword(Usuarios Entidad)
        {
            return DAL_Usuarios.ActualizarPassword(Entidad);
        }
        public static int SumarIntentosFallidos(Usuarios Entidad)
        {
            return DAL_Usuarios.SumarIntentosFallidos(Entidad);
        }
    }
}
