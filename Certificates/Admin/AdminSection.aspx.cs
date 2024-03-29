﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Collections;
using System.Drawing;
using System.Net;
using System.Data.SqlTypes;
using System.Globalization;

namespace Certificates
{
    public partial class AdminSection : Page
    {
        #region Properties
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        SqlDataAdapter adapt;
        static int ID = 0;
        DataSet ds = null;
        DataTable dtData = null;
        SqlCommand sqlCmd = null;
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
                GetAdminSectionCertificateDetails();
            }
            lblError.Text = string.Empty;
        }

        public string ConvertNullableBoolToYesNo(object pBool)
        {
            if (pBool != null)
            {
                return (bool)pBool ? "Yes" : "No";
            }
            else
            {
                return "No";
            }
        }

        protected void GetAdminSectionCertificateDetails(string sortExpression = null)
        {
            dvverifyStudentDetails.Visible = false;
            dvViewCertificate.Visible = false;
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
                        grdAdminFreshApplicationDetails.DataSource = dv;
                    }
                    else
                    {
                        grdAdminFreshApplicationDetails.DataSource = ds;
                    }
                    grdAdminFreshApplicationDetails.DataBind();
                    countFreshApplication.InnerText = ds.Tables[0].Rows.Count.ToString();
                    countFreshApplication.Attributes.Add("title", "Fresh Certificates");
                }
                else
                {
                    grdAdminFreshApplicationDetails.DataSource = ds.Tables[0];
                    grdAdminFreshApplicationDetails.DataBind();
                    countFreshApplication.InnerText = "0";
                }
                if (ds.Tables.Count > 0 && ds.Tables[1].Rows.Count > 0)
                {
                    if (sortExpression != null)
                    {
                        DataView dv = ds.Tables[1].AsDataView();
                        this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";

                        dv.Sort = sortExpression + " " + this.SortDirection;
                        grdAdminOverdueApplicationDetails.DataSource = dv;
                    }
                    else
                    {
                        grdAdminOverdueApplicationDetails.DataSource = ds.Tables[1];
                    }
                    grdAdminOverdueApplicationDetails.DataBind();
                    countOverdueApplications.InnerText = ds.Tables[1].Rows.Count.ToString();
                    countOverdueApplications.Attributes.Add("title", "Overdue Certificates");

                }
                else
                {
                    grdAdminOverdueApplicationDetails.DataSource = ds.Tables[1];
                    grdAdminOverdueApplicationDetails.DataBind();
                    countOverdueApplications.InnerText = "0";
                }
                if (ds.Tables.Count > 0 && ds.Tables[2].Rows.Count > 0)
                {
                    if (sortExpression != null)
                    {
                        DataView dv = ds.Tables[2].AsDataView();
                        this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";

                        dv.Sort = sortExpression + " " + this.SortDirection;
                        grdAdminVerifiedApplicationDetails.DataSource = dv;
                    }
                    else
                    {
                        grdAdminVerifiedApplicationDetails.DataSource = ds.Tables[2];
                    }
                    grdAdminVerifiedApplicationDetails.DataBind();
                    countVerifiedApplications.InnerText = ds.Tables[2].Rows.Count.ToString();
                    countVerifiedApplications.Attributes.Add("title", "Verified Certificates");
                }
                else
                {
                    grdAdminVerifiedApplicationDetails.DataSource = ds.Tables[2];
                    grdAdminVerifiedApplicationDetails.DataBind();
                    countVerifiedApplications.InnerText = "0";
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        protected void grdAdminApplicationDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            txtRemarks.Text = string.Empty;
            drpStatus.ClearSelection();
            if (e.CommandName == "EditRecord")
            {
                string[] arg = new string[13];
                arg = e.CommandArgument.ToString().Split(';');
                Session["Id"] = arg[0];
                Session["Name"] = arg[1];
                Session["CertificateType"] = arg[2];
                Session["IsAdminSectionVerified"] = arg[3];
                Session["IsExamSectionVerified"] = arg[4];
                Session["Parentage"] = arg[5];
                Session["DOB"] = arg[6];
                Session["VerifiedOn"] = arg[7];
                Session["AdminSectionRemarks"] = arg[8];
                Session["AppliedOn"] = arg[9];
                Session["IsLibrarySectionVerified"] = arg[10];
                Session["IsPhysicalEduSectionVerified"] = arg[11];
                Session["IsHostelSectionVerified"] = arg[12];

                dvverifyStudentDetails.Visible = true;
                dvViewCertificate.Visible = false;

                string certificateType = string.Empty;
                string isAdminVerified = string.Empty;
                string isExamVerified = string.Empty;
                string name = string.Empty;
                string parentage = string.Empty;
                string dob = string.Empty;
                string verifiedOn = string.Empty;
                string adminSectionRemarks = string.Empty;
                string appliedOn = string.Empty;

                if (!string.IsNullOrEmpty(Session["Id"].ToString()))
                {
                    ID = Convert.ToInt32(Session["Id"].ToString());
                }
                if (!string.IsNullOrEmpty(Session["Name"].ToString()))
                {
                    name = Session["Name"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["Parentage"].ToString()))
                {
                    parentage = Session["Parentage"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["DOB"].ToString()))
                {
                    dob = Session["DOB"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["CertificateType"].ToString()))
                {
                    certificateType = Session["CertificateType"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["IsAdminSectionVerified"].ToString()))
                {
                    isAdminVerified = Session["IsAdminSectionVerified"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["IsExamSectionVerified"].ToString()))
                {
                    isExamVerified = Session["IsExamSectionVerified"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["VerifiedOn"].ToString()))
                {
                    verifiedOn = Session["VerifiedOn"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["AdminSectionRemarks"].ToString()))
                {
                    adminSectionRemarks = Session["AdminSectionRemarks"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["AppliedOn"].ToString()))
                {
                    appliedOn = Session["AppliedOn"].ToString();
                }

                lblName.Text = name;
                lblParentage.Text = parentage;
                lblDOB.Text = dob;
                lblCertificateType.Text = certificateType;
                lblVerifiedOn.Text = verifiedOn;
                txtRemarks.Text = adminSectionRemarks;
                lblAppliedOn.Text = appliedOn;
                drpStatus.SelectedValue = isAdminVerified;
            }
            else if (e.CommandName == "ViewRecord")
            {
                string[] arg = new string[1];
                arg = e.CommandArgument.ToString().Split(';');
                Session["Id"] = arg[0];
                if (!string.IsNullOrEmpty(Session["Id"].ToString()))
                {
                    ID = Convert.ToInt32(Session["Id"].ToString());
                }
                try
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    dtData = new DataTable();
                    sqlCmd = new SqlCommand("spApplications", conn);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("@Id", ID);
                    sqlCmd.Parameters.AddWithValue("@ActionType", "FetchDataById");
                    SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
                    sqlSda.Fill(dtData);
                    if (dtData != null && dtData.Rows.Count > 0)
                    {
                        dvAcdGrid.Visible = false;
                        dvverifyStudentDetails.Visible = false;
                        dvViewCertificate.Visible = true;
                        grdAdminSectionCertificatesView.DataSource = dtData;
                        grdAdminSectionCertificatesView.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.Message;
                }
                finally
                {
                    dtData.Dispose();
                    sqlCmd.Dispose();
                    conn.Close();
                }
            }
        }

        private DataSet FetchApplicationDetails()
        {
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                ds = new DataSet();
                sqlCmd = new SqlCommand("spApplications", conn);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@ActionType", "FetchDataAdminSection");
                SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
                sqlSda.Fill(ds);
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
            finally
            {
                ds.Dispose();
            }
            return ds;
        }

        protected void grdAdminApplicationDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Checking the RowType of the Row
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label verified = (Label)e.Row.FindControl("lblVerified");
                string AppliedOn = e.Row.Cells[5].Text;
                string date = AppliedOn.Substring(0, 11);
                DateTime visitDate = DateTime.Parse(date);
                TimeSpan value = DateTime.Now.Subtract(visitDate);

                int appliedDays = value.Days;
                if (appliedDays > 5 && (verified.Text == "No" || verified.Text == string.Empty))
                {
                    int dys = appliedDays - 4;
                    e.Row.BackColor = System.Drawing.Color.LightCoral;
                    e.Row.ToolTip = "Application is overdue by " + dys + " day(s).";
                }

                else if (appliedDays >= 4 && (verified.Text == "No" || verified.Text == string.Empty))
                {
                    int dys = appliedDays - 4;
                    if (appliedDays > 4)
                    {
                        e.Row.BackColor = System.Drawing.Color.LightCoral;
                        e.Row.ToolTip = "Application is overdue by " + dys + " day(s).";
                    }
                    else
                    {
                        e.Row.BackColor = System.Drawing.Color.Blue;
                        e.Row.ToolTip = "Application is about to overdue in 1 day.";
                    }
                }
                else if (appliedDays == 1 && (verified.Text == "No" || verified.Text == string.Empty))
                {

                    e.Row.BackColor = System.Drawing.Color.LightBlue;
                }
                else if (appliedDays == 0 && (verified.Text == "No" || verified.Text == string.Empty))
                {

                    e.Row.BackColor = System.Drawing.Color.Aqua;
                }
                else if (verified.Text == "Yes")
                {
                    e.Row.BackColor = System.Drawing.Color.LightGreen;
                    e.Row.ToolTip = "Application is verified and scheduled for printing.";
                }
            }
        }
        #endregion

        protected void drpStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            dvverifyStudentDetails.Visible = true;
            dvViewCertificate.Visible = false;
            if (drpStatus.SelectedItem.Text == "Not Verified")
            {
                spRemarks.Visible = true;
                //rfvRemarks.IsValid = true;
                rfvRemarks.Enabled = true;
            }
            else
            {
                spRemarks.Visible = false;
                //rfvRemarks.IsValid = false;
                rfvRemarks.Enabled = false;
            }
        }
        protected void btnVerifyCertificate_Click(object sender, EventArgs e)
        {
            try
            {
                //UserId needs to fetch from table/Session
                string uid = "UserID";
                string machineName = System.Environment.MachineName;
                HttpBrowserCapabilities bc = Request.Browser;
                System.Web.HttpContext context = System.Web.HttpContext.Current;
                string ipAddress = "";
                // Get the IP
                ipAddress = Dns.GetHostEntry(machineName).AddressList[1].ToString();
                //UserID + UserMachineName / HostName + Browser + IPAddress + IsMobileDevice
                string examSectionVerifierEntries = uid + "^" + machineName + "^" + bc.Browser + "^" + ipAddress + "^" + bc.IsMobileDevice;

                string certificateType = string.Empty;
                string isAdminVerified = string.Empty;
                string isExamVerified = string.Empty;
                string isLibraryVerified = string.Empty;
                string isPhysicalEduVerified = string.Empty;
                string isHostelVerified = string.Empty;
                string name = string.Empty;
                string parentage = string.Empty;
                string dob = string.Empty;
                string verifiedOn = string.Empty;
                bool isCertificateVerified = false;
                if (Session["Id"] != null)
                {
                    ID = Convert.ToInt32(Session["Id"]);
                }
                if (Session["Name"] != null)
                {
                    name = Session["Name"].ToString();
                }
                if (Session["Parentage"] != null)
                {
                    parentage = Session["Parentage"].ToString();
                }
                if (Session["DOB"] != null)
                {
                    dob = Session["DOB"].ToString();
                }
                if (Session["CertificateType"] != null)
                {
                    certificateType = Session["CertificateType"].ToString();
                }
                if (Session["IsAdminSectionVerified"] != null)
                {
                    isAdminVerified = Session["IsAdminSectionVerified"].ToString();
                }
                if (Session["IsExamSectionVerified"] != null)
                {
                    isExamVerified = Session["IsExamSectionVerified"].ToString();
                }
                if (Session["VerifiedOn"] != null)
                {
                    verifiedOn = Session["VerifiedOn"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["IsLibrarySectionVerified"].ToString()))
                {
                    isLibraryVerified = Session["IsLibrarySectionVerified"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["IsPhysicalEduSectionVerified"].ToString()))
                {
                    isPhysicalEduVerified = Session["IsPhysicalEduSectionVerified"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["IsHostelSectionVerified"].ToString()))
                {
                    isHostelVerified = Session["IsHostelSectionVerified"].ToString();
                }
                if (drpStatus.SelectedItem.Value == "True" && (certificateType == "Bonafide/Studentship Certificate" ||
                    certificateType == "Discharge/Transfer Certificate" || certificateType == "Migration Certificate"))
                {
                    if (isLibraryVerified == "True" && isPhysicalEduVerified == "True" && isHostelVerified == "True")
                    {
                        isCertificateVerified = true;
                    }
                    else
                    {
                        isCertificateVerified = false;
                    }
                }
                else if (certificateType == "Provisional cum Character Certificate")
                {
                    if (isExamVerified == "True" && isLibraryVerified == "True" && isPhysicalEduVerified == "True" && isHostelVerified == "True")
                    {
                        isCertificateVerified = true;
                    }
                    else
                    {
                        isCertificateVerified = false;
                    }
                }
                try
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    dtData = new DataTable();
                    sqlCmd = new SqlCommand("spApplications", conn);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("@ActionType", "SaveDataAdminSection");
                    sqlCmd.Parameters.AddWithValue("@Id", ID);
                    sqlCmd.Parameters.AddWithValue("@AdminSectionVerifierEntries", examSectionVerifierEntries);
                    sqlCmd.Parameters.AddWithValue("@IsAdminSectionVerified", Convert.ToBoolean(drpStatus.SelectedItem.Value));
                    sqlCmd.Parameters.AddWithValue("@AdminSectionRemarks", txtRemarks.Text);
                    sqlCmd.Parameters.AddWithValue("@IsCertificateVerified", isCertificateVerified);
                    if (isCertificateVerified)
                    {
                        sqlCmd.Parameters.AddWithValue("@AdminSectionVerifiedOn", DateTime.Now);
                    }
                    else
                    {
                        sqlCmd.Parameters.AddWithValue("@AdminSectionVerifiedOn", DBNull.Value);
                    }
                    int numRes = sqlCmd.ExecuteNonQuery();
                    if (numRes > 0)
                    {
                        lblError.Text = "Record Updated Successfully";
                        lblError.ForeColor = System.Drawing.Color.CornflowerBlue;
                        lblError.Font.Size = 16;

                        dvverifyStudentDetails.Visible = false;
                        dvViewCertificate.Visible = false;
                        GetAdminSectionCertificateDetails();
                    }
                    else
                        lblError.Text = ("Please Try Again !!!");
                }
                catch (Exception ex)
                {
                    lblError.Text = ("Error:- " + ex.Message);
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
            finally
            {
                dtData.Dispose();
                sqlCmd.Dispose();
                conn.Close();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtRemarks.Text = string.Empty;
            dvverifyStudentDetails.Visible = false;
            dvViewCertificate.Visible = false;
            GetAdminSectionCertificateDetails();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            dvAcdGrid.Visible = true;
            dvverifyStudentDetails.Visible = false;
            dvViewCertificate.Visible = false;
            GetAdminSectionCertificateDetails();
        }

        protected void grdAdminFreshApplicationDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAdminFreshApplicationDetails.PageIndex = e.NewPageIndex;
            this.GetAdminSectionCertificateDetails();
        }

        protected void grdAdminFreshApplicationDetails_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.GetAdminSectionCertificateDetails(e.SortExpression);
        }

        protected void grdAdminOverdueApplicationDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAdminOverdueApplicationDetails.PageIndex = e.NewPageIndex;
            this.GetAdminSectionCertificateDetails();
        }

        protected void grdAdminOverdueApplicationDetails_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.GetAdminSectionCertificateDetails(e.SortExpression);
        }

        protected void grdAdminVerifiedApplicationDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAdminVerifiedApplicationDetails.PageIndex = e.NewPageIndex;
            this.GetAdminSectionCertificateDetails();
        }

        protected void grdAdminVerifiedApplicationDetails_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.GetAdminSectionCertificateDetails(e.SortExpression);
        }
    }
}
