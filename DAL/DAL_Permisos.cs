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
    public static class DAL_Permisos
    {
        public static int Insertar(Permisos Entidad)
        {
            SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
            sqlConnection.Open();
            SqlCommand cmd = new SqlCommand("InsertarPermiso", sqlConnection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Permiso", Entidad.Permiso);
            cmd.Parameters.AddWithValue("@IdUsuarioRegistra", Entidad.IdUsuarioRegistra);
            int ID = Convert.ToInt32(cmd.ExecuteScalar());
            sqlConnection.Close();
            sqlConnection.Dispose();
            return ID;
        }

        public static int Actualizar(Permisos Entidad)
        {
            SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
            sqlConnection.Open();
            SqlCommand cmd = new SqlCommand("ActualizarFormulario", sqlConnection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdPermiso", Entidad.IdPermiso);
            cmd.Parameters.AddWithValue("@Permiso", Entidad.Permiso);
            cmd.Parameters.AddWithValue("@IdUsuarioActualiza", Entidad.IdUsuarioActualiza);
            int ID = Convert.ToInt32(cmd.ExecuteScalar());
            sqlConnection.Close();
            sqlConnection.Dispose();
            return ID;
        }
        public static DataTable Select(Permisos Entidad)
        {
            SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
            sqlConnection.Open();
            SqlCommand cmd = new SqlCommand("SelectPermiso", sqlConnection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdPermiso", Entidad.IdPermiso);
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt = new DataTable();
            da.Fill(dt);
            sqlConnection.Close();
            sqlConnection.Dispose();
            da.Dispose();
            return dt;
        }
        public static bool Anular(Permisos Entidad)
        {
            try
            {
                SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
                sqlConnection.Open();
                SqlCommand Cmd = new SqlCommand("AnularPermiso", sqlConnection);
                Cmd.CommandType = CommandType.StoredProcedure;
                Cmd.Parameters.AddWithValue("@IdPermiso", Entidad.IdPermiso);
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

