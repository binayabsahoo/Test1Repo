using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

namespace CabForce
{
    public partial class ContactUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetPhoneNumber();
            }
        }
        public void SetPhoneNumber()
        {
            DBConnection obj = new DBConnection();
            SqlDataReader dr = obj.SqlDataReader("select PhoneNumber from PhoneNO");
            while (dr.Read())
            {
                lblPhoneNo.Text = Convert.ToString( dr["PhoneNumber"]);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Here is the new message for you");
            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("Nmae :");
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append(txtName.Text);
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</br>");

            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("Email :");
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append(txtEmail.Text);
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</br>");

            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("PhoneNumber :");
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append(lblPhoneNo.Text);
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</br>");

            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("Find Our Website :");
            sb.Append("</td>");
            if (drpFind.SelectedIndex > 0)
            {
                sb.Append("<td>");
                sb.Append(drpFind.SelectedItem.Text);
                sb.Append("</td>");
            }            
            sb.Append("</tr>");
            sb.Append("</br>");

            sb.Append("<tr>");
            sb.Append("<td>");
            sb.Append("Comment From User :");
            sb.Append("</td>");
            sb.Append("<td>");
            sb.Append(txtComments.Text);
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</br>");

            EmailFormat emailobj = new EmailFormat();
            string result = emailobj.SendEmail("binayabsahoo@gmail.com", "new message from'" + txtName.Text + "'", sb.ToString());
            ClientScript.RegisterStartupScript(this.GetType(), "Clear", "alert('Message sent successfully');Reset();", true);

        }
    }
}