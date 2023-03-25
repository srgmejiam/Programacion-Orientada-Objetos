using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using EL;
using System.Data;

namespace DAL
{
    public static class DAL_RolPermisos
    {
        public static int Insertar(RolPermisos Entidad)
        {
            SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
            sqlConnection.Open();
            SqlCommand cmd = new SqlCommand("InsertarRolPermiso", sqlConnection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdRolPermiso", Entidad.IdRolPermiso);
            cmd.Parameters.AddWithValue("@IdRol", Entidad.IdRol);
            cmd.Parameters.AddWithValue("@IdPermiso", Entidad.IdPermiso);
            cmd.Parameters.AddWithValue("@IdUsuarioRegistra", Entidad.IdUsuarioRegistra);
            int ID = Convert.ToInt32(cmd.ExecuteScalar());
            sqlConnection.Close();
            sqlConnection.Dispose();
            return ID;
        }

        public static int Actualizar(RolPermisos Entidad)
        {
            SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
            sqlConnection.Open();
            SqlCommand cmd = new SqlCommand("ActualizarRolPermiso", sqlConnection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdRolPermiso", Entidad.IdRolPermiso);
            cmd.Parameters.AddWithValue("@IdRol", Entidad.IdRol);
            cmd.Parameters.AddWithValue("@IdPermiso", Entidad.IdPermiso);
            cmd.Parameters.AddWithValue("@IdUsuarioActualiza", Entidad.IdUsuarioActualiza);
            int ID = Convert.ToInt32(cmd.ExecuteScalar());
            sqlConnection.Close();
            sqlConnection.Dispose();
            return ID;
        }

        public static bool Anular(RolPermisos Entidad)
        {
            try
            {
                SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
                sqlConnection.Open();
                SqlCommand Cmd = new SqlCommand("AnularRolPermiso", sqlConnection);
                Cmd.CommandType = CommandType.StoredProcedure;
                Cmd.Parameters.AddWithValue("@IdRolPermiso", Entidad.IdRolPermiso);
                Cmd.Parameters.AddWithValue("@IdUsuarioActualizar", Entidad.IdUsuarioActualiza);
                Cmd.ExecuteNonQuery();
                sqlConnection.Close();
                sqlConnection.Dispose();
                return true;
            }
            catch
            {
                return false;
            }

        }
    }
}
