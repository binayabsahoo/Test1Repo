using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CabForce
{
    public partial class City : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DBConnection obj = new DBConnection();
            obj.ExecuteNonQuery("insert into City(Location) values ('"+txtCity.Text+"')");
        }
    }
}