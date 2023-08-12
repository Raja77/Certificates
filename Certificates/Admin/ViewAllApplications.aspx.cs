using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Collections;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.draw;
using System.Net;
using System.IO;
using iTextSharp.text.html.simpleparser;
using iTextSharp.tool.xml;

namespace Certificates
{
    public partial class ViewAllApplications : Page
    {
        #region Properties
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        SqlDataAdapter adapt;
        static int ID = 0;
        DataSet ds = null;
        DataTable dtData = null;
        SqlCommand sqlCmd = null;
        DataRow dr = null;

        private string SortDirection
        {
            get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        #endregion

        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetApplicationDetails();
            }
            lblError.Text = string.Empty;
        }

        protected void GetApplicationDetails(string sortExpression = null, int pageIndex=1)
        {
            try
            {
                ds = new DataSet();
                ds = FetchApplicationDetails();
                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    if (sortExpression != null)
                    {
                        DataView dv = ds.Tables[0].AsDataView();
                        this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";

                        dv.Sort = sortExpression + " " + this.SortDirection;
                        grdAllApplications.DataSource = dv;
                    }
                    else
                    {
                        grdAllApplications.DataSource = ds;
                    }
                    grdAllApplications.DataBind();




                    //grdAllApplications.DataSource = ds.Tables[0];
                    //grdAllApplications.DataBind();
                    countAllApplications.InnerText = ds.Tables[0].Rows.Count.ToString();
                    countAllApplications.Attributes.Add("title", "All Certificates");
                }
                else
                {
                    grdAllApplications.DataSource = ds.Tables[0];
                    grdAllApplications.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        #endregion
        private DataSet FetchApplicationDetails()
        {
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                // SqlCommand cmd = new SqlCommand("select * from Employe where Empname like'" + textinput.Text + "%'", con);

                ds = new DataSet();
                sqlCmd = new SqlCommand("spApplications", conn);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                if (txtRollNo.Text.Trim() != "")
                {
                    sqlCmd.Parameters.AddWithValue("@RollNo", txtRollNo.Text.Trim());
                }
                if (txtName.Text.Trim() != "")
                {
                    sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                }
                if (txtCertificateType.Text.Trim() != "")
                {
                    sqlCmd.Parameters.AddWithValue("@CertificateType", txtCertificateType.Text.Trim());
                }
                if (txtCourse.Text.Trim() != "")
                {
                    sqlCmd.Parameters.AddWithValue("@Course", txtCourse.Text.Trim());
                }
                if (txtFromDate.Text.Trim() != "")
                {
                    sqlCmd.Parameters.AddWithValue("@FromOrderDate", Convert.ToDateTime(txtFromDate.Text.Trim()).ToString("yyyy-MM-dd"));
                }
                if (txtToDate.Text.Trim() != "")
                {
                    sqlCmd.Parameters.AddWithValue("@ToOrderDate", Convert.ToDateTime(txtToDate.Text.Trim()).ToString("yyyy-MM-dd"));
                }
                sqlCmd.Parameters.AddWithValue("@ActionType", "FetchAllApplications");
                SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
                sqlSda.Fill(ds);
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
            finally
            {
                sqlCmd.Dispose();
                ds.Dispose();
                conn.Close();
            }
            return ds;
        }

        protected void grdAllApplications_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.GetApplicationDetails(e.SortExpression);
        }

        protected void grdAllApplications_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAllApplications.PageIndex = e.NewPageIndex;
            this.GetApplicationDetails();
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        public void GetPdf()
        {
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    grdAllApplications.HeaderRow.Style.Add("font-size", "12px");
                    grdAllApplications.Style.Add("font-family", "Arial, Helvetica, sans-serif;");
                    grdAllApplications.Style.Add("font-size", "14px");
                    grdAllApplications.PagerSettings.Visible = false;
                    grdAllApplications.AllowPaging = false;
                    grdAllApplications.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    Document pdfDoc = new Document(PageSize.A4, 7f, 7f, 7f, 0f);
                    //Document pdfDoc = new Document(PageSize.A2, 7f, 7f, 7f, 0f);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                    pdfDoc.Close();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=ExportData.pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            GetPdf();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetApplicationDetails();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.GetApplicationDetails("",1);
        }
    }
}