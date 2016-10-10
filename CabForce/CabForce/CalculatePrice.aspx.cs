using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CabForce
{
    public partial class CalculatePrice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlGenericControl body = this.Master.FindControl("MasterPageBodyTag") as HtmlGenericControl;
            body.Attributes.Add("onLoad", "initialize();");
            HtmlForm form = this.Master.FindControl("MasterPageFormTag") as HtmlForm;
            form.Attributes.Add("onsubmit", "showLocation();setDirectionsForMap(); return false;");
        }
    }
}