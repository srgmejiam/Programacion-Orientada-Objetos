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
            string pass = txtPassword.Text;
            if (ckVerPassword.Checked)
            {
                txtPassword.UseSystemPasswordChar = false;
                txtPassword.Text = pass;
            }
        }
        #endregion


    }
}
