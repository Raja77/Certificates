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
using System.Xml.Linq;
using AjaxControlToolkit.HtmlEditor.ToolbarButtons;

namespace Certificates
{
    public partial class Home : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["UserType"].ToString() == "CandidateX")
                {
                    Response.Redirect("Certificates/Candidate/ViewCertificates.aspx");
                }
                else if (Session["UserType"].ToString() == "DepartmentX")
                {
                    if (Session["DepartmentType"].ToString() == "ADept")
                    {
                        Response.Redirect("Certificates/Admin/AdminSection.aspx");
                    }
                    else if (Session["DepartmentType"].ToString() == "EDept")
                    {
                        Response.Redirect("Certificates/Admin/ExamSection.aspx");                      
                    }
                    else if (Session["DepartmentType"].ToString() == "LDept")
                    {
                        Response.Redirect("Certificates/Admin/LibrarySection.aspx");
                    }
                    else if (Session["DepartmentType"].ToString() == "HDept")
                    {
                        Response.Redirect("Certificates/Admin/HostelSection.aspx");
                    }
                    else if (Session["DepartmentType"].ToString() == "PEDept")
                    {
                        Response.Redirect("Certificates/Admin/PhysicalEducationSection.aspx");
                    }
                    else if (Session["DepartmentType"].ToString() == "CDept")
                    {
                        Response.Redirect("Certificates/Admin/CertificateSection.aspx");
                    }
                    else
                    {
                        Response.Redirect("Certificates/Admin/ViewAllApplications.aspx");
                    }
                    
                }


            }
        }

    }
}