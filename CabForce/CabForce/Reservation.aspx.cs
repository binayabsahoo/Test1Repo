using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace CabForce
{
    public partial class Reservation : System.Web.UI.Page
    {
        int charge;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropDown();
                SetPayment();
                Session["order"] = null;
            }
        }
        public void BindDropDown()
        {
            CommonBindLocation obj = new CommonBindLocation();
            obj.BindLocation(ddlFrom);
            obj.BindLocation(ddlTo);
            obj.BindLocation(ddlRoundFrom);
            obj.BindLocation(ddlRoundTo);                       
            ListItem lst = new ListItem("--Select--", "0");
            ddlFrom.Items.Insert(0, lst);
            ddlTo.Items.Insert(0, lst);
            ddlRoundFrom.Items.Insert(0, lst);
            ddlRoundTo.Items.Insert(0,lst);
            
        }
        protected int SetPayment()
        {
            DBConnection obj = new DBConnection();
            SqlDataReader dr = obj.SqlDataReader("select * from tbl_Rate where Source='"+ddlFrom.SelectedItem.Value+"' And Destination='"+ddlTo.SelectedItem.Value+"' ");
            while (dr.Read())
            {
                charge = Convert.ToInt32 (dr["Charges"]);


            }
            return charge;
        }
        protected int SetReturnPayment()
        {
            DBConnection obj = new DBConnection();
            SqlDataReader dr = obj.SqlDataReader("select * from tbl_Rate where Source='" + ddlFrom.SelectedItem.Value + "' And Destination='" + ddlTo.SelectedItem.Value + "' ");
            while (dr.Read())
            {
                charge = Convert.ToInt32(dr["RoundtripCharges"]);


            }
            return charge;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Order order = new Order();
            order.First_name = txtFirstName.Text;
            order.Last_name = txtLastname.Text;
            order.Home_phone_no = txtHomePhone.Text + txtHomePhone1.Text + txtHomePhone2.Text;
            order.Cell_phone_no = txtCellNo.Text + txtCellNo1.Text + txtCellNo2.Text;
            order.Work_phone_no = txtWorkNo.Text + txtWorkNo1.Text + txtWorkNo2.Text;
            order.Email = txtEmail.Text;
            order.Confirm_email = txtConfirmEmail.Text;
            order.Pick_location = txtpickUp.Text;
            order.From_place = ddlFrom.SelectedItem.Value;
            order.To_place = ddlTo.SelectedItem.Value;
            order.Share_type = ddlShare.SelectedItem.Text;
            order.pickup_date = txtPickupDate.Text;
            order.pick_up_hour = ddlHours.SelectedItem.Text;
            order.pick_up_min = ddlMin.SelectedItem.Text;
            order.pick_up_ampm = ddlAmPm.SelectedItem.Text;
            order.sms_required = chkSms.Checked == true ? true : false;
            order.No_of_passengers =Convert.ToInt32( rdPass.SelectedItem.Value);
            order.special_instruction = txtInst.Text;
            if(rdYesRound.Checked)
            {
                order.RoundTrip= true; 
            }
            else{
                order.RoundTrip = false; 
            }
            if (rdCredit.Checked == true)
            {
                order.PaymentMode = "CreditCard";
            }
            else
            {
                if (rdCash.Checked == true)
                {
                    order.PaymentMode = "Cash";
                }
            }
            order.Round_from_Location = ddlRoundFrom.SelectedItem.Value;
            order.Round_to_Location = ddlRoundTo.SelectedItem.Value;
            order.Round_pick_up_Location = txtRoundPickupLocation.Text;
            order.Round_pick_up_date = txtRoundPickUp.Text;
            order.Round_pick_up_hour = ddlRoundHour.SelectedItem.Text;
            order.Round_pick_up_min = ddlRoundMin.SelectedItem.Text;
            order.Round_pick_up_ampm = ddlRoundAmPm.SelectedItem.Text;
            order.Round_No_ofPassengers =Convert.ToInt32( rdRoundPass.SelectedItem.Value);
            order.Price = SetPayment();
            order.Round_Trip_Price = SetReturnPayment();
            Session["reserveproperty"] = order;
            
            Server.Transfer("Receipt.aspx",false);
        }
    }
    
}