using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;

namespace WP7BigText
{
    public partial class MainPage : PhoneApplicationPage
    {
        private int maxWidth, maxHeight;

        // Constructor
        public MainPage()
        {
            InitializeComponent();


        }

        private void EditBtn_Click(object sender, RoutedEventArgs e)
        {
            hiddenTextBox.Text = string.Empty;

            hiddenTextBox.Focus();
        }

        private void hiddenTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            SetText(hiddenTextBox.Text);
        }

        private void SetText(string text)
        {
            // Set the text
            bigTextBox.Text = text;

            // Set the size to zero and updat the layout
            // This is to reset the box
            bigTextBox.FontSize = 0;
            bigTextBox.UpdateLayout();

            // Loop and keep updating the font size until we find the biggest size that fits
            while (bigTextBox.RenderSize.Width <= maxWidth && bigTextBox.RenderSize.Height <= maxHeight)
            {
                bigTextBox.FontSize += 1;
                bigTextBox.UpdateLayout(); //Need this otherwise RenderSize doesn't change
            }

            // We are bigger than our display to kick it down a notch
            bigTextBox.FontSize -= 1;
            bigTextBox.UpdateLayout();
        }

        private void hiddenTextBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                this.Focus();
            }
        }

        private void bigTextBox_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {

            hiddenTextBox.Focus();
        }

        private void bigTextBox_MouseLeftButtonDown_1(object sender, MouseButtonEventArgs e)
        {
            hiddenTextBox.Text = string.Empty;
            hiddenTextBox.Focus();
        }

        private void PhoneApplicationPage_Loaded(object sender, RoutedEventArgs e)
        {
            maxWidth = (int)App.Current.RootVisual.RenderSize.Height - 40;
            maxHeight = (int)App.Current.RootVisual.RenderSize.Width - 40;
        }
    }
}