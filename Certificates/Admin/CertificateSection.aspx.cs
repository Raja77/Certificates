using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.draw;
using System.Net;

namespace Certificates
{
    public partial class CertificateSection : Page
    {
        #region Properties
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        SqlDataAdapter adapt;
        static int ID = 0;
        DataSet ds = null;
        DataTable dtData = null;
        SqlCommand sqlCmd = null;
        DataRow dr = null;

        #endregion

        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCertificateDetails();
            }
            lblError.Text = string.Empty;
        }

        protected void GetCertificateDetails()
        {
            try
            {
                ds = new DataSet();
                ds = FetchCertificateDetails();
                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    grdPendingCertificatesDetail.DataSource = ds.Tables[0];
                    grdPendingCertificatesDetail.DataBind();
                    countPendingCertificates.InnerText = ds.Tables[0].Rows.Count.ToString();
                    countPendingCertificates.Attributes.Add("title", "Pending Certificates");
                }
                else
                {
                    lblError.Text = "Some error!";
                    grdPendingCertificatesDetail.DataSource = ds.Tables[0];
                    grdPendingCertificatesDetail.DataBind();
                }

                if (ds.Tables.Count > 0 && ds.Tables[1].Rows.Count > 0)
                {
                    grdIssuedCertificatesDetail.DataSource = ds.Tables[1];
                    grdIssuedCertificatesDetail.DataBind();
                    countIssuedCertificates.InnerText = ds.Tables[1].Rows.Count.ToString();
                    countIssuedCertificates.Attributes.Add("title", "Issued Certificates");
                }
                else
                {
                    lblError.Text = "Some error!";
                    grdIssuedCertificatesDetail.DataSource = ds.Tables[1];
                    grdIssuedCertificatesDetail.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }
        protected void grdPendingCertificatesDetail_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "PrintCertificate")
            {
                string[] arg = new string[2];
                arg = e.CommandArgument.ToString().Split(';');
                Session["Id"] = arg[0];
                Session["CertificateType"] = arg[1];
                GenerateReport(null, null);

            }
            if (e.CommandName == "IssueCertificate")
            {
                string[] arg = new string[10];
                arg = e.CommandArgument.ToString().Split(';');
                Session["Id"] = arg[0];
                Session["CertificateType"] = arg[1];
                Session["Name"] = arg[2];
                Session["AppliedOn"] = arg[3];
                Session["IsCertificateVerified"] = arg[4];
                Session["CertificateSectionIssuedOn"] = arg[5];
                Session["CertificateSectionIssuedRemarks"] = arg[6];
                Session["CertificateSectionIssuedNumber"] = arg[7];
                Session["IdCertificateSectionReceivedRemarks"] = arg[8];
                Session["CertificateSectionReceivedOn"] = arg[9];

                string certificateType = string.Empty;
                string name = string.Empty;
                string appliedOn = string.Empty;
                string isCertificateVerified = string.Empty;
                string certificateSectionIssuedOn = string.Empty;
                string certificateSectionIssuedRemarks = string.Empty;
                string certificateSectionIssuedNumber = string.Empty;
                string certificateSectionReceivedRemarks = string.Empty;
                string certificateSectionReceivedOn = string.Empty;

                if (!string.IsNullOrEmpty(Session["Name"].ToString()))
                {
                    name = Session["Name"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["CertificateType"].ToString()))
                {
                    certificateType = Session["CertificateType"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["AppliedOn"].ToString()))
                {
                    appliedOn = Session["AppliedOn"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["IsCertificateVerified"].ToString()))
                {
                    isCertificateVerified = Session["IsCertificateVerified"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["CertificateSectionIssuedOn"].ToString()))
                {
                    certificateSectionIssuedOn = Session["CertificateSectionIssuedOn"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["CertificateSectionIssuedRemarks"].ToString()))
                {
                    certificateSectionIssuedRemarks = Session["CertificateSectionIssuedRemarks"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["CertificateSectionIssuedNumber"].ToString()))
                {
                    certificateSectionIssuedNumber = Session["CertificateSectionIssuedNumber"].ToString();
                }
                lblName.Text = name;
                lblCertificateType.Text = certificateType;
                lblAppliedOn.Text = appliedOn;
            }
        }

        protected void grdIssuedCertificatesDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Checking the RowType of the Row
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label IssuedOn = (Label)e.Row.FindControl("lblReceivedOn");
                if (!string.IsNullOrEmpty(IssuedOn.Text))
                {
                    e.Row.BackColor = System.Drawing.Color.LightGreen;
                    e.Row.ToolTip = "Application has been verified and ready for dispatch.";
                }
                else
                {
                    e.Row.BackColor = System.Drawing.Color.LightBlue;
                    e.Row.ToolTip = "Application has issued and scheduled for printing.";
                }

                Label certificateType = (e.Row.FindControl("lblCertificateType") as Label);
                if (certificateType.Text == "Marks Certificate")
                {
                    LinkButton lnkPrint = (LinkButton)e.Row.FindControl("lnkPrint");
                    lnkPrint.Visible = false;
                }
            }
        }
        #endregion
        protected void GenerateReport(object sender, EventArgs e)
        {
            string certificateType = string.Empty;
            if (Session["Id"] != null)
            {
                ID = Convert.ToInt32(Session["Id"]);
            }

            if (Session["CertificateType"] != null)
            {
                certificateType = Session["CertificateType"].ToString();
            }

            //for provisional certificate
            //session __________  to ___________________
            //in _________ semester _______________ held in__________under exam roll no_____________
            //Notification No:________ dated___________
            //Masters/Bachelors of ____________
            // has remained __________
            //CGPA obtained __________ Div/Grade________Dated____

            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            dtData = new DataTable();
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd = new SqlCommand("spCertificates", conn);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@Id", ID);
            sqlCmd.Parameters.AddWithValue("@ActionType", "FetchDataById");
            SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
            sqlSda.Fill(dtData);
            if (dtData != null && dtData.Rows.Count > 0)
            {
                dr = dtData.Rows[0];
            }
            Document document = new Document(PageSize.A4, 90f, 90f, 60f, 10f);
            Font NormalFont = FontFactory.GetFont("Arial", 12, Font.NORMAL, BaseColor.BLACK);
            Font NormalBoldFont = FontFactory.GetFont("Arial", 12, Font.BOLD, BaseColor.BLACK);
            Font normalLargeFont = FontFactory.GetFont("Arial", 18, Font.NORMAL, BaseColor.BLACK);
            using (System.IO.MemoryStream memoryStream = new System.IO.MemoryStream())
            {
                PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
                Phrase phrase = null;
                PdfPCell cell = null;
                PdfPTable table = null;
                BaseColor color = null;
                Paragraph paragraph = new Paragraph();
                BaseFont sm = GetFont("Monotype Corsiva");
                Font verysmallFont = new Font(sm, 4, Font.NORMAL, BaseColor.WHITE);
                Font smallFont = new Font(sm, 12, Font.NORMAL, BaseColor.BLACK);
                Font titleFont = new Font(sm, 16, Font.NORMAL, BaseColor.BLACK);
                Font largeFont = new Font(sm, 28, Font.BOLD, BaseColor.RED);
                Font underlineFont = new Font(sm, 16, Font.UNDERLINE, BaseColor.DARK_GRAY);
                float f1 = 0.5f;
                float f2 = -1.5f;
                document.Open();

                switch (certificateType)
                {
                    case "Provisional cum Character Certificate":
                        #region Provisional cum Character Certificate

                        //table = new PdfPTable(1);
                        //table.TotalWidth = 510f;
                        //table.LockedWidth = true;
                        //Font chnk_normal_text = new Font(Font.COURIER, 16f, Font.NORMAL, new Color(163, 21, 21));
                        //Font chnk_underline = new Font(Font.COURIER, 18f, Font.UNDERLINE + Font.BOLD, new Color(43, 145, 175));
                        //Font xyz = GetFont("Monotype Corsiva", "Monotype Corsiva.ttf");  



                        //paragraph.FirstLineIndent = 10f; //allows you to apply a float value to indent the first line
                        //paragraph.IndentationLeft = 10f;  //allows you to add space to the left hand side
                        //paragraph.IndentationRight = 10f; //allows you to add space to the right hand side
                        //paragraph.SpacingBefore = 40f; // specifies the amount of space above the paragraph
                        //paragraph.SpacingAfter = 60f;  // specifies the amount of space after the paragraph
                        paragraph = new Paragraph();
                        Phrase p11 = new Phrase();
                        paragraph.Alignment = Element.ALIGN_CENTER;

                        Chunk newline = new Chunk("\n\n\n\n\n\n\n\n", titleFont);
                        Chunk a0 = new Chunk("    Provisional cum Character Certificate   \n", largeFont);
                        p11.Add(newline); p11.Add(a0);
                        paragraph.Add(p11);
                        document.Add(paragraph);


                        paragraph = new Paragraph();
                        paragraph.Alignment = Element.ALIGN_JUSTIFIED;
                        paragraph.IndentationLeft = -40;
                        paragraph.IndentationRight = -40;
                        paragraph.SetLeading(0f, 2.15f);
                        Phrase p1 = new Phrase();
                        Chunk a00 = new Chunk("S.No.   ", titleFont);
                        Chunk a01 = new Chunk(dr["CertificateNo"] + " \n", titleFont);
                        a01.SetUnderline(f1, f2);
                        
                       
                        Chunk a1 = new Chunk("    Certified that Mr./Ms.   ", titleFont);
                        Chunk a2 = new Chunk("            " + dr["Name"] + "            ", titleFont);
                        a2.SetUnderline(f1, f2);
                        //Chunk a202 = new Chunk(".", verysmallFont);
                        Chunk a3 = new Chunk("S/o,D/o   ", titleFont);
                        Chunk a4 = new Chunk("        " + dr["Parentage"] + "        ", titleFont);
                        a4.SetUnderline(f1, f2);
                        Chunk a5 = new Chunk(" bearing registration No. ", titleFont);
                        Chunk a6 = new Chunk("  " + dr["RegistrationNo"] + "  ", titleFont);
                        a6.SetUnderline(f1, f2);
                        Chunk a7 = new Chunk(" was a student of this college during the session ", titleFont);
                        Chunk a8 = new Chunk(dr["Batch"] + "  ", titleFont);
                        a8.SetUnderline(f1, f2);
                        // Chunk a808 = new Chunk(".", verysmallFont);
                        Chunk a9 = new Chunk(" to ", titleFont);
                        Chunk a10 = new Chunk((Convert.ToInt32(dr["Batch"])+3)+ "   ", titleFont);
                        a10.SetUnderline(f1, f2);
                        Chunk a11 = new Chunk(" under College Roll No. ", titleFont);
                        Chunk a12 = new Chunk(dr["RollNo"] + "   .\n", titleFont);
                        a12.SetUnderline(f1, f2);

                        p1.Add(a00); p1.Add(a01);  p1.Add(a1); p1.Add(a2); /*p1.Add(a202);*/ p1.Add(a3); p1.Add(a4); p1.Add(a5); p1.Add(a6); p1.Add(a7); p1.Add(a8);
                        //p1.Add(a808);
                        p1.Add(a9); p1.Add(a10); p1.Add(a11); p1.Add(a12);
                       
                        //table.DefaultCell.Border = Rectangle.NO_BORDER;

                       

                        paragraph.Add(p1);
                        //table.AddCell(p1);
                        Phrase p2 = new Phrase();
                        // Paragraph p = new Paragraph();
                        //p.Add(p2);

                        Chunk b1 = new Chunk("    He/She appeared in ", titleFont);
                        Chunk b2 = new Chunk(DateTime.Now.Year + "   ", titleFont);
                        b2.SetUnderline(f1, f2);
                        Chunk b3 = new Chunk(" semester ", titleFont);
                        Chunk b4 = new Chunk(dr["Semester"] + "   ", titleFont);
                        b4.SetUnderline(f1, f2);
                        Chunk b5 = new Chunk(" examination held in ", titleFont);
                        Chunk b6 = new Chunk( "              ", titleFont);
                        b6.SetUnderline(f1, f2);
                        Chunk b7 = new Chunk(" under examination Roll No. ", titleFont);
                        Chunk b8 = new Chunk(dr["RollNo"] + "   ", titleFont);
                        b8.SetUnderline(f1, f2);
                        Chunk b9 = new Chunk(" and has been declared successful in the said examination, as per the result Gazette/Notification No.: ", titleFont);
                        //Chunk b10 = new Chunk(dr["Id"] + "   ", titleFont);  //????????Sucessful/unsuccessful/re-appear
                        //b10.SetUnderline(f1, f2);
                        //Chunk b11 = new Chunk(" \n", titleFont);
                        //Chunk b12 = new Chunk(" ", titleFont);
                        Chunk b13 = new Chunk( "              ", titleFont);
                        //Chunk b13 = new Chunk(dr["GazetteNotificationNo"] + "   ", titleFont);
                        b13.SetUnderline(f1, f2);
                        Chunk b14 = new Chunk(" dated ", titleFont);
                        Chunk b15 = new Chunk( "              ", titleFont);
                        //Chunk b15 = new Chunk(dr["GazetteNotificationDate"] + "   ", titleFont);
                        b15.SetUnderline(f1, f2);
                        Chunk b16 = new Chunk(" published by the ", titleFont);
                        Chunk b17 = new Chunk("controller of examination of College/University of Kashmir.", titleFont);

                        p2.Add(b1); p2.Add(b2); p2.Add(b3); p2.Add(b4); p2.Add(b5); p2.Add(b6); p2.Add(b7); p2.Add(b8); p2.Add(b9); 
                        p2.Add(b13); p2.Add(b14); p2.Add(b15); p2.Add(b16); p2.Add(b17);
                        //table.DefaultCell.Border = Rectangle.NO_BORDER;
                        //table.AddCell(p2);
                        paragraph.Add(p2);

                        Phrase p3 = new Phrase();
                        Chunk c1 = new Chunk("   The candidate has qualified himself/herself for the award of Degree of Master / Bachelor of ", titleFont);
                        //Chunk c2 = new Chunk("\n  ", titleFont);
                        Chunk c3 = new Chunk("         " + dr["CourseApplied"] + "        ", titleFont);
                        c3.SetUnderline(f1, f2);
                        Chunk c303 = new Chunk(".", verysmallFont);

                        p3.Add(c1); /*p3.Add(c2);*/ p3.Add(c3); p3.Add(c303);
                        //table.DefaultCell.Border = Rectangle.NO_BORDER;
                        //table.AddCell(p3);
                        paragraph.Add(p3);

                        Phrase p4 = new Phrase();
                        Chunk d1 = new Chunk("\n    His/Her character during the period has remained ", titleFont);
                        Chunk d2 = new Chunk(" Satisfactory .", titleFont);
                        d2.SetUnderline(f1, f2);

                        p4.Add(d1); p4.Add(d2); /*p3.Add(d202);*/
                        //table.DefaultCell.Border = Rectangle.NO_BORDER;
                        //table.AddCell(p4);
                        paragraph.Add(p4);

                        Phrase p5 = new Phrase();
                        Chunk e1 = new Chunk("\n");
                        Chunk e2 = new Chunk("Note: This certificate is issued only with aim of enabling the candidate to be admitted to an institution " +
                            "and is not to be held equivalent to the Degree certificate to be given to him/her by the Registrar, University of Kashmir " +
                            "in due course of time.", smallFont);
                        //Chunk e3 = new Chunk(" ", smallFont);
                        //Chunk e4 = new Chunk(" \n", smallFont);

                        p5.Add(e1); p5.Add(e2); /*p5.Add(e3); p5.Add(e4);*/
                        // table.DefaultCell.Border = Rectangle.NO_BORDER;
                        //table.AddCell(p5);
                        paragraph.Add(p5);

                        Phrase p6 = new Phrase();
                        Chunk f11 = new Chunk("\n");
                        Chunk f22 = new Chunk("Marks/CGPA obtained ", titleFont);
                        Chunk f33 = new Chunk("                   ", titleFont);
                        //Chunk f33 = new Chunk("  " + dr["CGPA"] + "  ", titleFont);
                        f33.SetUnderline(f1, f2);
                        Chunk f44 = new Chunk(" Division/Grade ", titleFont);
                        Chunk f55 = new Chunk("                   ", titleFont);
                        //Chunk f55 = new Chunk("  " + dr["Grade"] + "  ", titleFont);
                        f55.SetUnderline(f1, f2);
                        Chunk f66 = new Chunk(" Dated ", titleFont);
                        Chunk f77 = new Chunk("  " + DateTime.Now.ToString("dd-MMM-yyyy") + "  ", titleFont);
                        f77.SetUnderline(f1, f2);
                        Chunk f777 = new Chunk(".", verysmallFont);

                        p6.Add(f11); p6.Add(f22); p6.Add(f33); p6.Add(f44); p6.Add(f55); p6.Add(f66); p6.Add(f77); p6.Add(f777);
                        //table.DefaultCell.Border = Rectangle.NO_BORDER;
                        //table.AddCell(p6);
                        paragraph.Add(p6);

                        Chunk glue = new Chunk(new VerticalPositionMark());
                        Phrase ph1 = new Phrase();
                        ph1.Add(new Chunk("\n\n\n\n\n"));
                        Paragraph main = new Paragraph();
                        ph1.Add(new Chunk("No. ADM/ICSC/", titleFont));
                        Chunk f88 = new Chunk("  " + dr["CertificateSectionIssuedNumber"] + "  ", titleFont);
                        f88.SetUnderline(f1, f2);
                        ph1.Add(f88);
                        ph1.Add(glue);
                        ph1.Add(new Chunk("Principal", titleFont));
                        main.Add(ph1);
                        //table.AddCell(main);
                        paragraph.Add(main);
                        //document.Add(table);
                        document.Add(paragraph);
                        #endregion
                        break;

                    case "Migration Certificate":                    
                        #region Migration Certificate
                        paragraph = new Paragraph();
                        paragraph.Alignment = (Element.ALIGN_CENTER);
                        //paragraph.IndentationLeft = 20;
                        //paragraph.IndentationRight = 20;
                        //paragraph.FirstLineIndent = 10f; //allows you to apply a float value to indent the first line
                        //paragraph.IndentationLeft = 10f;  //allows you to add space to the left hand side
                        //paragraph.IndentationRight = 10f; //allows you to add space to the right hand side
                        //paragraph.SpacingBefore = 20f; // specifies the amount of space above the paragraph
                        //paragraph.SpacingAfter = 20f;  // specifies the amount of space after the paragraph

                        Phrase m_p2 = new Phrase();
                        Chunk m_newline = new Chunk("\n\n\n\n\n\n\n\n\n", NormalFont);
                        Chunk m_a1 = new Chunk("MIGRATION CERTIFICATE", normalLargeFont);
                        m_a1.SetUnderline(f1, f2);
                        m_p2.Add(m_newline);
                        m_p2.Add(m_a1);
                        paragraph.Add(m_p2);
                        document.Add(paragraph);    

                        Phrase m_p1 = new Phrase();
                        paragraph = new Paragraph();
                        //paragraph.Alignment = (Element.ALIGN_LEFT);
                        paragraph.Alignment = Element.ALIGN_JUSTIFIED;
                        paragraph.SetLeading(0f, 2.15f);

                        //paragraph.IndentationLeft = 20;
                        Chunk m_a2 = new Chunk("\nThis is to certify that ", NormalFont);
                        Chunk m_a3 = new Chunk("   " + dr["Name"] + "   ", NormalFont);
                        m_a3.SetUnderline(f1, f2);
                        Chunk m_a4 = new Chunk(" Son / Daughter of ", NormalFont);
                        Chunk m_a5 = new Chunk(dr["Parentage"] + "   ", NormalFont);
                        m_a5.SetUnderline(f1, f2);
                        Chunk m_a6 = new Chunk(" with Class Roll No.", NormalFont);
                        Chunk m_a7 = new Chunk("  " + dr["RollNo"] + "  ", NormalFont);
                        m_a7.SetUnderline(f1, f2);
                        Chunk m_a8 = new Chunk(" was a ", NormalFont);
                        Chunk m_a9 = new Chunk("student of this college under Registration No. ", NormalFont);
                        Chunk m_a10 = new Chunk("   " + dr["RegistrationNo"] + "  ", NormalFont);
                        m_a10.SetUnderline(f1, f2);
                        Chunk m_a11 = new Chunk(" and ", NormalFont);
                        //Chunk m_a12 = new Chunk("completed his/her M.B.A/M. Com./M.A. English/M.Sc. Chemistry/M.Sc.", NormalFont);
                        //Chunk m_a13 = new Chunk("Botany/M.Sc. zoology two/three years degree course during academic", NormalFont);
                        //Chunk m_a14 = new Chunk("session ", NormalFont);
                        Chunk m_a14 = new Chunk("completed his/her " + dr["CourseApplied"] + " two/three years degree course during academic session ", NormalFont);
                        Chunk m_a15 = new Chunk("    " + dr["Batch"] + " - "+(Convert.ToInt32(dr["Batch"]) + 3) + "   .", NormalFont);
                        m_a15.SetUnderline(f1, f2);
                        //Chunk m_a16 = new Chunk(" This College has no objection to his/her ", NormalFont);
                        //Chunk m_a17 = new Chunk("continuing studies or appearing in any examination at any recognized ", NormalFont);
                        //Chunk m_a18 = new Chunk("University/College/Institution established by law in India. He/She has ", NormalFont);
                        Chunk m_a19 = new Chunk(" This College has no objection to his/her continuing studies or appearing in any examination at any recognized" +
                            " University/College/Institution established by law in India. He/She has appeared in ", NormalFont);
                        Chunk m_a20 = new Chunk("    " + "("+ dr["Session"] + ")"+ " "+ (Convert.ToInt32(dr["Batch"])+3)+  "   ", NormalFont);
                        m_a20.SetUnderline(f1, f2);
                        Chunk m_a21 = new Chunk(" Examination held in ", NormalFont);
                        Chunk m_a22 = new Chunk("                  ", NormalFont);
                        m_a22.SetUnderline(f1, f2);
                        Chunk m_a23 = new Chunk(" and ", NormalFont);
                        Chunk m_a24 = new Chunk("the result is ", NormalFont);
                        Chunk m_a25 = new Chunk("   " + "Pass" + "   .", NormalFont);
                        m_a25.SetUnderline(f1, f2);
                        Chunk m_a26 = new Chunk("\n\n\n", NormalFont);
                        Chunk m_a27 = new Chunk("No. ICS/ ", NormalFont);
                        Chunk m_a28 = new Chunk("   " + dr["CertificateSectionIssuedNumber"] + "   ", NormalFont);
                        m_a28.SetUnderline(f1, f2);
                        Chunk m_a2808 = new Chunk(".", verysmallFont);
                        Chunk m_a29 = new Chunk("\nDated: ", NormalFont);
                        Chunk m_a30 = new Chunk(" " + DateTime.Now.ToString("dd-MMM-yyyy") + " .", NormalFont);
                        m_a30.SetUnderline(f1, f2);
                        Chunk m_a3000 = new Chunk(".", verysmallFont);

                        //m_p1.Add(m_newline); m_p1.Add(m_a1);
                        m_p1.Add(m_a2); m_p1.Add(m_a3); m_p1.Add(m_a4); m_p1.Add(m_a5); m_p1.Add(m_a6); m_p1.Add(m_a7);
                        m_p1.Add(m_a8); m_p1.Add(m_a9); m_p1.Add(m_a10); m_p1.Add(m_a11); m_p1.Add(m_a14); m_p1.Add(m_a15);
                        m_p1.Add(m_a19); m_p1.Add(m_a20); m_p1.Add(m_a21); m_p1.Add(m_a22); m_p1.Add(m_a23);
                        m_p1.Add(m_a24); m_p1.Add(m_a25); m_p1.Add(m_a26); m_p1.Add(m_a27); m_p1.Add(m_a28); m_p1.Add(m_a2808); m_p1.Add(m_a29); m_p1.Add(m_a30);
                        m_p1.Add(m_a3000);

                        paragraph.Add(m_p1);
                        document.Add(paragraph);
                        Phrase m_p3 = new Phrase();
                        Chunk m_a31 = new Chunk("\n\n\nPrincipal", NormalFont);
                        paragraph = new Paragraph();
                        paragraph.Alignment = (Element.ALIGN_RIGHT);
                        paragraph.Add(m_a31);
                        document.Add(paragraph);
                        #endregion
                        break;

                    case "Discharge/Transfer Certificate":
                        #region Discharge/Transfer Certificate
                        paragraph = new Paragraph();
                        paragraph.Alignment = (Element.ALIGN_JUSTIFIED);
                        paragraph.SetLeading(0f, 2.15f);
                        paragraph.IndentationLeft = -20;
                        paragraph.IndentationRight = -20;


                        //paragraph.FirstLineIndent = 10f; //allows you to apply a float value to indent the first line
                        //paragraph.IndentationLeft = 10f;  //allows you to add space to the left hand side
                        //paragraph.IndentationRight = 10f; //allows you to add space to the right hand side
                        //paragraph.SpacingBefore = 20f; // specifies the amount of space above the paragraph
                        //paragraph.SpacingAfter = 20f;  // specifies the amount of space after the paragraph


                        //Transfer / Discharge Cum Character Certificate
                        //Certified that Mr. / Ms.___ S / o, D / o _______ bearing Registration No __ was a student of this college from __ to _ in the session __ under college Roll No._ and was studying ___ course ____ year class.

                        //  He/She appeared in the said class examination under university Roll No.__ and has been declared Pass/Fail/Reappear/Compt. in the said examination.
                        //He/She is permitted to withdraw his/her name from the rolls of the college having paid all the dues and returned the library books borrowed by him/her.
                        //Matriculation Certificate be referred for Date of Birth.
                        //He/She has been permitted to migrate from this college to __ as per Kashmir University letter No.__ dated ____

                        //Conduct/Character ____
                        //Date___
                        //Received by me
                        //_

                        //Principal

                        Phrase t_p1 = new Phrase();
                        Chunk t_newline = new Chunk("\n\n\n\n", NormalFont);
                        Chunk t_a0 = new Chunk("   S.No. ICSC/ ", NormalFont);
                        Chunk t_a01 = new Chunk(" " + dr["CertificateNo"] + " ", NormalFont);
                        t_a01.SetUnderline(f1, f2);
                        Chunk t_a1 = new Chunk("\n\n   Certified that Mr. / Ms.", NormalFont);
                        Chunk t_a2 = new Chunk("   " + dr["Name"] + "   ", NormalFont);
                        t_a2.SetUnderline(f1, f2);
                        Chunk t_a3 = new Chunk(" S/o, D/o, Mr.", NormalFont);
                        Chunk t_a4 = new Chunk("   " + dr["Parentage"] + "   ", NormalFont);
                        t_a4.SetUnderline(f1, f2);
                        Chunk t_a5 = new Chunk(" bearing Registration No.", NormalFont);
                        Chunk t_a6 = new Chunk("   " + dr["RegistrationNo"] + "   ", NormalFont);
                        t_a6.SetUnderline(f1, f2);
                        Chunk t_a7 = new Chunk(" was a student of this college from", NormalFont);
                        Chunk t_a8 = new Chunk("   " + dr["Batch"] + "   ", NormalFont);
                        t_a8.SetUnderline(f1, f2);
                        Chunk t_a9 = new Chunk(" to ", NormalFont);
                        Chunk t_a10 = new Chunk("   " + (Convert.ToInt32(dr["Batch"])+3) + "   ", NormalFont);
                        t_a10.SetUnderline(f1, f2);
                        Chunk t_a11 = new Chunk(" in the session", NormalFont);
                        Chunk t_a12 = new Chunk("   " + dr["Session"] + "   ", NormalFont);
                        t_a12.SetUnderline(f1, f2);
                        Chunk t_a13 = new Chunk(" under college Roll No ", NormalFont);
                        Chunk t_a14 = new Chunk("   " + dr["RollNo"] + "   ", NormalFont);
                        t_a14.SetUnderline(f1, f2);
                        Chunk t_a15 = new Chunk(" and was reading in B.S.C./B.com./B.B.A. I/II/III year class. He/She appeared in the said class " +
                            "examination under university Roll No.", NormalFont);
                        //Chunk t_a16 = new Chunk("\n     ", NormalFont);
                        Chunk t_a17 = new Chunk("   " + dr["RollNo"] + "   ", NormalFont);
                        t_a17.SetUnderline(f1, f2);
                        Chunk t_a18 = new Chunk(" and has been declared Pass/Fail/Reappear/Compt. in the said examination.", NormalFont);
                        Chunk t_a19 = new Chunk("\n   He/She is permitted to withdraw his/her name from the rolls of the college having paid all the " +
                            "dues and returned the library books borrowed by him/her.", NormalFont);
                        Chunk t_a20 = new Chunk("\nMatriculation Certificate be referred for Date of Birth.", NormalFont);
                        Chunk t_a21 = new Chunk("\n   He/She has been permitted to migrate from this college to the ", NormalFont);
                        Chunk t_a22 = new Chunk("                      ", NormalFont);
                        //Chunk t_a22 = new Chunk("   " + dr["RegistrationNo"] + "   ", NormalFont);
                        t_a22.SetUnderline(f1, f2);
                        Chunk t_a23 = new Chunk(" as per Kashmir University letter No. ", NormalFont);
                        Chunk t_a24 = new Chunk("                      ", NormalFont);
                        //Chunk t_a24 = new Chunk("   " + dr["RegistrationNo"] + "   ", NormalFont);
                        t_a24.SetUnderline(f1, f2);
                        Chunk t_a25 = new Chunk(" Dated ", NormalFont);
                        Chunk t_a26 = new Chunk("                      ", NormalFont);
                        t_a26.SetUnderline(f1, f2);
                        Chunk t_a27 = new Chunk("\n\nConduct / Character ", NormalBoldFont);
                        Chunk t_a28 = new Chunk(" Satisfactory ", NormalFont);
                        t_a28.SetUnderline(f1, f2);
                        Chunk t_a29 = new Chunk("\n\nDate ", NormalBoldFont);
                        Chunk t_a30 = new Chunk("   " + DateTime.Now.ToString("dd-MMM-yyyy") + "   ", NormalFont);
                        t_a30.SetUnderline(f1, f2);
                        Chunk t_a31 = new Chunk("\nReceived by me\n\n\n", NormalBoldFont);
                        t_p1.Add(t_newline); t_p1.Add(t_a0); t_p1.Add(t_a01); t_p1.Add(t_a1);
                        t_p1.Add(t_a2); t_p1.Add(t_a3); t_p1.Add(t_a4); t_p1.Add(t_a5); t_p1.Add(t_a6); t_p1.Add(t_a7);
                        t_p1.Add(t_a8); t_p1.Add(t_a9); t_p1.Add(t_a10); t_p1.Add(t_a11); t_p1.Add(t_a12); t_p1.Add(t_a13); t_p1.Add(t_a14); t_p1.Add(t_a15);
                        /*t_p1.Add(t_a16);*/ t_p1.Add(t_a17); t_p1.Add(t_a18); t_p1.Add(t_a19); t_p1.Add(t_a20); t_p1.Add(t_a21); t_p1.Add(t_a22); t_p1.Add(t_a23);
                        t_p1.Add(t_a24); t_p1.Add(t_a25); t_p1.Add(t_a26); t_p1.Add(t_a27); t_p1.Add(t_a28); t_p1.Add(t_a29); t_p1.Add(t_a31);

                        paragraph.Add(t_p1);
                        Chunk glue1 = new Chunk(new VerticalPositionMark());
                        Phrase ph1x = new Phrase();
                        Paragraph main1 = new Paragraph();
                        Chunk t_a32 = new Chunk("                  ", NormalFont);
                        t_a32.SetUnderline(f1, f2);
                        ph1x.Add(t_a32);
                        ph1x.Add(glue1);
                        ph1x.Add(new Chunk("Principal", NormalBoldFont));
                        main1.Add(ph1x);
                        //table.AddCell(main);
                        paragraph.Add(main1);
                        document.Add(paragraph);
                        #endregion
                        break;

                    case "Bonafide/Studentship Certificate":
                        #region Bonafide/Studentship Certificate
                        Phrase b_p1 = new Phrase();
                        paragraph = new Paragraph();
                        paragraph.Alignment = (Element.ALIGN_CENTER);                        
                        Chunk b_newline = new Chunk("\n\n\n\n\n\n\n\n\n", NormalFont);
                        Chunk b_a1 = new Chunk("STUDENTSHIP CERTIFICATE", normalLargeFont);
                        b_a1.SetUnderline(f1, f2);
                        b_p1.Add(b_newline);b_p1.Add(b_a1);
                        paragraph.Add(b_p1);
                        document.Add(paragraph);

                        Phrase b_p2 = new Phrase();
                        paragraph = new Paragraph();
                        paragraph.Alignment = Element.ALIGN_JUSTIFIED;
                        paragraph.SetLeading(0f, 2.15f);

                        //paragraph.IndentationLeft = 20;
                        Chunk b_a2 = new Chunk("\nThis is to certify that ", NormalFont);
                        Chunk b_a3 = new Chunk("   " + dr["Name"] + "   ", NormalFont);
                        b_a3.SetUnderline(f1, f2);
                        Chunk b_a4 = new Chunk(" S/o, D/o ", NormalFont);
                        Chunk b_a5 = new Chunk(dr["Parentage"] + "   ", NormalFont);
                        b_a5.SetUnderline(f1, f2);
                        Chunk b_a6 = new Chunk(" is/was a student of this College during the acedemic session with Class Roll No.", NormalFont);
                        Chunk b_a7 = new Chunk("  " + dr["RollNo"] + "  ", NormalFont);
                        b_a7.SetUnderline(f1, f2);
                        Chunk b_a8 = new Chunk(" in ", NormalFont);
                        Chunk b_a10 = new Chunk("   " + dr["CourseApplied"] + "  ", NormalFont);
                        b_a10.SetUnderline(f1, f2);
                        Chunk b_a11 = new Chunk(" of ", NormalFont);
                        Chunk b_a15 = new Chunk("    " + dr["Semester"] + "   .", NormalFont);
                        b_a15.SetUnderline(f1, f2);
                        //Chunk m_a16 = new Chunk(" This College has no objection to his/her ", NormalFont);
                        //Chunk m_a17 = new Chunk("continuing studies or appearing in any examination at any recognized ", NormalFont);
                        //Chunk m_a18 = new Chunk("University/College/Institution established by law in India. He/She has ", NormalFont);
                        Chunk b_a16 = new Chunk(" year/semester Batch ", NormalFont);
                             Chunk b_a17 = new Chunk("    " + dr["Batch"] + "   ", NormalFont);
                        b_a17.SetUnderline(f1, f2);
                        Chunk b_a18 = new Chunk(" under College Roll No.  ", NormalFont);
                        Chunk b_a19 = new Chunk("   " + dr["RollNo"] + "   ", NormalFont);
                        b_a19.SetUnderline(f1, f2);
                        Chunk b_a20 = new Chunk(" having University Registration No. ", NormalFont);
                        Chunk b_a21 = new Chunk("    " + dr["RegistrationNo"] + "   .", NormalFont); //Awaited or RegNo.
                        b_a21.SetUnderline(f1, f2);
                        Chunk b_a22 = new Chunk("\n   He/She has appeared / not appeared in the Annual Examination " +
                            "of the above mentioned course / class under University / College Examination Roll No. ", NormalFont); // appeared / not appeared should be dynamic
                        Chunk b_a23 = new Chunk("   " + dr["RollNo"] + "   ", NormalFont);
                        b_a23.SetUnderline(f1, f2);
                        Chunk b_a24 = new Chunk(" Session ", NormalFont);
                        Chunk b_a25 = new Chunk("  "+dr["Batch"]+" - "+ (Convert.ToInt32(dr["Batch"])+3) + "  .", NormalFont);
                        b_a25.SetUnderline(f1, f2);
                        Chunk b_a26 = new Chunk("\n   This certificate is issued on the request of the applicant. ", NormalFont);

                        Chunk b_a27 = new Chunk("\n\n\nNo. ICS/", NormalFont);
                        Chunk b_a28 = new Chunk("   " + dr["CertificateSectionIssuedNumber"] + "   ", NormalFont);
                        b_a28.SetUnderline(f1, f2);
                        Chunk b_a29 = new Chunk("\nDated: ", NormalFont);
                        Chunk b_a30 = new Chunk(" " + DateTime.Now.ToString("dd-MMM-yyyy") + " .", NormalFont);
                        b_a30.SetUnderline(f1, f2);

                        b_p2.Add(b_a2); b_p2.Add(b_a3); b_p2.Add(b_a4); b_p2.Add(b_a5); b_p2.Add(b_a6); b_p2.Add(b_a7);
                        b_p2.Add(b_a8); b_p2.Add(b_a10); b_p2.Add(b_a11); b_p2.Add(b_a15); b_p2.Add(b_a16); b_p2.Add(b_a17); b_p2.Add(b_a18);
                        b_p2.Add(b_a19); b_p2.Add(b_a20); b_p2.Add(b_a21); b_p2.Add(b_a22); b_p2.Add(b_a23);
                        b_p2.Add(b_a24); b_p2.Add(b_a25); b_p2.Add(b_a26); b_p2.Add(b_a27); b_p2.Add(b_a28); b_p2.Add(b_a29); b_p2.Add(b_a30);
                       
                        paragraph.Add(b_p2);
                        document.Add(paragraph);
                        Phrase b_p3 = new Phrase();
                        Chunk b_a31 = new Chunk("\n\nPrincipal\n\n", NormalFont);
                        paragraph = new Paragraph();
                        paragraph.Alignment = (Element.ALIGN_RIGHT);
                        paragraph.Add(b_a31);
                        document.Add(paragraph);

                        Phrase b_p4 = new Phrase();
                        paragraph = new Paragraph();
                        paragraph.Alignment = (Element.ALIGN_LEFT);
                        Chunk b_a32 = new Chunk("C.C.", NormalFont);
                        b_a32.SetUnderline(f1, f2);
                        Chunk b_a33 = new Chunk("\n1. Admission Section. ", NormalFont);
                        Chunk b_a34 = new Chunk("\n2. Record.", NormalFont);
                        b_p4.Add(b_a32); b_p4.Add(b_a33); b_p4.Add(b_a34);
                        paragraph.Add(b_p4);
                        document.Add(paragraph);
                        #endregion
                        break;

                    case "Marks Certificate":
                        //Marks Certificate code is pending that is the reson we are hiding print option for that
                        break;
                    default:
                        // code block
                        break;
                }
                document.Close();
                byte[] bytes = memoryStream.ToArray();
                memoryStream.Close();
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + dr["RollNo"] + "_" + certificateType + ".pdf");
                Response.ContentType = "application/pdf";
                Response.Buffer = true;
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.BinaryWrite(bytes);
                Response.End();
                Response.Close();
            }
        }

        public static BaseFont GetFont(string fontName)
        {
            return BaseFont.CreateFont(HttpContext.Current.Server.MapPath("/CertifiCATES/Fonts/" + fontName + ".ttf"), BaseFont.CP1252, BaseFont.EMBEDDED);
        }

        public static Font GetFont(string fontName, string filename)
        {
            if (!FontFactory.IsRegistered(fontName))
            {
                // C:\\Windows\\fonts\\Monotype Corsiva.ttf
                var fontPath = "C:\\Users\\KHAN_WRS\\Downloads\\monotype-corsiva\\" + filename;
                //var fontPath = Environment.GetEnvironmentVariable("SystemRoot") + "\\fonts\\" + filename;
                FontFactory.Register(fontPath);
            }
            return FontFactory.GetFont(fontName, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        }

        private static void DrawLine(PdfWriter writer, float x1, float y1, float x2, float y2, BaseColor color)
        {
            PdfContentByte contentByte = writer.DirectContent;
            contentByte.SetColorStroke(color);
            contentByte.MoveTo(x1, y1);
            contentByte.LineTo(x2, y2);
            contentByte.Stroke();
        }
        private static PdfPCell PhraseCell(Phrase phrase, int align)
        {
            PdfPCell cell = new PdfPCell(phrase);
            cell.BorderColor = BaseColor.WHITE;
            cell.VerticalAlignment = PdfPCell.ALIGN_TOP;
            cell.HorizontalAlignment = align;
            cell.PaddingBottom = 2f;
            cell.PaddingTop = 0f;
            return cell;
        }

        private static PdfPCell ImageCell(string path, float scale, int align)
        {
            iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath(path));
            image.ScalePercent(scale);
            PdfPCell cell = new PdfPCell(image);
            cell.BorderColor = BaseColor.WHITE;
            cell.VerticalAlignment = PdfPCell.ALIGN_TOP;
            cell.HorizontalAlignment = align;
            cell.PaddingBottom = 0f;
            cell.PaddingTop = 0f;
            return cell;
        }

        private DataSet FetchCertificateDetails()
        {
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                ds = new DataSet();
                sqlCmd = new SqlCommand("spCertificates", conn);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@ActionType", "FetchData");
                SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
                sqlSda.Fill(ds);
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
            finally
            {
                sqlCmd.Dispose();
                ds.Dispose();
                conn.Close();
            }
            return ds;
        }

        protected void btnIssueCertificate_Click(object sender, EventArgs e)
        {
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtRemarks.Text = string.Empty;
            dvReceiveCertificate.Visible = false;
            GetCertificateDetails();
        }

        protected void UpdateCertificateDetails(bool isCertificateVerified, string entries)
        {
            string certificateSectionIssuerEntries = entries;
            try
            {
                if (isCertificateVerified)
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    dtData = new DataTable();
                    sqlCmd = new SqlCommand();
                    sqlCmd = new SqlCommand("spCertificates", conn);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("@ActionType", "SaveDataIssued");
                    sqlCmd.Parameters.AddWithValue("@Id", ID);
                    sqlCmd.Parameters.AddWithValue("@CertificateSectionIssuerEntries", certificateSectionIssuerEntries);
                    sqlCmd.Parameters.AddWithValue("@CertificateSectionIssuedOn", DateTime.Now);
                    sqlCmd.Parameters.AddWithValue("@IsCertificateReady", true);

                    int numRes = sqlCmd.ExecuteNonQuery();
                    if (numRes > 0)
                    {
                        lblError.Text = "Record Updated Successfully";
                        lblError.ForeColor = System.Drawing.Color.CornflowerBlue;
                        lblError.Font.Size = 16;
                        GetCertificateDetails();
                    }
                    else
                        lblError.Text = ("Please Try Again !!!");
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

        protected void lnkIssue_Click(object sender, EventArgs e)
        {
            string[] arg = ((LinkButton)sender).CommandArgument.Split(';');
            // CertificateSectionIssuedOn IsCertificateReady

            string uid = "UserID";
            string machineName = System.Environment.MachineName;
            HttpBrowserCapabilities bc = Request.Browser;
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = "";
            // Get the IP
            //ipAddress = Dns.GetHostByName(machineName).AddressList[0].ToString();
            ipAddress = Dns.GetHostEntry(machineName).AddressList[1].ToString();
            //UserID + UserMachineName / HostName + Browser + IPAddress + IsMobileDevice
            string certificateSectionIssuerEntries = uid + "^" + machineName + "^" + bc.Browser + "^" + ipAddress + "^" + bc.IsMobileDevice;

            Session["Id"] = arg[0];
            Session["CertificateType"] = arg[1];
            Session["IsCertificateVerified"] = arg[2];

            //string id = string.Empty;
            string certificateType = string.Empty;
            bool isCertificateVerified = false;

            if (!string.IsNullOrEmpty(Session["Id"].ToString()))
            {
                ID = Convert.ToInt32(Session["Id"].ToString());
            }
            if (!string.IsNullOrEmpty(Session["CertificateType"].ToString()))
            {
                certificateType = Session["CertificateType"].ToString();
            }
            if (!string.IsNullOrEmpty(Session["IsCertificateVerified"].ToString()))
            {
                isCertificateVerified = Convert.ToBoolean(Session["IsCertificateVerified"]);
            }
            UpdateCertificateDetails(isCertificateVerified, certificateSectionIssuerEntries);
        }

        protected void grdIssuedCertificatesDetail_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "PrintCertificate")
            {
                string[] arg = new string[2];
                arg = e.CommandArgument.ToString().Split(';');
                Session["Id"] = arg[0];
                Session["CertificateType"] = arg[1];
                GenerateReport(null, null);
            }
            if (e.CommandName == "ReceiveCertificate")
            {
                string[] arg = new string[8];
                arg = e.CommandArgument.ToString().Split(';');
                Session["Id"] = arg[0];
                Session["Name"] = arg[1];
                Session["CertificateType"] = arg[2];
                Session["AppliedOn"] = arg[3];
                Session["IsCertificateVerified"] = arg[4];
                Session["CertificateSectionIssuedOn"] = arg[5];
                Session["IsCertificateReady"] = arg[6];
                Session["CertificateSectionReceivedRemarks"] = arg[7];

                dvReceiveCertificate.Visible = true;
                if (!string.IsNullOrEmpty(Session["Name"].ToString()))
                {
                    lblName.Text = Session["Name"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["CertificateType"].ToString()))
                {
                    lblCertificateType.Text = Session["CertificateType"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["AppliedOn"].ToString()))
                {
                    lblAppliedOn.Text = Session["AppliedOn"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["IsCertificateVerified"].ToString()))
                {
                    lblCertificateVerified.Text = Session["IsCertificateVerified"].ToString() == "True" ? "Yes" : "No";
                }
                if (!string.IsNullOrEmpty(Session["CertificateSectionIssuedOn"].ToString()))
                {
                    lblIssuedOn.Text = Session["CertificateSectionIssuedOn"].ToString();
                }
                if (!string.IsNullOrEmpty(Session["IsCertificateReady"].ToString()))
                {
                    lblCertificateReady.Text = Session["IsCertificateReady"].ToString() == "True" ? "Yes" : "No"; ;
                }
                if (!string.IsNullOrEmpty(Session["CertificateSectionReceivedRemarks"].ToString()))
                {
                    txtRemarks.Text = Session["CertificateSectionReceivedRemarks"].ToString();
                }
            }
        }

        protected void btnReceiveCertificate_Click(object sender, EventArgs e)
        {
            string uid = "UserID";
            string machineName = System.Environment.MachineName;
            HttpBrowserCapabilities bc = Request.Browser;
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = "";
            // Get the IP
            //ipAddress = Dns.GetHostByName(machineName).AddressList[0].ToString();
            ipAddress = Dns.GetHostEntry(machineName).AddressList[1].ToString();
            //UserID + UserMachineName / HostName + Browser + IPAddress + IsMobileDevice
            string certificateSectionReceivedEntries = uid + "^" + machineName + "^" + bc.Browser + "^" + ipAddress + "^" + bc.IsMobileDevice;

            if (!string.IsNullOrEmpty(Session["Id"].ToString()))
            {
                ID = Convert.ToInt32(Session["Id"]);
            }
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                dtData = new DataTable();
                sqlCmd = new SqlCommand();
                sqlCmd = new SqlCommand("spCertificates", conn);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@ActionType", "SaveDataReceived");
                sqlCmd.Parameters.AddWithValue("@Id", ID);
                sqlCmd.Parameters.AddWithValue("@CertificateSectionReceivedEntries", certificateSectionReceivedEntries);
                sqlCmd.Parameters.AddWithValue("@CertificateSectionReceivedOn", DateTime.Now);
                sqlCmd.Parameters.AddWithValue("@CertificateSectionReceivedRemarks", txtRemarks.Text);
                int numRes = sqlCmd.ExecuteNonQuery();
                if (numRes > 0)
                {
                    lblError.Text = "Record Updated Successfully";
                    lblError.ForeColor = System.Drawing.Color.CornflowerBlue;
                    lblError.Font.Size = 16;
                    dvReceiveCertificate.Visible = false;
                    GetCertificateDetails();
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

        protected void grdPendingCertificatesDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string AppliedOn = e.Row.Cells[4].Text;
                string date = AppliedOn.Substring(0, 11);
                DateTime visitDate = DateTime.Parse(date);
                //Label2.Text = visitDate.ToString("dd-MMM-yyyy");//30-May-2012 

                // getting ShortTime from DateTime
                // using Subtract() method;
                TimeSpan value = DateTime.Now.Subtract(visitDate);

                int appliedDays = value.Days;
                if (appliedDays > 4)
                {
                    e.Row.BackColor = System.Drawing.Color.Coral;
                    e.Row.ToolTip = "Application has been overdue for printing";
                }
                else
                {
                    e.Row.BackColor = System.Drawing.Color.LightBlue;
                    e.Row.ToolTip = "Application has issued and scheduled for printing.";
                }
                Label isCertficatePrinted = (e.Row.FindControl("lblIsCertificatePrinted") as Label);
                if (isCertficatePrinted.Text == "True")
                {
                    LinkButton IssuedOn = (LinkButton)e.Row.FindControl("lnkIssue");
                    IssuedOn.Visible = true;
                }                
                Label certificateType = (e.Row.FindControl("lblCertificateType") as Label);
                if (certificateType.Text == "Marks Certificate")
                {
                    LinkButton lnkPrint = (LinkButton)e.Row.FindControl("lnkPrint");
                    lnkPrint.Visible = false;
                    LinkButton IssuedOn = (LinkButton)e.Row.FindControl("lnkIssue");
                    IssuedOn.Visible = true;
                }
            }
        }

        protected void lnkPrint_Click(object sender, EventArgs e)
        {
            string[] arg = ((LinkButton)sender).CommandArgument.Split(';');
            Session["Id"] = arg[0];
            Session["CertificateType"] = arg[1];
            Session["IsCertificatePrinted"] = arg[2];
            Session["CertificateSectionPrintedDate"] = arg[3];
            Session["CertificateNo"] = arg[4];
            Session["CertificateSectionIssuedNumber"] = arg[5];

            string[] args = new string[2];
            string previousNumberDate = "";
            string newNumberDate = "";
            int newNumberDateNo=0;
            int previousCertificateNo = 0;
            int newCertificateNo = 0;
            if (!string.IsNullOrEmpty(Session["Id"].ToString()))
            {
                ID = Convert.ToInt32(Session["Id"].ToString());
            }
            try
            {
                if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            dtData = new DataTable();
            sqlCmd = new SqlCommand("spCertificates", conn);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@CertificateType", Session["CertificateType"]);
            sqlCmd.Parameters.AddWithValue("@ActionType", "FetchDataForNumberDate");
            SqlDataAdapter sqlSda = new SqlDataAdapter(sqlCmd);
            sqlSda.Fill(dtData);
            if (dtData != null && dtData.Rows.Count > 0)
            {
                dr = dtData.Rows[0];
                string dischargeCert = "/DT-";
                string provisionalCert = "/PC-";
                string migrationCert = "/M-";
                string bonafideCert = "/BS-";

                if (ID == Convert.ToInt32(dr["ID"]) && Convert.ToBoolean(Session["IsCertificatePrinted"]) == true)
                {
                        //Don't update the current row as it has been already printed
                }
                    else if (ID != Convert.ToInt32(dr["ID"]) && Convert.ToBoolean(Session["IsCertificatePrinted"]) == true)
                    {
                        //Don't update the current row as it has been already printed
                    }
                    else if (Convert.ToBoolean(Session["IsCertificatePrinted"]) == false)
                {
                    if (!string.IsNullOrEmpty(dr["CertificateSectionIssuedNumber"].ToString()) && !string.IsNullOrEmpty(dr["CertificateNo"].ToString()))
                    {
                        previousNumberDate = Convert.ToString(dr["CertificateSectionIssuedNumber"]);
                        args = previousNumberDate.Split('/');
                        newNumberDateNo = Convert.ToInt32(args[0]);
                        newNumberDate = (newNumberDateNo + 1).ToString();
                        if (Session["CertificateType"].ToString() == "Migration Certificate")
                        {
                            newNumberDate = newNumberDate +"/"+ args[1];
                            //previousCertificateNo = Convert.ToInt32(dr["CertificateNo"]);
                            //newCertificateNo = previousCertificateNo + 1;
                        }
                        else if (Session["CertificateType"].ToString() == "Bonafide/Studentship Certificate")
                        {
                            newNumberDate = newNumberDate + "/" + args[1];
                            //previousCertificateNo = Convert.ToInt32(dr["CertificateNo"]);
                            //newCertificateNo = previousCertificateNo + 1;
                        }
                        else if (Session["CertificateType"].ToString() == "Discharge/Transfer Certificate")
                        {
                            //newNumberDate = newNumberDate + dischargeCert + args[1];
                            previousCertificateNo = Convert.ToInt32(dr["CertificateNo"]);
                            newCertificateNo = previousCertificateNo + 1;
                        }
                        else if (Session["CertificateType"].ToString() == "Provisional cum Character Certificate")
                        {
                            newNumberDate = newNumberDate + "/" + args[1];
                            previousCertificateNo = Convert.ToInt32(dr["CertificateNo"]);
                            newCertificateNo = previousCertificateNo + 1;
                        }
                    }
                    else
                    {
                        if (Session["CertificateType"].ToString() == "Migration Certificate")
                        {
                            newNumberDate = "1200" + migrationCert + DateTime.Now.Year;
                            //newCertificateNo = 78;
                        }
                        else if (Session["CertificateType"].ToString() == "Bonafide/Studentship Certificate")
                        {
                            newNumberDate = "3000" + bonafideCert + DateTime.Now.Year;
                            //newCertificateNo = 78;
                        }
                        else if (Session["CertificateType"].ToString() == "Discharge/Transfer Certificate")
                        {
                            newNumberDate = "7000" + dischargeCert + DateTime.Now.Year;
                            newCertificateNo = 1800;
                        }
                        else if (Session["CertificateType"].ToString() == "Provisional cum Character Certificate")
                        {
                            newNumberDate = "8000" + provisionalCert + DateTime.Now.Year;
                            newCertificateNo = 3800;
                        }
                    }
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    dtData = new DataTable();
                    sqlCmd = new SqlCommand();
                    sqlCmd = new SqlCommand("spCertificates", conn);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("@ActionType", "SaveDataPrinted");
                    sqlCmd.Parameters.AddWithValue("@Id", ID);
                    sqlCmd.Parameters.AddWithValue("@IsCertificatePrinted", true);
                    sqlCmd.Parameters.AddWithValue("@CertificateSectionPrintedDate", DateTime.Now);
                    sqlCmd.Parameters.AddWithValue("@CertificateNo", newCertificateNo);
                    sqlCmd.Parameters.AddWithValue("@CertificateSectionIssuedNumber", newNumberDate);
                    int numRes = sqlCmd.ExecuteNonQuery();
                    if (numRes > 0)
                    {
                        lblError.Text = "Record Updated Successfully";
                        lblError.ForeColor = System.Drawing.Color.CornflowerBlue;
                        lblError.Font.Size = 16;
                        dvReceiveCertificate.Visible = false;
                    }
                    else
                        lblError.Text = ("Please Try Again !!!");
                }
            }                  
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
            GenerateReport(null, null);
        }
    }
}