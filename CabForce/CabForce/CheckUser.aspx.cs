using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CabForce
{
    public partial class CheckUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string checkUserName(string IDVal)
        {
            string result = string.Empty;
            DBConnection obj = new DBConnection();
            DataSet ds = obj.GetData("select * from TestUserName where UserName = '" + IDVal + "' ");
            if (ds.Tables[0].Rows.Count > 0)
            {
                result = "UserName already exits";
            }
            else
            {
                result = "UserName Available";
            }
            return result;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            DBConnection obj = new DBConnection();
            DataSet ds = obj.GetData("select * from TestUserName where UserName = '" + txtID.Text + "' ");
            if (ds.Tables[0].Rows.Count > 0)
            {
                Label1.Text = " Duplicate UserName cannot be Saved";
            }
            else
            {
                obj.ExecuteNonQuery("insert into TestUserName (UserName) values ('" + txtID.Text + "')");
                Label1.Text = "Data Saved Successfully";
            }
        }
    }
    
}