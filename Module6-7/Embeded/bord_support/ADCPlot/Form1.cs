using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ADCPlot
{
    public partial class Form1 : Form
    {

        string PortName = "COM3";

        const int DISPLAY_POINTS = 20;

        SerialPort Port;

        List<int> adc0 = new List<int>();
        List<int> adc1 = new List<int>();
        List<int> adc2 = new List<int>();
        List<int> adc3 = new List<int>();

        List<int> xAxis = new List<int>();

        int PointCount = 0;
        int PointStart = 0;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            Port = new SerialPort(PortName, 9600, Parity.None, 8, StopBits.One);
            Port.DataReceived += Port_DataReceived;
            Port.Open();
        }

        private void PlotADC(string[] adcs)
        {
            try
            {
                adc0.Add(Convert.ToInt32(adcs[0]));
                adc1.Add(Convert.ToInt32(adcs[1]));
                adc2.Add(Convert.ToInt32(adcs[2]));
                adc3.Add(Convert.ToInt32(adcs[3]));

                PointCount++;

                if (PointCount < DISPLAY_POINTS)
                {
                    chart1.Series[0].Points.DataBindY(adc0);
                    chart1.Series[1].Points.DataBindY(adc1);
                    chart1.Series[2].Points.DataBindY(adc2);
                    chart1.Series[3].Points.DataBindY(adc3);
                }
                else
                {
                    xAxis.Clear();
                    for (int i = 0; i < DISPLAY_POINTS; i++)
                    {
                        xAxis.Add(i + PointStart);
                    }
                    PointStart++;

                    

                    chart1.Series[0].Points.DataBindXY(xAxis, adc0);
                    chart1.Series[1].Points.DataBindXY(xAxis, adc1);
                    chart1.Series[2].Points.DataBindXY(xAxis, adc2);
                    chart1.Series[3].Points.DataBindXY(xAxis, adc3);

                    adc0.RemoveAt(0);
                    adc1.RemoveAt(0);
                    adc2.RemoveAt(0);
                    adc3.RemoveAt(0);

                }
            }
            catch { }
        }


        private void Port_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string line = Port.ReadLine();
            line = line.Replace(":", "").Replace(" ", "").Replace("\r", "").Replace("\n", "");
            string[] adcs = line.Split(new string[] { "," }, StringSplitOptions.None);
            Invoke((MethodInvoker)(() => PlotADC(adcs)));
        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {
            if(Port.IsOpen)
            {
                Port.Close();
            }
        }
    }
}
