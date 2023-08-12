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

namespace Certificates
{
    public partial class Registration : System.Web.UI.Page
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

        protected void ddlUserType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ddlUserTypeValue = ddlUserType.SelectedItem.Text;

            if(ddlUserTypeValue == "Candidate")
            {
                dvRollNo.Visible = true;
                dvDepartmentType.Visible = false;
            }
            else if (ddlUserTypeValue == "Department")
            {
                dvDepartmentType.Visible = true;
                dvRollNo.Visible = false;
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
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
                sqlCmd.Parameters.AddWithValue("@ActionType", "SaveUsers");
                //sqlCmd.Parameters.AddWithValue("@Id", ID);
                sqlCmd.Parameters.AddWithValue("@Name", txtName.Text);                
                sqlCmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                sqlCmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                sqlCmd.Parameters.AddWithValue("@PhoneNo", Convert.ToInt64( txtPhoneNo.Text));
                sqlCmd.Parameters.AddWithValue("@UserType", ddlUserType.SelectedItem.Value);
                if (ddlUserType.SelectedItem.Value == "CandidateX")
                {
                    sqlCmd.Parameters.AddWithValue("@RollNo", txtRollNo.Text);
                    sqlCmd.Parameters.AddWithValue("@DepartmentType", DBNull.Value);
                }               
                else
                {
                    sqlCmd.Parameters.AddWithValue("@DepartmentType", ddlDepartmentType.SelectedItem.Value);
                    sqlCmd.Parameters.AddWithValue("@RollNo", DBNull.Value);
                }
                int numRes = sqlCmd.ExecuteNonQuery();
                if (numRes > 0)
                {
                    lblError.Text = "Record Updated Successfully";
                    lblError.ForeColor = System.Drawing.Color.CornflowerBlue;
                    lblError.Font.Size = 16;
                    ClearControls();
                }
                else
                    lblError.Text = ("Please Try Again !!!");
            }
            catch (Exception ex)
            {
                lblError.Text = ("Error:- " + ex.Message);
            }
            finally
            {
                dtData.Dispose();
                sqlCmd.Dispose();
                conn.Close();
            }
        }

        protected void ClearControls()
        {
            txtName.Text = txtEmail.Text = txtPhoneNo.Text = txtPassword.Text = txtConfirmPassword.Text = txtRollNo.Text = string.Empty;
            ddlUserType.SelectedItem.Value = "CandidateX";
            ddlDepartmentType.SelectedItem.Value = "SAdmin";
        }
    }
}