using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CabForce
{
    public class Order
    {
        public string First_name
        {
            get;
            set;
        }
        public string Last_name
        {
            get;
            set;
        }
        public string Home_phone_no
        {
            get;
            set;
        }
        public string Work_phone_no
        {
            get;
            set;
        }
        public string Cell_phone_no
        {
            get;
            set;
        }
        public string Email
        {
            get;
            set;
        }
        public string Confirm_email
        {
            get;
            set;
        }
        public string Pick_location
        {
            get;
            set;
        }
        public string From_place
        {
            get;
            set;
        }
        public string To_place
        {
            get;
            set;
        }
        public string Share_type
        {
            get;
            set;
        }
        public string pickup_date
        {
            get;
            set;
        }
        public string pick_up_hour
        {
            get;
            set;
        }
        public string pick_up_min
        {
            get;
            set;
        }
        public string pick_up_ampm
        {
            get;
            set;
        }
        public Boolean sms_required
        {
            get;
            set;
        }
        public int No_of_passengers
        {
            get;
            set;
        }
        public string special_instruction
        {
            get;
            set;
        }
        public Boolean RoundTrip
        {
            get;
            set;
        }
        public string PaymentMode
        {
            get;
            set;
        }

        public string Round_from_Location
        {
            get;
            set;
        }
        public string Round_to_Location
        {
            get;
            set;
        }
        public string Round_pick_up_Location
        {
            get;
            set;
        }
        public string Round_pick_up_date
        {
            get;
            set;
        }
        public string Round_pick_up_hour
        {
            get;
            set;
        }

        public string Round_pick_up_min
        {
            get;
            set;
        }
        public string Round_pick_up_ampm
        {
            get;
            set;
        }
        public int Round_No_ofPassengers
        {
            get;
            set;
        }
        public double Price
             
        {
            get;
            set;
        }
        public double Round_Trip_Price
        {
            get;
            set;
        }
       
    }
}