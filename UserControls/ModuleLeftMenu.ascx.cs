using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Certificates
{
    public partial class ModuleLeftMenu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckUserRole();
        }

        protected void CheckUserRole()
        {
            if (Session["UserType"].ToString() == "CandidateX")
            {
                ViewCerts.Visible= true;
                ApplyCerts.Visible= true;
            }
            else if (Session["UserType"].ToString() == "DepartmentX")
            {
                if (Session["DepartmentType"].ToString() == "ADept")
                {
                    Admission_Dept.Visible= true;
                }
                else if (Session["DepartmentType"].ToString() == "EDept")
                {
                    Exam_Dept.Visible= true;

                }
                else if (Session["DepartmentType"].ToString() == "LDept")
                {
                    Library_Dept.Visible= true;
                }
                else if (Session["DepartmentType"].ToString() == "HDept")
                {
                    Hostel_Dept.Visible= true;
                }
                else if (Session["DepartmentType"].ToString() == "PEDept")
                {
                    PE_Dept.Visible= true;
                }
                else if (Session["DepartmentType"].ToString() == "CDept")
                {
                   Certificate_Dept.Visible= true;
                }
                else
                {
                    ViewAllCerts.Visible= true;
                    Admission_Dept.Visible = true;
                    Exam_Dept.Visible = true;
                    Library_Dept.Visible = true;
                    Hostel_Dept.Visible = true;
                    PE_Dept.Visible = true;
                    Certificate_Dept.Visible = true;
                }

            }

        }
    }
}