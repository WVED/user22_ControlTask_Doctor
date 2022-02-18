using HospitalAppAdmin.Utils;
using System.Linq;
using System.Windows;

namespace HospitalAppAdmin.UI
{
    /// <summary>
    /// Логика взаимодействия для AuthWindow.xaml
    /// </summary>
    public partial class AuthWindow : Window
    {
        public AuthWindow()
        {
            InitializeComponent();
        }

        private void BtnExit_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            if (txtBoxLogin.Text.Length > 0 && pswBox.Password.Length > 0)
            {
                var user = App.DataBase.Users.Where(p => p.Login == txtBoxLogin.Text && p.Password == pswBox.Password).FirstOrDefault();
                if (user != null)
                {
                    MessageBox.Show("Успешный вход", "Ифнормация", MessageBoxButton.OK, MessageBoxImage.Information);
                    Manager.loginedUser = user;
                    BaseWindow baseWindow = new BaseWindow(user);
                    baseWindow.Show();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Данные для входа не верны", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
            }
            else
            {
                MessageBox.Show("Логин или пароль не может быть пустым", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
    }
}
