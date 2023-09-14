<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ModuleLeftMenu.ascx.cs" Inherits="Certificates.ModuleLeftMenu" %>
<link href="/Content/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="/Content/StyleSheet1.css" rel="stylesheet" />

<div class="d-flex" id="wrapper">
    <div class="bg-light border-light" id="sidebar-wrapper">
        <%--   <div class="sidebar-heading"><i class="fa fa-home"></i>&nbsp;&nbsp;Home</div>--%>
        <div class="list-group list-group-flush">
            <a id="ViewAllCerts" runat="server" visible="false" href="~/Certificates/Admin/ViewAllApplications.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;View All Applications</a>
            <a id="ApplyCerts" runat="server" visible="false" href="~/Certificates/Candidate/ApplyCertificates.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Apply for Certificate(s)</a>
            <a id="ViewCerts" runat="server" visible="false" href="~/Certificates/Candidate/ViewCertificates.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;View your Certificate(s)</a>
            <a id="Exam_Dept" runat="server" visible="false" href="~/Certificates/Admin/ExamSection.aspx" class="list-group-item list-group-item-action bg-light "><i class="fa-solid fa-gauge-simple"></i>&nbsp;Examination Section</a>
            <a id="Admission_Dept" runat="server" visible="false" href="~/Certificates/Admin/AdminSection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Admission Section</a>
            <a id="Library_Dept" runat="server" visible="false" href="~/Certificates/Admin/LibrarySection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Library Section</a>
            <a id="Hostel_Dept" runat="server" visible="false" href="~/Certificates/Admin/HostelSection.aspx" class="list-group-item list-group-item-action bg-light bg-success"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Hostel Section</a>
            <a id="PE_Dept" runat="server" visible="false" href="~/Certificates/Admin/PhysicalEducationSection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Physical Education Section</a>
            <a id="Certificate_Dept" runat="server" visible="false" href="~/Certificates/Admin/CertificateSection.aspx" class="list-group-item list-group-item-action bg-light"><i class="fa-solid fa-gauge-simple"></i>&nbsp;Certificate Section</a>
        </div>
    </div>
</div>


<script type="text/javascript">

    $(document).ready(function () {
        const currentUrl = window.location.href;

        debugger;
        if (currentUrl.includes('ViewAllApplications')) {

            var element = document.getElementById("ModuleLeftMenu_ViewAllCerts");
            element.classList.remove("bg-light");
            element.classList.add("bg-success");
        }
        else if (currentUrl.includes('ApplyCertificates')) {

            var element = document.getElementById("ModuleLeftMenu_ApplyCerts");
            element.classList.remove("bg-light");
            element.classList.add("bg-success");
        }
        else if (currentUrl.includes('ViewCertificates')) {

            var element = document.getElementById("ModuleLeftMenu_ViewCerts");
            element.classList.remove("bg-light");
            element.classList.add("bg-success");
        }
        else if (currentUrl.includes('ExamSection')) {            

            var element = document.getElementById("ModuleLeftMenu_Exam_Dept");
            element.classList.remove("bg-light");
            element.classList.add("bg-success");
        }
        else if (currentUrl.includes('AdminSection')) {

            var element = document.getElementById("ModuleLeftMenu_Admission_Dept");
            element.classList.remove("bg-light");
            element.classList.add("bg-success");
        }
        else if (currentUrl.includes('LibrarySection')) {

            var element = document.getElementById("ModuleLeftMenu_Library_Dept");
            element.classList.remove("bg-light");
            element.classList.add("bg-success");
        }
        else if (currentUrl.includes('HostelSection')) {

            var element = document.getElementById("ModuleLeftMenu_Hostel_Dept");
            element.classList.remove("bg-light");
            element.classList.add("bg-success");
        }
        else if (currentUrl.includes('PhysicalEducationSection')) {

            var element = document.getElementById("ModuleLeftMenu_PE_Dept");
            element.classList.remove("bg-light");
            element.classList.add("bg-success");
        }
        else if (currentUrl.includes('CertificateSection')) {

            var element = document.getElementById("ModuleLeftMenu_Certificate_Dept");
            element.classList.remove("bg-light");
            element.classList.add("bg-success");
        }


    });
</script>
