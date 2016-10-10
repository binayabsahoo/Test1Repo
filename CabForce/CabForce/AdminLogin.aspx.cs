using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace CabForce
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
               
                SqlParameter[] paramUser = new SqlParameter[2];
                paramUser[0] = new SqlParameter("@USER", SqlDbType.VarChar);
                paramUser[0].Value = txtUserName.Text;

                paramUser[1] = new SqlParameter("@PASSWD", SqlDbType.VarChar);
                paramUser[1].Value = txtPassword.Text;

                string checkUserExist = " select Login_Pk_ID from Login where UserName=@USER and Password=@PASSWD ";
                DBConnection obj = new DBConnection();
                SqlDataReader dr = obj.SqlDataReader(checkUserExist, paramUser);
                if (dr.Read())
                {
                    int userid=0;
                    userid= Convert.ToInt32(dr["Login_Pk_ID"]);
                    Session["sessionUserId"] = userid;
                    Response.Redirect("AboutUs.aspx", false);
                    
                }
                else
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Invalid", "<script>alert(\"Invalid Username  or Password\")</script>");
                }
            }
            catch(Exception ex)
            {
                Console.Write(ex);
            }
        }
    }
}