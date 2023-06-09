﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using EL;
using System.Data;

namespace DAL
{
    public static class DAL_Formularios
    {
        public static int Insertar(Formularios Entidad)
        {
            SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
            sqlConnection.Open();
            SqlCommand cmd = new SqlCommand("InsertarFormulario", sqlConnection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Formulario", Entidad.Formulario);
            cmd.Parameters.AddWithValue("@IdUsuarioRegistra", Entidad.IdUsuarioRegistra);
            int ID = Convert.ToInt32(cmd.ExecuteScalar());
            sqlConnection.Close();
            sqlConnection.Dispose();
            return ID;
        }

        public static int Actualizar(Formularios Entidad)
        {
            SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
            sqlConnection.Open();
            SqlCommand cmd = new SqlCommand("ActualizarFormulario", sqlConnection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdFormulario", Entidad.IdFormulario);
            cmd.Parameters.AddWithValue("@Formulario", Entidad.Formulario);
            cmd.Parameters.AddWithValue("@IdUsuarioActualiza", Entidad.IdUsuarioActualiza);
            int ID = Convert.ToInt32(cmd.ExecuteScalar());
            sqlConnection.Close();
            sqlConnection.Dispose();
            return ID;
        }
        public static DataTable Select(Formularios Entidad)
        {
            SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
            sqlConnection.Open();
            SqlCommand cmd = new SqlCommand("SelectFormulario", sqlConnection);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdFormulario", Entidad.IdFormulario);
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt = new DataTable();
            da.Fill(dt);
            sqlConnection.Close();
            sqlConnection.Dispose();
            da.Dispose();
            return dt;
        }
        public static bool Anular(Formularios Entidad)
        {
            try
            {
                SqlConnection sqlConnection = new SqlConnection(Conexion.ConexionString());
                sqlConnection.Open();
                SqlCommand Cmd = new SqlCommand("AnularFormulario", sqlConnection);
                Cmd.CommandType = CommandType.StoredProcedure;
                Cmd.Parameters.AddWithValue("@IdFormulario", Entidad.IdFormulario);
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
