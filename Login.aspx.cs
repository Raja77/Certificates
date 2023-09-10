using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.NetworkInformation;
using System.Xml.Linq;
using System.Web.Security;

namespace Certificates
{
    public partial class Login : System.Web.UI.Page
    {

        #region Properties
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        SqlDataAdapter adapt;
        static int ID = 0;
        DataSet ds = null;
        DataTable dtData = null;
        SqlCommand sqlCmd = null;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = string.Empty;
            if (Request.QueryString["Stu"] == "1")
            {
                lblUserName.Text = "Roll No";
                txtUserName.TextMode = TextBoxMode.Number;
                txtUserName.Attributes.Add("placeholder", "Enter Roll No");
                dvLogin.Style.Add("background-color", "aqua");
            }

        }

        private DataTable FetchLoginDetails()
        {
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                dtData = new DataTable();
                sqlCmd = new SqlCommand("spUsers", conn);
                sqlCmd.CommandType = CommandType.StoredProcedure;

                if (Request.QueryString["Stu"] == "1")
                {
                    sqlCmd.Parameters.AddWithValue("@ActionType", "FetchStudentUser");
                    sqlCmd.Parameters.AddWithValue("@RollNo", txtUserName.Text);
                }
                else
                {
                   
                    sqlCmd.Parameters.AddWithValue("@ActionType", "FetchLoginUser");
                    sqlCmd.Parameters.AddWithValue("@Email", txtUserName.Text);
                }



                sqlCmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
                sqlSda.Fill(dtData);
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
            finally
            {
                dtData.Dispose();
            }
            return dtData;
        }

        protected bool IsAuthenticatedUser()
        {

            dtData = new DataTable();
            dtData = FetchLoginDetails();
            if (dtData.Rows.Count > 0 && Request.QueryString["Stu"] == "1")
            {
                Session["RollNo"] = dtData.Rows[0]["ClassRollNo"];
                Session["Batch"] = dtData.Rows[0]["Batch"];
                //Session["DepartmentType"] = dtData.Rows[0]["DepartmentType"];
                Session["UserType"] = "CandidateX";
                return true;
            }
            else if (dtData.Rows.Count > 0)
            {
                Session["UserType"] = dtData.Rows[0]["UserType"];
                Session["DepartmentType"] = dtData.Rows[0]["DepartmentType"];
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            try
            {






                if (IsAuthenticatedUser())
                {
                    FormsAuthentication.SetAuthCookie(txtUserName.Text, false);
                    Response.Redirect("Home.aspx");
                }
                else
                {
                  
                    if (Request.QueryString["Stu"] == "1")
                    {
                        Session["UserType"] = null;
                        Session["RollNo"] = null;
                        Session["Batch"] = null;
                        Session.Clear();
                      //  Response.Redirect("Login.aspx?Stu=1");
                    }
                    else
                    {
                        Session["UserType"] = null;
                        Session["DepartmentType"] = null;
                        Session.Clear();
                       // Response.Redirect("Login.aspx");
                    }

                lblError.Text = "No such details available in the system!";

            }

        }
            catch(Exception ex) {

                lblError.Text = "An error occurred: "+ex.Message;
            }

}
    }
}