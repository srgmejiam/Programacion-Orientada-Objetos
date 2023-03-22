using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DAL;
using EL;

namespace Test
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Usuarios User = new Usuarios();
            User.IdUsuario = 0;
            User.NombreCompleto = "Antonio Mejia";
            User.Correo = "srx.alslsd.com";
            User.UserName = "alslsls";
           User.Password = Encoding.UTF8.GetBytes("123");
            User.IdRol = 1;
            //User.IdUsuarioActualiza = 1;
            User.IdUsuarioRegistra = 1;



            //DAL_Usuarios.Insertar(User);
            DataTable dt = new DataTable();
            dt = DAL_Usuarios.Select(User);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Console.WriteLine(dt.Rows[i][0].ToString() +"\t"+dt.Rows[i][1].ToString() +"\n");
            }
            Console.ReadLine();


        }
    }
}
