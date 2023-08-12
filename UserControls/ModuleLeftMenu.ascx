<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ModuleLeftMenu.ascx.cs" Inherits="Certificates.ModuleLeftMenu" %>
<link href="/Content/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="/Content/StyleSheet1.css" rel="stylesheet" />

<div class="d-flex" id="wrapper">
    <div class="bg-light border-light" id="sidebar-wrapper">
     <%--   <div class="sidebar-heading"><i class="fa fa-home"></i>&nbsp;&nbsp;Home</div>--%>
        <div class="list-group list-group-flush">
            <a id="ApplyCerts" runat="server" visible="false" href="~/Certificates/Candidate/ApplyCertificates.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Apply for Certificate(s)</a>
            <a id="ViewCerts" runat="server" visible="false" href="~/Certificates/Candidate/ViewCertificates.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;View your Certificate(s)</a>
            <a id="Exam_Dept" runat="server" visible="false" href="~/Certificates/Admin/ExamSection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Examination Section</a>
            <a id="Admission_Dept" runat="server" visible="false" href="~/Certificates/Admin/AdminSection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Admission Section</a>
            <a id="Library_Dept" runat="server" visible="false" href="~/Certificates/Admin/LibrarySection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Library Section</a>
            <a id="Hostel_Dept" runat="server" visible="false" href="~/Certificates/Admin/HostelSection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Hostel Section</a>
            <a id ="PE_Dept" runat="server" visible="false" href="~/Certificates/Admin/PhysicalEducationSection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Physical Education Section</a>
            <a id="Certificate_Dept" runat="server" visible="false" href="~/Certificates/Admin/CertificateSection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Certificate Section</a>
            <a id="ViewAllCerts" runat="server" visible="false" href="~/Certificates/Admin/ViewAllApplications.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;View All Applications</a>
        </div>
    </div>
</div>
