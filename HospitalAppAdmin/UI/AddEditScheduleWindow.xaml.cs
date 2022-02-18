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
using System.Windows.Shapes;

namespace HospitalAppAdmin.UI
{
    /// <summary>
    /// Логика взаимодействия для AddEditScheduleWindow.xaml
    /// </summary>
    public partial class AddEditScheduleWindow : Window
    {
        private Entities.DoctorSchedule doctorSchedule;
        private Entities.Doctor selectedDoctor;
        public AddEditScheduleWindow(Entities.DoctorSchedule doctorSchedule, Entities.Doctor choosenDoctor)
        {
            InitializeComponent();
            this.doctorSchedule = new Entities.DoctorSchedule();
            this.doctorSchedule = doctorSchedule;
            if (doctorSchedule.Date != new DateTime())
            {
                datePicker.SelectedDate = doctorSchedule.Date;
            }
            var minTime = TimeSpan.Parse("08:00");
            comboBoxFrom.Items.Add(minTime);
            for (int i = 0; i < 23; i++)
            {
                minTime += TimeSpan.FromMinutes(30);
                comboBoxFrom.Items.Add(minTime);
            }
            comboBoxTo.ItemsSource = comboBoxFrom.Items;
            DataContext = this.doctorSchedule;
            selectedDoctor = choosenDoctor;
        }

        private void datePicker_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            doctorSchedule.Date = (DateTime)datePicker.SelectedDate;
        }

        private void comboBoxFrom_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            List<TimeSpan> data = comboBoxTo.ItemsSource.Cast<TimeSpan>().ToList();
            data.Remove((TimeSpan)comboBoxFrom.SelectedItem);
            comboBoxTo.ItemsSource = data;
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (datePicker.SelectedDate == null)
            {
                errors.AppendLine("Вы не выбрали дату");
            }
            if (comboBoxFrom.SelectedItem == null)
            {
                errors.AppendLine("Вы не ввели начало смены");
            }
            if (comboBoxTo.SelectedItem == null)
            {
                errors.AppendLine("Вы не ввели конец смены");
            }
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            if (App.DataBase.DoctorSchedules.ToList().Where(p => selectedDoctor.IsActual == false).ToList().Count != 0)
            {
                MessageBox.Show("Ошибка!", "Данный врач находится на больничном!", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                doctorSchedule.StartTime = TimeSpan.Parse(comboBoxFrom.SelectedItem.ToString());
                doctorSchedule.EndTime = TimeSpan.Parse(comboBoxTo.SelectedItem.ToString());
                if (doctorSchedule.Id == 0)
                {
                    if (App.DataBase.DoctorSchedules.ToList().Where(p => p.Date == doctorSchedule.Date && p.Doctor == doctorSchedule.Doctor).ToList().Count > 0)
                    {
                        MessageBox.Show("На данную дату у врача: " + doctorSchedule.Doctor.LastName + " " + doctorSchedule.Doctor.FirstName + " уже есть смена!");
                    }
                    else
                    {
                        App.DataBase.DoctorSchedules.Add(doctorSchedule);
                        App.DataBase.SaveChanges();
                        MessageBox.Show("Данные успешно сохранены");
                    }
                }
                else
                {
                    App.DataBase.SaveChanges();
                    MessageBox.Show("Данные успешно сохранены");
                }
                this.Close();
            }
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
