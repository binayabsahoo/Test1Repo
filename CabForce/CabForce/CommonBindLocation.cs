using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;

namespace CabForce
{
    public class CommonBindLocation
    {
        public void BindLocation(DropDownList ddl)
        {
            DBConnection obj = new DBConnection();
            DataSet ds = obj.GetData("select pk_LocID,Location from City");            
            ddl.DataValueField = "pk_LocID";
            ddl.DataTextField = "Location";
            ddl.DataSource = ds;
            ddl.DataBind();
        }
    }
}