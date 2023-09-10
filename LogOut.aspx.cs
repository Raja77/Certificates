using System;

namespace Certificates
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UserType"] = null;
            Session["DepartmentType"] = null;
            Session.Abandon();
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}