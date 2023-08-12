using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;
using System.Text;

namespace Certificates
{
    public partial class Grievance : Page
    {
        public String programme
        {
            get
            {
                if (Session["programme"] == null)
                {
                    Session["programme"] = String.Empty;
                }
                return Session["programme"].ToString();
            }
            set
            {
                Session["programme"] = value;
            }
        }
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {




            }
        }

    }
}