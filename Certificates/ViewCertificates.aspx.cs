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

namespace Certificates
{
    public partial class ViewCertificates : Page
    {
        #region Properties
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        DataTable dtData = null;
        SqlCommand sqlCmd = null;
        #endregion

        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            GetCertificateDetails();
        }

        protected void GetCertificateDetails()
        {
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                dtData = new DataTable();
                SqlCommand sqlCmd = new SqlCommand();
                sqlCmd = new SqlCommand("spApplications", conn);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                /*We need to pass rollno here through session
                 *  As of now we are doing it hard coded
                 */
                sqlCmd.Parameters.AddWithValue("@RollNo", 21130050);
                sqlCmd.Parameters.AddWithValue("@ActionType", "FetchSADetailsByRollNo");
                SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
                sqlSda.Fill(dtData);
                if (dtData != null && dtData.Rows.Count > 0)
                {
                    int count = 0;
                    grdCertificatesDetail.DataSource = dtData;
                    grdCertificatesDetail.DataBind();
                    countAppliedApplication.InnerText = dtData.Rows.Count.ToString();
                    grdRejectedApplications.DataSource = dtData;
                    grdRejectedApplications.DataBind();
                    for (int i = 0; i < grdRejectedApplications.Rows.Count; i++)
                    {

                        string adminRemarks = grdRejectedApplications.Rows[i].Cells[3].Text;
                        string examRemarks = grdRejectedApplications.Rows[i].Cells[4].Text;

                        if (adminRemarks != "&nbsp;" && !string.IsNullOrEmpty(adminRemarks))
                        {
                            count += 1;


                        }
                        else if (examRemarks != "&nbsp;" && !string.IsNullOrEmpty(examRemarks))
                        {
                            count += 1;


                        }
                        countRejectedApplications.InnerText = count.ToString();



                    }
                }
                else
                {
                    grdCertificatesDetail.DataSource = dtData;
                    grdCertificatesDetail.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                sqlCmd.Dispose();
                dtData.Dispose();
                conn.Close();
            }
        }
        #endregion

        protected void grdCertificatesDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                //Checking the RowType of the Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    string AppliedOn = e.Row.Cells[3].Text;
                    string date = AppliedOn.Substring(0, 11);
                    DateTime visitDate = DateTime.Parse(date);
                    //Label2.Text = visitDate.ToString("dd-MMM-yyyy");//30-May-2012 

                    // getting ShortTime from DateTime
                    // using Subtract() method;
                    TimeSpan value = DateTime.Now.Subtract(visitDate);

                    string certificateType = e.Row.Cells[1].Text;
                    //bool certificateVerified = (e.Row.Cells[5].Text)!="True" ? false : true;
                    //bool certificateReady = (e.Row.Cells[6].Text) != "True" ? false : true;

                    Label certificateVerified = (e.Row.FindControl("lblIsCertificateVerified") as Label);
                    Label certificateReady = (e.Row.FindControl("lblIsCertificateReady") as Label);

                    Label adminSectionRemarks = (e.Row.FindControl("lblAdminSectionRemarks") as Label);
                    Label examSectionRemarks = (e.Row.FindControl("lblExamSectionRemarks") as Label);

                    // e.Row.FindControl("lblIsCertificateVerified") as Label).Visible = false;
                    int appliedDays = value.Days;
                    if (certificateReady.Text == "True")
                    {
                        e.Row.Cells[4].Text = "Certificate ready";
                        e.Row.Cells[4].ToolTip = "Your " + certificateType + " is ready, please collect at college";
                        e.Row.BackColor = System.Drawing.Color.LightGreen;
                    }
                    else if (certificateVerified.Text == "True")
                    {
                        e.Row.Cells[4].Text = "Verified";
                        e.Row.Cells[4].ToolTip = "Your " + certificateType + " verification has been done";
                        e.Row.BackColor = System.Drawing.Color.Aqua;
                    }
                    else if (appliedDays <= 4)
                    {
                        e.Row.Cells[4].Text = "In progress";
                        e.Row.Cells[4].ToolTip = "Your certificate verification is in progress";
                        e.Row.BackColor = System.Drawing.Color.LightBlue;

                        //(e.Row.FindControl("btnGrievance") as Button).Text = "In progress";
                        //(e.Row.FindControl("btnGrievance") as Button).Visible = false;
                    }
                    else if (appliedDays > 4)
                    {
                        e.Row.BackColor = System.Drawing.Color.LightCoral;
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }

        protected void btnGrievance_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Grievance.aspx");
        }

     

        protected void grdRejectedApplications_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                //Checking the RowType of the Row
                if (e.Row.RowType == DataControlRowType.DataRow)
                {

                    Label certificateVerified = (e.Row.FindControl("lblIsCertificateVerified") as Label);
                    Label certificateType = (e.Row.FindControl("lblcertificateType") as Label);

                    Label adminSectionRemarks = (e.Row.FindControl("lblAdminSectionRemarks") as Label);
                    Label examSectionRemarks = (e.Row.FindControl("lblExamSectionRemarks") as Label);

                    if (adminSectionRemarks.Text == "&nbsp;" || string.IsNullOrEmpty(adminSectionRemarks.Text) && certificateType.Text != "Marks Certificate")
                    {
                        e.Row.Visible = false;

                    }
                    else if (examSectionRemarks.Text == "&nbsp;" || string.IsNullOrEmpty(examSectionRemarks.Text) && certificateType.Text =="Marks Certificate")
                    {
                        e.Row.Visible = false;

                    }
                    else
                    {
                        e.Row.Visible = true;
                        e.Row.BackColor = System.Drawing.Color.Red;
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }
    }
}