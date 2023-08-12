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
                sqlCmd.Parameters.AddWithValue("@ActionType", "FetchLoginUser");
                sqlCmd.Parameters.AddWithValue("@Email", txtUserName.Text);
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

        protected bool IsAuthenticated()
        {

            dtData = new DataTable();
            dtData = FetchLoginDetails();
            if (dtData.Rows.Count > 0)
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
                if(IsAuthenticated())
                {
                    FormsAuthentication.SetAuthCookie(txtUserName.Text, false);
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }

            }
            catch { }

        }
    }
}