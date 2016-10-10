using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using ExcelLibrary.Office.Excel;
namespace CabForce
{
    public partial class Report : System.Web.UI.Page
    {
        private const string ASCENDING = " ASC";
        private const string DESCENDING = " DESC";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sessionUserId"] != null)
            {
                if (!IsPostBack)
                {
                    GetReservatioReport();
                }
            }
            else
            {
                Response.Redirect("AdminLogin.aspx", false);
            }
        }

        protected DataSet GetReport(string fromDate = "", string toDate = "")
        {
            string appSql = string.Empty;
            if (fromDate.Length > 0 && toDate.Length > 0)
            {
                string frmDate = DateTime.Parse(fromDate).ToShortDateString();
                string tDate = DateTime.Parse(toDate).ToShortDateString();
                appSql = " WHERE Pickup_Date >= '" + frmDate + "' AND Pickup_Date <= '" + tDate + "' ";
            }
            DBConnection obj = new DBConnection();
            DataSet ds = obj.GetData("SELECT (First_Name+' '+Last_Name)as 'Name',Cell_Phone,Email_ID,Pick_Location,ct1.Location as Source,ct2.location as Destination,(convert(varchar(20),Pickup_Date)+' '+PickUp_Hour+':'+PickUp_Min+':'+PickUp_AMPM)as DateAndTime,No_of_Passengers, Payment_Mode,Special_Instruction,case when RoundTrip = 'True' then 'yes' when RoundTrip = 'false' then 'No' else 'Unvaliable' end As RoundTrip,ct3.Location as Round_Source,ct4.location as Round_Destination,Round_Pickup_Location,(convert(varchar(20),Round_Pickup_Date)+' '+Round_PickUp_Hour+':'+Round_PickUp_Min+':'+Round_PickUp_AMPM)as RoundDateTime,Round_No_of_Passengers FROM Reservation inner join City ct1  on Reservation.Source=ct1.pk_LocID inner join City ct2 on Reservation.Destination=ct2.pk_LocID  left join City ct3 on Reservation.Round_Source=ct3.pk_LocID left join City ct4 on Reservation.Round_Destination=ct4.pk_LocID " + appSql + " ");
            return ds;

        }

       

        public void GetReservatioReport()
        {
            string fromDate = txtFromDate.Text;
            string Todate = txtToDate.Text;
            DataSet ds = GetReport(fromDate, Todate);          

            
            if (ds.Tables[0].Rows.Count > 0)
            {
                GridReport.DataSource = ds;
                GridReport.DataBind();
                ViewState["datatable"] = ds.Tables[0];
            }
            else
            {
                ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());

                GridReport.DataSource = ds;

                GridReport.DataBind();

                int columncount = GridReport.Rows[0].Cells.Count;

                GridReport.Rows[0].Cells.Clear();

                GridReport.Rows[0].Cells.Add(new TableCell());

                GridReport.Rows[0].Cells[0].ColumnSpan = columncount;

                GridReport.Rows[0].Cells[0].Text = "No Records Found";
            }
        }

        protected void btnShow_Click(object sender, EventArgs e)
        {

            GetReservatioReport();
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

        protected void GridReport_Sorting(object sender, GridViewSortEventArgs e)
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
                RequiredList = GetReport().Tables[0];
            }

            ViewState["datatable"] = RequiredList;
            DataView dv = new DataView(RequiredList);

            dv.Sort = sortExpression + direction;

            GridReport.DataSource = dv;

            GridReport.DataBind();
        }

        protected void GridReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridReport.PageIndex = e.NewPageIndex;
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
                GetReservatioReport();
            }
        }

        protected void btnDownloadCsv_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();
                if (ViewState["datatable"] != null)
                {
                    dt = (DataTable)ViewState["datatable"];
                }
                else
                {
                    GetReservatioReport();
                }


                string path = Server.MapPath("~\\ExcelDownload\\") + DateTime.Now.Ticks.ToString() + ".xls";
                GenerateExcelReport(dt, path);
            }

            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        public void GenerateExcelReport(DataTable dt, string filePath)
        {
            try
            {
                Workbook XLSWorkBook = null;
                Worksheet XLSWorkSheet = null;

                XLSWorkBook = new Workbook();
                XLSWorkSheet = new Worksheet("Reservation Report");
                int totalColumn = dt.Columns.Count;
                int iColCount = 0;
                foreach (DataColumn dc in dt.Columns)
                {

                    XLSWorkSheet.Cells[0, iColCount] = new ExcelLibrary.Office.Excel.Cell(dc.ColumnName);
                    iColCount++;
                }

                int jColCount = 0;
                int lRowCount = 0;
                foreach (DataRow dr in dt.Rows)
                {
                    for (int k = 0; k < totalColumn; k++)
                    {
                        XLSWorkSheet.Cells[lRowCount + 1, jColCount] = new ExcelLibrary.Office.Excel.Cell(dr[k].ToString());
                        jColCount++;
                    }
                    lRowCount++;
                    jColCount = 0;
                }

                XLSWorkBook.Worksheets.Add(XLSWorkSheet);
                XLSWorkBook.Save(filePath);


                FileInfo file = new FileInfo(filePath);

                if (file.Exists)
                {
                    Response.ClearContent();
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
                    Response.AddHeader("Content-Length", file.Length.ToString());
                    Response.ContentType = "application/vnd.ms-excel";
                    Response.TransmitFile(file.FullName);
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void btnDownLoadPdf_Click(object sender, EventArgs e)
        {
            try
            {
                ExportToPDf();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

        }
        private void ExportToPDf()
        {
            DataTable dt = new DataTable();
            if (ViewState["datatable"] != null)
            {
                dt = (DataTable)ViewState["datatable"];
            }
           
            if (dt.Rows.Count > 0)
            {
                //  dt = RenameColumn(dt);
                Response.ContentType = "application/pdf";

                Response.AddHeader("content-disposition",

                    "attachment;filename=Report.pdf");

                Response.Cache.SetCacheability(HttpCacheability.NoCache);

                System.IO.StringWriter SW = new System.IO.StringWriter();

                StringBuilder oStringBuilder = new StringBuilder();


                oStringBuilder.Append("<Table  border=1 >");
                foreach (DataColumn oDataColumn in dt.Columns)
                {
                    oStringBuilder.Append("<TD ><b>" + oDataColumn.ColumnName + "</b></TD>");
                }

                oStringBuilder.Append("</TR>");


                foreach (DataRow oDataRow in dt.Rows)
                {
                    oStringBuilder.Append("<TR>");

                    foreach (DataColumn oDataColumn in dt.Columns)
                    {
                        oStringBuilder.Append("<TD>" + oDataRow[oDataColumn.ColumnName] + "</TD>");
                    }

                    oStringBuilder.Append("</TR>");
                }

                oStringBuilder.Append("</Table>");

                SW.WriteLine(oStringBuilder.ToString());

                HtmlTextWriter hw = new HtmlTextWriter(SW);

                StringReader sr = new StringReader(SW.ToString());

                Document pdfDoc = new Document(PageSize.B2, 0f, 0f, 0f, 0f);

                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);

                PdfWriter.GetInstance(pdfDoc, Response.OutputStream);

                pdfDoc.Open();

                htmlparser.Parse(sr);

                pdfDoc.Close();

                Response.Write(pdfDoc);

                Response.End();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "sucess", "<script>alert('There is no record to export');</script>");
            }

        }

        
    }
}