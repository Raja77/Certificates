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
    public partial class LogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UserType"] = null;
            Session["DepartmentType"] = null;
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}