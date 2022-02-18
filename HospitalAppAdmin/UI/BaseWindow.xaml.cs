using HospitalAppAdmin.Entities;
using HospitalAppAdmin.UI;
using HospitalAppAdmin.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace HospitalAppAdmin
{
    /// <summary>
    /// Логика взаимодействия для BaseWindow.xaml
    /// </summary>
    public partial class BaseWindow : Window
    {
        private Entities.Doctor currentDoctor;
        public BaseWindow(User loginedUser)
        {
            InitializeComponent();
            ComboSpecialization.ItemsSource = App.DataBase.Specializations.ToList();
            ComboSpecialization.SelectedIndex = 0;
            DataContext = loginedUser;
            txtBlockUser.Text += "Вы авторизовались как: " + Manager.loginedUser.LastName + " " + Manager.loginedUser.FirstName;
        }

        private void ComboSpecialization_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var item = ComboSpecialization.SelectedItem as Entities.Specialization;
            if (item != null)
            {
                ComboDoctor.ItemsSource = App.DataBase.Doctors.ToList().Where(p => p.Specialization == item).ToList();
                ComboDoctor.SelectedIndex = 0;
            }
        }

        private void ComboDoctor_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedDoctor = ComboDoctor.SelectedItem as Entities.Doctor;
            if (selectedDoctor != null)
            {
                currentDoctor = selectedDoctor;
                DGridShedule.ItemsSource = App.DataBase.DoctorSchedules.ToList().Where(p => p.Doctor == selectedDoctor).ToList();
                TxtBlockDoctor.Text = selectedDoctor.FullName;
            }
        }

        private void BtnEdit_Click(object sender, RoutedEventArgs e)
        {
            var choosenDoctor = ComboDoctor.SelectedItem as Entities.Doctor;
            AddEditScheduleWindow add = new AddEditScheduleWindow((sender as Button).DataContext as Entities.DoctorSchedule, choosenDoctor);
            add.ShowDialog();
        }

        private void ComboSpecialization_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            TextBox search = sender as TextBox;
            if (search != null)
            {
                ComboSpecialization.ItemsSource = App.DataBase.Specializations.Where(p => p.Name.Contains(search.Text)).ToList();
            }

        }

        private void ComboDoctor_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            TextBox search = sender as TextBox;
            if (search != null)
            {
                ComboSpecialization.ItemsSource = App.DataBase.Doctors.Where(p => p.LastName.Contains(search.Text) || p.FirstName.Contains(search.Text) || p.Patronymic.Contains(search.Text)).ToList();
                ComboDoctor_SelectionChanged(sender, null);
            }
        }

        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            var choosenDoctor = ComboDoctor.SelectedItem as Entities.Doctor;
            AddEditScheduleWindow add = new AddEditScheduleWindow(new Entities.DoctorSchedule { Doctor = currentDoctor }, choosenDoctor);
            add.ShowDialog();
        }

        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            if (DGridShedule.SelectedItems.Count > 0)
            {
                var schedules = DGridShedule.SelectedItems.Cast<Entities.DoctorSchedule>().ToList();
                if (MessageBox.Show($"Вы точно хотите удалить следующие {schedules.Count()} элементов?", "", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
                {
                    try
                    {
                        App.DataBase.DoctorSchedules.RemoveRange(schedules);
                        App.DataBase.SaveChanges();
                        MessageBox.Show("Данные удалены!");
                        DGridShedule.ItemsSource = App.DataBase.DoctorSchedules.ToList().Where(p => p.Doctor == currentDoctor).ToList();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message.ToString());
                    }
                }
            }
            else
            {
                MessageBox.Show("Вы не выбрали ни одну запись для удаления!", "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void Window_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            DGridShedule.ItemsSource = App.DataBase.DoctorSchedules.ToList().Where(p => p.Doctor == currentDoctor).ToList();
        }

        private void BtnLogout_Click(object sender, RoutedEventArgs e)
        {
            AuthWindow auth = new AuthWindow();
            auth.Show();
            this.Close();
        }

        private void BtnPrint_Click(object sender, RoutedEventArgs e)
        {
            if (ComboDoctor.SelectedItem != null)
            {
                PrintDialog printDialog = new PrintDialog();
                if (printDialog.ShowDialog() == true)
                {
                    IDocumentPaginatorSource idpSource = flowDocumentAllData;
                    printDialog.PrintDocument(idpSource.DocumentPaginator, $"Report_AllData_From_{DateTime.Now.ToShortDateString()}");
                }
            }
            else
            {
                MessageBox.Show("Не выбран врач!", "Ошибка!", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
    }
}
