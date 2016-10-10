using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace CabForce
{
    public class Error : System.Web.UI.Page
    {
        public void LogErrors(string error,string description, Page currentPage = null)
        {
            try
            {
                DBConnection obj = new DBConnection();
                obj.ExecuteNonQuery("insert into Error(Error,Created,Description) values ('" + error.Replace(",", "''") + "','" + DateTime.Now + "','" + description.Replace(",", "''") + "') ");
                if (currentPage != null)
                {
                    currentPage.ClientScript.RegisterStartupScript(typeof(Error), "showalert", "alert('Something went wrong please try later');", true);
                }
            }
            catch (Exception ex)
            {
                try
                {
                    string path = Server.MapPath("~\\Errorlog\\error.txt");
                    using (StreamWriter sw = new StreamWriter(path, true))
                    {
                        sw.WriteLine("---------------------------------------"); // Write the file.
                        sw.WriteLine(error);
                    }
                }
                catch (Exception exc)
                {
                    Response.Write(exc.Message);
                }
            }
        }
    }
}