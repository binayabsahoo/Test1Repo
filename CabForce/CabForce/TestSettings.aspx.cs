using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CabForce
{
    public partial class TestSettings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             if (Session["sessionUserId"] != null)
           
            {
                if (!IsPostBack)
                {
                    SetPhoneNo();
                    SetUserName();
                }
                //SetPhoneNo();                
            }
             else
             {
                 Response.Redirect("AdminLogin.aspx", false);
             }
        }
        public void SetPhoneNo()

        {
            
                string selectphone = "select Pk_PhoneID,PhoneNumber from PhoneNO ";
                DBConnection obj = new DBConnection();
                SqlDataReader dr = obj.SqlDataReader(selectphone);
                while (dr.Read())
                {
                    txtPhoneNo.Text = Convert.ToString(dr["PhoneNumber"]);
                    hidPhone.Value = Convert.ToString(dr["Pk_PhoneID"]);
                }
            
        }
        public void SetUserName()
        {  
            int userid=Convert.ToInt32( Session["sessionUserId"]);
            string selectUname = "select username from Login where Login_Pk_ID = '" + userid + "'";
            DBConnection obj = new DBConnection();
            SqlDataReader dr = obj.SqlDataReader(selectUname);
            while (dr.Read())
            {
                txtUserName.Text = Convert.ToString(dr["UserName"]);
            }
        }

        protected void btnPhoneUpdate_Click(object sender, EventArgs e)
        {
            string updatephoneno = "update PhoneNO set PhoneNumber='" + txtPhoneNo.Text + "' where Pk_PhoneID= '" + hidPhone.Value + "'  ";
            DBConnection obj = new DBConnection();
            obj.ExecuteNonQuery(updatephoneno);
        }

         [System.Web.Services.WebMethod(EnableSession = true)]
        public static string checkLocationName(string IDVal)
        {
            string result = string.Empty;
            DBConnection obj = new DBConnection();
            DataSet ds = obj.GetData("select * from City where Location = '" + IDVal + "' ");
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

        protected void btnCityUpdate_Click(object sender, EventArgs e)
        {

            DBConnection obj = new DBConnection();
            DataSet ds = obj.GetData("select * from City where Location = '" + txtCity.Text + "' ");
            if (ds.Tables[0].Rows.Count > 0)
            {
                Label1.Text = " Duplicate UserName cannot be Saved";
            }
            else
            {
                obj.ExecuteNonQuery("insert into City(Location) values ('" + txtCity.Text + "')");
                Label1.Text = "Data Saved Successfully";
            }
            
        }

        protected void btnUnamePwd_Click(object sender, EventArgs e)
        {
            DBConnection obj = new DBConnection();
            try
            {
                string checkUserExist = "SELECT Login_Pk_ID FROM Login  WHERE UserName = @USER AND Login_Pk_ID != @Login_Pk_ID";

                SqlParameter[] paramUser = new SqlParameter[2];
                paramUser[0] = new SqlParameter("@User", SqlDbType.VarChar);
                paramUser[0].Value = txtUserName.Text;
                paramUser[1] = new SqlParameter("@Login_Pk_ID",SqlDbType.Int);
                paramUser[1].Value = Session["sessionUserId"];

                SqlDataReader dr = obj.SqlDataReader(checkUserExist, paramUser);
                if (dr.Read())
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Invalid", "<script>alert(\"User Name already present. Please enter other User Name.\")</script>");
                }
                else
                {//update
                    int pkid;
                    SqlParameter[] paramUserName = new SqlParameter[2];
                    paramUserName[0] = new SqlParameter("@User",SqlDbType.VarChar);
                    paramUserName[0].Value = txtUserName.Text;
                    paramUserName[1] = new SqlParameter("@Login_Pk_ID", SqlDbType.Int);
                    paramUserName[1].Value = Session["sessionUserId"];

                    SqlParameter[] paramUserPwd = new SqlParameter[3];
                    paramUserPwd[0] = new SqlParameter("@User", SqlDbType.VarChar);
                    paramUserPwd[0].Value = txtUserName.Text;
                    paramUserPwd[1] = new SqlParameter("@Password", SqlDbType.VarChar);
                    paramUserPwd[1].Value = txtPassword.Text;
                    paramUserPwd[2] = new SqlParameter("@Login_Pk_ID",SqlDbType.Int);
                    paramUserPwd[2].Value = Session["sessionUserId"];
                    string updateUnamePwd = "";
                    if (txtPassword.Text.ToString().Length > 0)
                    {
                        updateUnamePwd = "update Login set UserName=@User,Password=@Password where  Login_Pk_ID=@Login_Pk_ID ";
                       // pkid = obj.SqlExecuteScalar(updateUnamePwd, paramUserPwd);
                         obj.ExecuteNonQuery(updateUnamePwd, paramUserPwd);
                    }
                    else
                    {
                        updateUnamePwd = "update Login set UserName=@User where  Login_Pk_ID=@Login_Pk_ID";
                        //pkid = obj.SqlExecuteScalar(updateUnamePwd, paramUserName);
                        obj.ExecuteNonQuery(updateUnamePwd, paramUserName);
                    }
                    
                    
                    SetUserName();
                    
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Invalid", "<script>alert(\"Successfully changed Username/Password\")</script>");
                }

            }
            catch(Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

    }
}