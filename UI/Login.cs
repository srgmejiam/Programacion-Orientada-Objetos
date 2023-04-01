using BL;
using EL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UI
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void Login_Load(object sender, EventArgs e)
        {

        }

        #region Metodos y Funciones
        private bool ValidarAcceso()
        {
            if (string.IsNullOrEmpty(txtUsuario.Text) || string.IsNullOrWhiteSpace(txtUsuario.Text))
            {
                MessageBox.Show("Ingrese el Usuario", "Alerta", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            if (string.IsNullOrEmpty(txtPassword.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                MessageBox.Show("Ingrese la Contraseña", "Alerta", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            if (!BL_Usuarios.ValidarUsuario(txtUsuario.Text))
            {
                MessageBox.Show("Credenciales Incorrectas", "Alerta", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            byte[] Password = UTF8Encoding.UTF8.GetBytes(txtPassword.Text);
            if (!BL_Usuarios.ValidarCredenciales(txtUsuario.Text, Password))
            {
                MessageBox.Show("Credenciales Incorrectas", "Alerta", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }

            VariableGlobales.IdUsuarioGl = Convert.ToInt32(BL_Usuarios.Select_x_UserName(txtUsuario.Text).Rows[0][0].ToString());




            Principal principal = new Principal();
            principal.Show();

            return true;
        }
        #endregion

        #region Evento de los Controles
        private void btnIngresar_Click(object sender, EventArgs e)
        {
            ValidarAcceso();
        }
        private void ckVerPassword_CheckedChanged(object sender, EventArgs e)
        {
            if (ckVerPassword.Checked)
            {
                txtPassword.UseSystemPasswordChar = false;
                return;
            }
            txtPassword.UseSystemPasswordChar = true;
            return;
        }
        #endregion


    }
}
