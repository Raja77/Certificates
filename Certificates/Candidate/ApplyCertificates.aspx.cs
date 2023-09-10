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
    public partial class ApplyCertificates : Page
    {
        #region Properties
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        DataTable dtData = null;
        SqlCommand sqlCmd = null;
        public String programme
        {
            get
            {
                if (ViewState["programme"] == null)
                {
                    ViewState["programme"] = String.Empty;
                }
                return ViewState["programme"].ToString();
            }
            set
            {
                ViewState["programme"] = value;
            }
        }

        public String stuName
        {
            get
            {
                if (ViewState["stuName"] == null)
                {
                    ViewState["stuName"] = String.Empty;
                }
                return ViewState["stuName"].ToString();
            }
            set
            {
                ViewState["stuName"] = value;
            }
        }

        public String AppliedDate
        {
            get
            {
                if (ViewState["AppliedDate"] == null)
                {
                    ViewState["AppliedDate"] = String.Empty;
                }
                return ViewState["AppliedDate"].ToString();
            }
            set
            {
                ViewState["AppliedDate"] = value;
            }
        }

        public String Marks
        {
            get
            {
                if (ViewState["OTP"] == null)
                {
                    ViewState["OTP"] = String.Empty;
                }
                return ViewState["OTP"].ToString();
            }
            set
            {
                ViewState["OTP"] = value;
            }
        }
        public String OTP
        {
            get
            {
                if (ViewState["OTP"] == null)
                {
                    ViewState["OTP"] = String.Empty;
                }
                return ViewState["OTP"].ToString();
            }
            set
            {
                ViewState["OTP"] = value;
            }
        }

        public bool IsOTPChecked
        {
            get
            {
                if (ViewState["IsOTPChecked"] == null)
                {
                    ViewState["IsOTPChecked"] = false;
                }
                return (bool.Parse(ViewState["IsOTPChecked"].ToString()));
            }
            set
            {
                ViewState["IsOTPChecked"] = value;
            }
        }
        #endregion

        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Session["RollNo"].ToString()))
            {
                txtRollNo.Text = Session["RollNo"].ToString();
                txtRollNo.Enabled = false;
            }
            lblError.Text = string.Empty;
        }

        protected DataTable FetchStudentDetailsByRollNo()
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            dtData = new DataTable();
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd = new SqlCommand("spApplications", conn);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@RollNo", txtRollNo.Text);
            sqlCmd.Parameters.AddWithValue("@ActionType", "FetchStuDetailsByRollNo");
            SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
            sqlSda.Fill(dtData);
            return dtData;
        }

        protected void btnCheckDetails_Click(object sender, EventArgs e)
        {
            try
            {
                dtData = new DataTable();
                if (OTP.Equals(txtValidateOTP.Text.Trim()))
                {
                    dtData = FetchStudentDetailsByRollNo();
                    if (dtData != null && dtData.Rows.Count > 0)
                    {
                        dvCertificates.Visible = true;
                        dvCheckDetailsX.Visible= true;
                        grdStudentsDetail.DataSource = dtData;
                        grdStudentsDetail.DataBind();

                        foreach (GridViewRow r in grdStudentsDetail.Rows)
                        {
                            String programmeName = (r.FindControl("lblCourseapplied") as Label).Text;
                            programme = programmeName;

                            String StudentName = (r.FindControl("lblName") as Label).Text;
                            stuName = StudentName;
                        }
                        chkDetails.Visible = false;
                    }
                    else
                    {
                        lblError.Text = "Enter valid roll no!";
                        grdStudentsDetail.DataSource = dtData;
                        grdStudentsDetail.DataBind();
                        dvCertificates.Visible = false;
                        dvCheckDetailsX.Visible = false;
                    }
                }
                else
                {
                    lblInvalidOTP.Visible = true;
                    lblInvalidOTP.Text = "Invalid OTP";
                }
            }

            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
            finally
            {
                dtData.Dispose();
                conn.Close();
            }
        }
        #endregion

        protected void btnApplyCertificate_Click(object sender, EventArgs e)
        {
            try
            {
                int batchSession = 0;
                bool flagBatchCheck = false;
                if (!string.IsNullOrEmpty(Session["Batch"].ToString()))
                {
                    batchSession = Convert.ToInt32(Session["Batch"]);
                    if (!(batchSession <= DateTime.Now.Year - 3))
                    {
                        if (drpCertificates.SelectedItem.Value == "ProvCharCert")
                        {
                            lblError1.Visible = true;
                            lblError1.Text = "Dear " + stuName + ", you are not yet eligible to apply for <strong>" + drpCertificates.SelectedItem.Text +
                              "</strong>. As your Batch is <strong>" + batchSession + "</strong>. Thanks.";
                            lblError1.ForeColor = System.Drawing.Color.Red;
                            flagBatchCheck = true;
                        }
                    }
                }
                if (!flagBatchCheck)
                {
                    lblError1.Visible = false;
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    dtData = new DataTable();
                    SqlCommand sqlCmd = new SqlCommand();
                    sqlCmd = new SqlCommand("spApplications", conn);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("@RollNo", txtRollNo.Text);
                    sqlCmd.Parameters.AddWithValue("@CertificateType", drpCertificates.SelectedItem.Text);
                    sqlCmd.Parameters.AddWithValue("@ActionType", "FetchSADetailsByRNnCert");
                    SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
                    sqlSda.Fill(dtData);
                    if (dtData != null && dtData.Rows.Count > 0)
                    {
                        string date = dtData.Rows[0]["AppliedOn"].ToString();
                        date = Convert.ToDateTime(date).Date.ToString("dd-MMM-yyyy");
                        lblError1.Visible = true;
                        lblError1.Text = "Dear " + stuName + ", you have already applied on <strong>" + date + "</strong> for <strong>" + drpCertificates.SelectedItem.Text +
                          "</strong>. We will get back to you once it has been verified. Thanks.";
                        lblError1.ForeColor = System.Drawing.Color.Blue;
                    }
                    else
                    {
                        string ExamAdminTypeValue = string.Empty;
                        if (drpCertificates.SelectedItem.Value == "ProvCharCert")
                        {
                            ExamAdminTypeValue = "EA";
                        }

                        else if (drpCertificates.SelectedItem.Value == "MarksCert")
                        {
                            ExamAdminTypeValue = "E";
                        }
                        else if (drpCertificates.SelectedItem.Value == "BonaStudCert" ||
                            drpCertificates.SelectedItem.Value == "DischargeCert" || drpCertificates.SelectedItem.Value == "MigrationCert")
                        {
                            ExamAdminTypeValue = "A";
                        }

                        bool IsExamSectionVerified = false;
                        bool IsAdminSectionVerified = false;

                        if (conn.State == ConnectionState.Closed)
                        {
                            conn.Open();
                        }
                        dtData = new DataTable();
                        sqlCmd = new SqlCommand("spApplications", conn);
                        sqlCmd.CommandType = CommandType.StoredProcedure;
                        sqlCmd.Parameters.AddWithValue("@ActionType", "SaveStuAppDetails");
                        sqlCmd.Parameters.AddWithValue("@RollNo", txtRollNo.Text);
                        sqlCmd.Parameters.AddWithValue("@CertificateType", drpCertificates.SelectedItem.Text);
                        /*
                         * Here we need to put Payment status 
                         * As of now it is always true
                         */
                        sqlCmd.Parameters.AddWithValue("@PaymentStatus", true);
                        sqlCmd.Parameters.AddWithValue("@AppliedOn", DateTime.Now);
                        sqlCmd.Parameters.AddWithValue("@ExamAdminTypeValue", ExamAdminTypeValue);
                        sqlCmd.Parameters.AddWithValue("@IsExamSectionVerified", IsExamSectionVerified);
                        sqlCmd.Parameters.AddWithValue("@IsAdminSectionVerified", IsAdminSectionVerified);
                        int numRes = sqlCmd.ExecuteNonQuery();
                        if (numRes > 0)
                        {
                            lblError.Text = "Dear " + stuName + ", you have applied for <strong>" + drpCertificates.SelectedItem.Text +
                            "</strong>. We will get back to you once it has been verified. Thanks.";
                            lblError.ForeColor = System.Drawing.Color.CornflowerBlue;
                            lblError.Font.Size = 16;
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                dtData.Dispose();
                sqlCmd.Dispose();
                conn.Close();
                lblError.Text = ex.Message;
            }
            finally
            {
                conn.Close();
            }
        }

        protected void btnGetOTP_Click(object sender, EventArgs e)
        {
            try
            {
                dtData = FetchStudentDetailsByRollNo();
                if (dtData != null && dtData.Rows.Count > 0)
                {
                    if (isPhoneValid(txtPhoneNo.Text.Trim()))
                    {
                        OTP = externalOTPSender(txtPhoneNo.Text.Trim()).ToString(); //call exteral OTP API with phone number, it return the sent OTP
                        txtValidateOTP.Visible = true;
                        dvCheckDetails.Visible = true;
                    }
                }
                else
                {
                    lblError.Text = "Enter valid roll no!";
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                dtData.Dispose();
                conn.Close();
            }
        }

        int externalOTPSender(string phone)
        {
            //call external OTP API, it returns OTP to the caller
            return 1234;
        }

        bool isPhoneValid(string phone)
        {
            //check validity of phone from database if needed
            return true;
        }
    }
}