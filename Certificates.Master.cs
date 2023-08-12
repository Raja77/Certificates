using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Certificates
{
    public partial class Certificates : System.Web.UI.MasterPage
    {
        public static string Image
        {
            set
            {
               HttpContext.Current.Session["Image"] = value;
            }
            get
            {
                string result;
                try
                {
                    result = (string)HttpContext.Current.Session["Image"];
                }
                catch
                {
                    result = String.Empty;
                }
                return result;
            }
        }

        public static string UserName
        {
            set
            {
                HttpContext.Current.Session["UserName"] = value;
            }
            get
            {
                string result;
                try
                {
                    result = (string)HttpContext.Current.Session["UserName"];
                }
                catch
                {
                    result = String.Empty;
                }
                return result;
            }
        }

        public static string UserID
        {
            set
            {
                HttpContext.Current.Session["UserID"] = value;
            }
            get
            {
                string result;
                try
                {
                    result = (string)HttpContext.Current.Session["UserID"];
                }
                catch
                {
                    result = String.Empty;
                }
                return result;
            }
        }


     //   SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            imgProfile.Src = imgProfile1.Src = Image;
            userName.InnerText = userName1.InnerText = UserName;
            hdnUserID.Value = UserID;

            
            // DataSet ds = new DataSet();
            //try
            //{
            //    conn.Open();
            //    SqlCommand com = new SqlCommand("select * from tbusers where UserID='" + Session["UserID"] +"'", conn);
            //    SqlDataAdapter sda = new SqlDataAdapter(com);
            //    sda.Fill(ds);
            //}
            //catch (Exception ex)
            //{
                
            //}

            
                if (Session["UserRole"].Equals("Divisional Head"))
                {
                    liApproval.Visible = true;
                }
               


              

        }
    }
}