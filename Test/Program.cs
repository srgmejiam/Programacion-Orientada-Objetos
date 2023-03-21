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
            User.NombreCompleto = "Marvin Mejia";
            User.Correo = "srgmejia@icloud.com";
            User.UserName= "mmejia";
            User.Password = Encoding.UTF8.GetBytes("123");
            User.IdRol = 1;
            User.IdUsuarioRegistra= 1;

            DAL_Usuarios.Insertar(User);
            

        }
    }
}
