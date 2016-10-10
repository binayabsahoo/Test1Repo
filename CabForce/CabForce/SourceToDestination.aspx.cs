using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;


namespace CabForce
{
    public partial class SourceToDestination : System.Web.UI.Page
    {
        private const string ASCENDING = " ASC";
        private const string DESCENDING = " DESC";
        int x = 15;
        int y = 0;
        int z;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    GetGridAddRate();
                    BindDropDown();
                }
               
            }
            catch(Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace, Page);
            }
        }
        protected void BindDropDown()
        {
            try
            {
                CommonBindLocation obj = new CommonBindLocation();
                obj.BindLocation(ddlSource);
                obj.BindLocation(ddlDestination);
                ListItem lst = new ListItem("--Select--", "0");
                ddlSource.Items.Insert(0, lst);
                ddlDestination.Items.Insert(0, lst);
            }
            catch (Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace, Page);

            }
        }

        protected DataSet GetRate()
        {
            DBConnection obj = new DBConnection();
            DataSet ds = obj.GetData("select ct1.Location as source,ct2.Location as destination,AddPk_ID,Sharetype,Charges,PaymentType,Loop,Journeytime from tbl_Rate  inner join City ct1 on tbl_Rate.Source = ct1.pk_LocID inner join City ct2 on tbl_Rate.Destination = ct2.pk_LocID");
            return ds;

        }
        protected void GetGridAddRate()
        {
            try
            {
                DataSet ds = GetRate();
                if (ds.Tables[0].Rows.Count > 0)
                {

                    gridRate.DataSource = ds;
                    gridRate.DataBind();
                    ViewState["datatable"] = ds.Tables[0];
                }
                else
                {

                    ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());

                    gridRate.DataSource = ds;

                    gridRate.DataBind();

                    int columncount = gridRate.Rows[0].Cells.Count;

                    gridRate.Rows[0].Cells.Clear();

                    gridRate.Rows[0].Cells.Add(new TableCell());

                    gridRate.Rows[0].Cells[0].ColumnSpan = columncount;

                    gridRate.Rows[0].Cells[0].Text = "No Records Found";

                }
            }
            catch (Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace, Page);
            }
            
        }
        

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                DBConnection obj = new DBConnection();
                obj.ExecuteNonQuery("insert into tbl_Rate values('" + ddlSource.SelectedItem.Value + "','" + ddlDestination.SelectedItem.Value + "','" + ddlsharetype.SelectedItem.Value + "','" + txtCharge.Text + "','" + radioPayment.SelectedItem.Value + "','" + txtLoop.Text + "','"+txtRoundcharge.Text+"','" + txtJourney.Text + "')");
                ucNotification.ShowNotification(NotificationTypes.Success, "Data saved Successfully");
            }
            catch (Exception ex)
            {
                ucNotification.ShowNotification(NotificationTypes.Failure, "Alert", ex.ToString());
            }
            GetGridAddRate();
        }
        protected void gridRate_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gridRate.EditIndex = e.NewEditIndex;

            GetGridAddRate();
        }

        protected void gridRate_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int userid = Convert.ToInt32(gridRate.DataKeys[e.RowIndex].Value.ToString());
                GridViewRow row = (GridViewRow)gridRate.Rows[e.RowIndex];
                //TextBox txtJourneyFrom = (TextBox)row.Cells[1].Controls[0];
                //TextBox txtJourneyTo = (TextBox)row.Cells[2].Controls[0];
                TextBox txtSingleOrShared = (TextBox)row.Cells[3].Controls[0];
                TextBox txtTariff = (TextBox)row.Cells[4].Controls[0];
                TextBox txtPaymentMode = (TextBox)row.Cells[5].Controls[0];
                TextBox txtTripMode = (TextBox)row.Cells[6].Controls[0];
                TextBox txtDuration = (TextBox)row.Cells[7].Controls[0];
                gridRate.EditIndex = -1;
                DBConnection obj = new DBConnection();
                obj.ExecuteNonQuery("update tbl_Rate set Sharetype='" + txtSingleOrShared.Text + "',Charges='" + txtTariff.Text + "',PaymentType='" + txtPaymentMode.Text + "',Loop='" + txtTripMode.Text + "',Journeytime='" + txtDuration.Text + "' where AddPk_ID='" + userid + "'");
                GetGridAddRate();
            }
            catch (Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace, Page);
            }
        }

        protected void gridRate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gridRate.EditIndex = -1;
            GetGridAddRate();
        }
         private SortDirection GridViewSortDirection
        {

            get
            {

                if (ViewState["sortDirection"] == null)

                    ViewState["sortDirection"] = SortDirection.Descending;

                return (SortDirection)ViewState["sortDirection"];

            }

            set { ViewState["sortDirection"] = value; }

        }

        protected void gridRate_Sorting(object sender, GridViewSortEventArgs e)
        {
             string sortExpression = e.SortExpression;

            ViewState["SortExpression"] = sortExpression;

            if (GridViewSortDirection == SortDirection.Ascending)
            {
                GridViewSortDirection = SortDirection.Descending;
                SortGridView(sortExpression, DESCENDING);
            }
            else
            {
                GridViewSortDirection = SortDirection.Ascending;
                SortGridView(sortExpression, ASCENDING);
            }
        }
        private void SortGridView(string sortExpression, string direction)
        {

            //  Here we are going to sort the  gridview  depending on the column selected and  the direction of sorting
            DataTable RequiredList = new DataTable();
            if (ViewState["datatable"] != null)
            {
                RequiredList = (DataTable)ViewState["datatable"];
            }
            else
            {
                RequiredList = GetRate().Tables[0];
            }

            ViewState["datatable"] = RequiredList;
            DataView dv = new DataView(RequiredList);

            dv.Sort = sortExpression + direction;

            gridRate.DataSource = dv;

            gridRate.DataBind();
        }

        protected void gridRate_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridRate.PageIndex = e.NewPageIndex;
            if (ViewState["SortExpression"] != null)
            {
                if (Convert.ToString(GridViewSortDirection).ToLower().CompareTo("ascending") == 0)
                {
                    SortGridView((string)ViewState["SortExpression"], ASCENDING);
                }
                else
                {
                    SortGridView((string)ViewState["SortExpression"], DESCENDING);
                }
            }
            else
            {
                GetGridAddRate();
            }
        }

        protected void gridRate_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userid = Convert.ToInt32(gridRate.DataKeys[e.RowIndex].Value.ToString());
            DBConnection obj = new DBConnection();
            obj.ExecuteNonQuery("delete from tbl_Rate where AddPk_ID='" + userid + "'  ");
            GetGridAddRate();
        }

      
    }

    
  
 
  

}