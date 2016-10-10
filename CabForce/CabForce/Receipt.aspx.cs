using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.IO;

namespace CabForce
{
    public partial class Receipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                   
                    Order obj = (Order)Session["reserveproperty"];
                    //if (obj.PaymentMode == "CreditCard")
                    //{
                    //    BtnSubmit.Text = "Pay";
                    //}
                    rate.InnerHtml = Convert.ToString(obj.Price);
                    ReturnRate.InnerHtml = Convert.ToString(obj.Round_Trip_Price);
                    int total = Convert.ToInt32(obj.Price) + Convert.ToInt32(obj.Round_Trip_Price);
                    totalcost.InnerHtml = Convert.ToString(total);
                }
            }
            catch(Exception ex)

            {
                Console.Write(ex.Message);
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            Order obj = (Order)Session["reserveproperty"];
            //
            if (Session["reserveproperty"] != null)
            {
                string InsertReservation = "insert into Reservation(First_Name,Last_Name,Home_Phone,Cell_Phone,Work_Phone,Email_ID,Confirm_Email_ID,Pick_Location," +
               " Source,Destination,Share_Type,Pickup_Date,PickUp_Hour,PickUp_Min,PickUp_AMPM,RoundTrip,Need_Message,No_of_Passengers,Payment_Mode,Special_Instruction," +
               " Round_Source, Round_Destination,Round_Pickup_Location,Round_Pickup_Date,Round_PickUp_Hour,Round_PickUp_Min,Round_PickUp_AMPM,Round_No_of_Passengers)" +
               "Values(@FirstName,@LastName,@Home_Phone,@Cell_Phone,@Work_Phone,@EmailID,@ConfirmEmailID,@PickLocation,@Source,@Destination,@ShareType,@PickupDate,@PickUp_Hour,"+
               "@PickUpMin,@PickUpAMPM,@RoundTrip,@NeedMessage,@NoOfPassengers,@PaymentMode,@SpecialInstruction,@RoundSource,@RoundDestination,@RoundPickupLocation,"+
               " @RoundPickupDate,@RoundPickUpHour,@RoundPickUpMin,@RoundPickUpAMPM,@RoundNoOfPassengers )";

                SqlParameter [] param = new SqlParameter[28];
                param[0] = new SqlParameter("@FirstName", SqlDbType.VarChar);
                param[0].Value = obj.First_name;

                param[1] = new SqlParameter("@LastName", SqlDbType.VarChar);
                param[1].Value = obj.Last_name;

                param[2] = new SqlParameter("@Home_Phone", SqlDbType.VarChar);
                param[2].Value = obj.Home_phone_no;

                param[3] = new SqlParameter("@Cell_Phone", SqlDbType.VarChar);
                param[3].Value = obj.Cell_phone_no;

                param[4] = new SqlParameter("@Work_Phone", SqlDbType.VarChar);
                param[4].Value = obj.Work_phone_no;

                param[5] = new SqlParameter("@EmailID", SqlDbType.VarChar);
                param[5].Value = obj.Email;

                param[6] = new SqlParameter("@ConfirmEmailID", SqlDbType.VarChar);
                param[6].Value = obj.Confirm_email;

                param[7] = new SqlParameter("@PickLocation", SqlDbType.VarChar);
                param[7].Value = obj.Pick_location;


                param[8] = new SqlParameter("@Source", SqlDbType.VarChar);
                param[8].Value = obj.From_place;

                param[9] = new SqlParameter("@Destination", SqlDbType.VarChar);
                param[9].Value = obj.To_place;

                param[10] = new SqlParameter("@ShareType", SqlDbType.VarChar);
                param[10].Value = obj.Share_type;

                param[11] = new SqlParameter("@PickupDate", SqlDbType.Date);
                param[11].Value = obj.pickup_date;

                param[12] = new SqlParameter("@PickUp_Hour", SqlDbType.VarChar);
                param[12].Value = obj.pick_up_hour;

                param[13] = new SqlParameter("@PickUpMin", SqlDbType.VarChar);
                param[13].Value = obj.pick_up_min;

                param[14] = new SqlParameter("@PickUpAMPM", SqlDbType.VarChar);
                param[14].Value = obj.pick_up_ampm;

                param[15] = new SqlParameter("@RoundTrip", SqlDbType.VarChar);
                param[15].Value = obj.RoundTrip;

                param[16] = new SqlParameter("@NeedMessage", SqlDbType.Bit);
                param[16].Value = obj.sms_required;

                param[17] = new SqlParameter("@NoOfPassengers", SqlDbType.Int);
                param[17].Value = obj.No_of_passengers;

                param[18] = new SqlParameter("@PaymentMode", SqlDbType.VarChar);
                param[18].Value = obj.PaymentMode;

                param[19] = new SqlParameter("@SpecialInstruction", SqlDbType.VarChar);
                param[19].Value = obj.special_instruction;

                param[20] = new SqlParameter("@RoundSource", SqlDbType.VarChar);
                param[20].Value = obj.Round_from_Location;

                param[21] = new SqlParameter("@RoundDestination", SqlDbType.VarChar);
                param[21].Value = obj.Round_to_Location;


                param[22] = new SqlParameter("@RoundPickupLocation", SqlDbType.VarChar);
                param[22].Value = obj.Round_pick_up_Location;

                param[23] = new SqlParameter("@RoundPickupDate", SqlDbType.Date);
                if (obj.Round_pick_up_date == "")
                {
                    param[23].Value = null;
                }
                else
                {
                    param[23].Value = obj.Round_pick_up_date;
                }

                param[24] = new SqlParameter("@RoundPickUpHour", SqlDbType.VarChar);
                param[24].Value = obj.Round_pick_up_hour;

                param[25] = new SqlParameter("@RoundPickUpMin", SqlDbType.VarChar);
                param[25].Value = obj.Round_pick_up_min;


                param[26] = new SqlParameter("@RoundPickUpAMPM", SqlDbType.VarChar);
                param[26].Value = obj.Round_pick_up_ampm;

                param[27] = new SqlParameter("@RoundNoOfPassengers", SqlDbType.Int);
                param[27].Value = obj.Round_No_ofPassengers;

                DBConnection databaseObject = new DBConnection();
                databaseObject.ExecuteNonQuery(InsertReservation,param);
                EmailFormat emailobj = new EmailFormat();
                string str = hidden.Value;
                emailobj.SendEmail(obj.Email, "RegardingReservationDetails", str, null);

            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Reservation.aspx");
        }
    }
}