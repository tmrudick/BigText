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
        private const int BIGTEXT_PADDING = 20;

        #region Setup
        // Constructor
        public MainPage()
        {
            InitializeComponent();
        }

        private void PhoneApplicationPage_Loaded(object sender, RoutedEventArgs e)
        {
            maxWidth = (int)App.Current.RootVisual.RenderSize.Height - (BIGTEXT_PADDING * 2);
            maxHeight = (int)App.Current.RootVisual.RenderSize.Width - (BIGTEXT_PADDING * 2);

            SetText("BigText");
        }
        #endregion

        #region Event Callbacks
        private void HiddenTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            SetText(HiddenTextBox.Text);
        }

        private void HiddenTextBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                this.Focus();
            }
            else if (e.Key == Key.Back && HiddenTextBox.Text.Length <= 1)
            {
                SetText("BigText");
            }
        }

        private void BigTextBlock_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            HiddenTextBox.Text = string.Empty; // Clear the last BigText entry
            HiddenTextBox.Focus(); // Force the keyboard to be shown
        }
        #endregion

        private void SetText(string text)
        {
            if (text.Trim() == string.Empty)
            {
                return;
            }

            // Set the text
            BigTextBlock.Text = text;

            // Set the size to zero and updat the layout
            // This is to reset the box
            BigTextBlock.FontSize = 0;
            BigTextBlock.UpdateLayout();

            // Loop and keep updating the font size until we find the biggest size that fits
            while (BigTextBlock.RenderSize.Width <= maxWidth && BigTextBlock.RenderSize.Height <= maxHeight)
            {
                BigTextBlock.FontSize += 1;
                BigTextBlock.UpdateLayout(); //Need this otherwise RenderSize doesn't change
            }

            // We are bigger than our display to kick it down a notch
            BigTextBlock.FontSize -= 1;
            BigTextBlock.UpdateLayout();
        }
    }
}