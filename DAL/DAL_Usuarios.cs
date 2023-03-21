using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using EL;

namespace DAL
{
    public static class DAL_Usuarios
    {
        public static int Insertar(Usuarios Entidad)
        {
            SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
            sqlConnection.Open();
            SqlCommand cmd = new SqlCommand("InsertarUsuario", sqlConnection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@NombreCompleto", Entidad.NombreCompleto);
            cmd.Parameters.AddWithValue("@Correo", Entidad.Correo);
            cmd.Parameters.AddWithValue("@UserName", Entidad.UserName);
            cmd.Parameters.AddWithValue("@Password", Entidad.Password);
            cmd.Parameters.AddWithValue("@IdRol", Entidad.IdRol);
            cmd.Parameters.AddWithValue("@IdUsuarioRegistra", Entidad.IdUsuarioRegistra);
            int ID = Convert.ToInt32(cmd.ExecuteScalar());
            sqlConnection.Close();
            sqlConnection.Dispose();
            return ID;

        }
    }
}
