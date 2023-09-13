using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Certificates
{
    public partial class ModuleSiteOut : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Stu"] == "1")
            {
                personCorner.InnerText = "Employee Corner";
                if (personCorner.InnerText == "Student Corner")
                {
                    personCorner.HRef = "Login.aspx?stu=1";
                }
                else
                {
                    personCorner.HRef = "Login.aspx";
                }
            }
            else
            {
                personCorner.InnerText = "Student Corner";
                if (personCorner.InnerText == "Employee Corner")
                {
                    personCorner.HRef = "Login.aspx";
                }
                else
                {
                    personCorner.HRef = "Login.aspx?stu=1";
                }
            }
        }
    }
}