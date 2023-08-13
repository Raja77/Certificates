DROP DATABASE [IC]
GO
CREATE DATABASE [IC]
GO

USE [IC]
GO

/****** Object:  Table [dbo].[tbStudentApplication]    Script Date: 1/1/2022 2:49:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbStudentApplication](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RollNo] [int] NULL,
	[CertificateType] [nvarchar](100) NULL,
	[PaymentStatus] [bit] NULL,
	[AppliedOn] [datetime] NULL,
	[ExamAdminTypeValue] [nvarchar](10) NULL,
	[IsExamSectionVerified] [bit] NULL,
	[IsAdminSectionVerified] [bit] NULL,
	[IsLibrarySectionVerified] [bit] NULL,
	[IsPhysicalEduSectionVerified] [bit] NULL,
	[IsHostelSectionVerified] [bit] NULL,
	[ExamSectionRemarks] [nvarchar](max) NULL,
	[AdminSectionRemarks] [nvarchar](max) NULL,
	[LibrarySectionRemarks] [nvarchar](max) NULL,
	[PhysicalEduSectionRemarks] [nvarchar](max) NULL,
	[HostelSectionRemarks] [nvarchar](max) NULL,
	[ExamSectionVerifierEntries] [nvarchar](max) NULL,
	[AdminSectionVerifierEntries] [nvarchar](max) NULL,
	[LibrarySectionVerifierEntries] [nvarchar](max) NULL,
	[PhysicalEduSectionVerifierEntries] [nvarchar](max) NULL,
	[HostelSectionVerifierEntries] [nvarchar](max) NULL,
	[AdminSectionVerifiedOn] [datetime] NULL,
	[ExamSectionVerifiedOn] [datetime] NULL,
	[LibrarySectionVerifiedOn] [datetime] NULL,
	[PhysicalEduSectionVerifiedOn] [datetime] NULL,
	[HostelSectionVerifiedOn] [datetime] NULL,
	[IsCertificateVerified] [bit] NULL,
	[IsCertificatePrinted] [bit] NULL,
	[CertificateSectionPrintedDate] [datetime] NULL,
	[CertificateNo] [int] NULL,
	[CertificateSectionIssuedNumber] [nvarchar](100) NULL,
	[CertificateSectionIssuerEntries] [nvarchar](200) NULL,
	[CertificateSectionIssuedOn] [datetime] NULL,
	[CertificateSectionReceivedEntries] [nvarchar](max) NULL,
	[CertificateSectionReceivedOn] [datetime] NULL,
	[CertificateSectionReceivedRemarks] [nvarchar](max) NULL,
	[IsCertificateReady] [bit] NULL,
 CONSTRAINT [PK__tbStuden__3214EC07A4E57ADB] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


CREATE TABLE [dbo].[tbStudentDetails] (
    [CourseApplied] NVARCHAR (255) NULL,
    [classrollno]   INT           NOT NULL,
    [name]          NVARCHAR (255) NULL,
    [parentage]     NVARCHAR (255) NULL,
    [address]       NVARCHAR (255) NULL,
    [email]         NVARCHAR (255) NULL,
    [dob]           DATETIME       NULL,
    [obtmarks]      FLOAT (53)     NULL,
    [twelvemarks]   NVARCHAR (255) NULL, 
    CONSTRAINT [PK_tbStudentDetails] PRIMARY KEY ([classrollno])
);
GO

CREATE TABLE [dbo].[tbUsers] (
	[Id] INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] nvarchar(100) NOT NULL, 
    [Email] NVARCHAR(100) NOT NULL, 
    [Password] NVARCHAR(100) NOT NULL, 
    [PhoneNo] BIGINT NULL, 
    [UserType] NVARCHAR(100) NULL, 
    [RollNo] NVARCHAR(10) NULL, 
    [DepartmentType] NVARCHAR(100) NULL
)
GO

CREATE PROCEDURE [dbo].[spApplications]  (  
    @Id INT = NULL,  
    @AdminSectionVerifierEntries VARCHAR(max) = NULL,  
	@IsAdminSectionVerified Bit = NULL,
    @AdminSectionRemarks NVARCHAR(max) = NULL, 
    @AdminSectionVerifiedOn datetime = NULL,  
	@ExamSectionVerifierEntries NVARCHAR(max) = NULL,  
	@IsExamSectionVerified Bit = NULL,
    @ExamSectionRemarks NVARCHAR(max) = NULL, 
    @ExamSectionVerifiedOn datetime = NULL,	
	@IsCertificateVerified Bit = NULL, 
	@CertificateType VARCHAR(50) = NULL, 
	@LibrarySectionVerifierEntries NVARCHAR(max) = NULL,
	@IsLibrarySectionVerified Bit = NULL,
	@LibrarySectionRemarks NVARCHAR(max) = NULL,
	@LibrarySectionVerifiedOn datetime = NULL,
	@PhysicalEduSectionVerifierEntries NVARCHAR(max) = NULL,
	@IsPhysicalEduSectionVerified Bit = NULL,
	@PhysicalEduSectionRemarks NVARCHAR(max) = NULL,
	@PhysicalEduSectionVerifiedOn datetime = NULL,
	@HostelSectionVerifierEntries NVARCHAR(max) = NULL,
	@IsHostelSectionVerified Bit = NULL,
	@HostelSectionRemarks NVARCHAR(max) = NULL,
	@HostelSectionVerifiedOn datetime = NULL,
	@RollNo INT = NULL, 
	@PaymentStatus Bit =NULL,
	@AppliedOn datetime = NULL,  
	@ExamAdminTypeValue NVARCHAR(10) = NULL,    
	@Name NVARCHAR(100) = NULL,
	@Course NVARCHAR(100) = NULL,
	@FromOrderDate datetime = NULL,	
	@ToOrderDate datetime = NULL,
	@ActionType VARCHAR(25)
)  
AS  
BEGIN  
    IF @ActionType = 'SaveDataAdminSection'  
    BEGIN  
        IF NOT EXISTS (SELECT * FROM tbStudentApplication WHERE Id=@Id)  
        BEGIN  
            INSERT INTO tbStudentApplication (AdminSectionVerifierEntries,IsAdminSectionVerified,AdminSectionRemarks,IsCertificateVerified,AdminSectionVerifiedOn)  
            VALUES (@AdminSectionVerifierEntries,@IsAdminSectionVerified,@AdminSectionRemarks,@IsCertificateVerified,@AdminSectionVerifiedOn)  
        END  
        ELSE  
        BEGIN  
            UPDATE tbStudentApplication SET AdminSectionVerifierEntries=@AdminSectionVerifierEntries,IsAdminSectionVerified=@IsAdminSectionVerified,AdminSectionRemarks=@AdminSectionRemarks,  
            IsCertificateVerified=@IsCertificateVerified, AdminSectionVerifiedOn=@AdminSectionVerifiedOn,IsCertificatePrinted=0,IsCertificateReady=0 WHERE Id=@Id  
        END  
    END 
	  IF @ActionType = 'SaveDataExamSection'  
    BEGIN  
        IF NOT EXISTS (SELECT * FROM tbStudentApplication WHERE Id=@Id)  
        BEGIN  
            INSERT INTO tbStudentApplication (ExamSectionVerifierEntries,IsExamSectionVerified,ExamSectionRemarks,IsCertificateVerified,ExamSectionVerifiedOn)  
            VALUES (@ExamSectionVerifierEntries,@IsExamSectionVerified,@ExamSectionRemarks,@IsCertificateVerified,@ExamSectionVerifiedOn)  
        END  
        ELSE  
        BEGIN  
            UPDATE tbStudentApplication SET ExamSectionVerifierEntries=@ExamSectionVerifierEntries,IsExamSectionVerified=@IsExamSectionVerified,ExamSectionRemarks=@ExamSectionRemarks,  
            IsCertificateVerified=@IsCertificateVerified, ExamSectionVerifiedOn=@ExamSectionVerifiedOn,IsCertificatePrinted=0,IsCertificateReady=0 WHERE Id=@Id  
        END  
    END
	 IF @ActionType = 'SaveDataLibrarySection'  
    BEGIN  
        IF NOT EXISTS (SELECT * FROM tbStudentApplication WHERE Id=@Id)  
        BEGIN  
            INSERT INTO tbStudentApplication (LibrarySectionVerifierEntries,IsLibrarySectionVerified,LibrarySectionRemarks,IsCertificateVerified,LibrarySectionVerifiedOn)  
            VALUES (@LibrarySectionVerifierEntries,@IsLibrarySectionVerified,@LibrarySectionRemarks,@IsCertificateVerified,@LibrarySectionVerifiedOn)  
        END  
        ELSE  
        BEGIN  
            UPDATE tbStudentApplication SET LibrarySectionVerifierEntries=@LibrarySectionVerifierEntries,IsLibrarySectionVerified=@IsLibrarySectionVerified,LibrarySectionRemarks=@LibrarySectionRemarks,  
            IsCertificateVerified=@IsCertificateVerified, LibrarySectionVerifiedOn=@LibrarySectionVerifiedOn,IsCertificatePrinted=0,IsCertificateReady=0 WHERE Id=@Id  
        END  
    END 
	 IF @ActionType = 'SaveDataPhyEduSection'  
    BEGIN  
        IF NOT EXISTS (SELECT * FROM tbStudentApplication WHERE Id=@Id)  
        BEGIN  
            INSERT INTO tbStudentApplication (PhysicalEduSectionVerifierEntries,IsPhysicalEduSectionVerified,PhysicalEduSectionRemarks,IsCertificateVerified,PhysicalEduSectionVerifiedOn)  
            VALUES (@PhysicalEduSectionVerifierEntries,@IsPhysicalEduSectionVerified,@PhysicalEduSectionRemarks,@IsCertificateVerified,@PhysicalEduSectionVerifiedOn)  
        END  
        ELSE  
        BEGIN  
            UPDATE tbStudentApplication SET PhysicalEduSectionVerifierEntries=@PhysicalEduSectionVerifierEntries,IsPhysicalEduSectionVerified=@IsPhysicalEduSectionVerified,PhysicalEduSectionRemarks=@PhysicalEduSectionRemarks,  
            IsCertificateVerified=@IsCertificateVerified, PhysicalEduSectionVerifiedOn=@PhysicalEduSectionVerifiedOn,IsCertificatePrinted=0,IsCertificateReady=0 WHERE Id=@Id  
        END  
    END 
	 IF @ActionType = 'SaveDataHostelSection'  
    BEGIN  
        IF NOT EXISTS (SELECT * FROM tbStudentApplication WHERE Id=@Id)  
        BEGIN  
            INSERT INTO tbStudentApplication (HostelSectionVerifierEntries,IsHostelSectionVerified,HostelSectionRemarks,IsCertificateVerified,HostelSectionVerifiedOn)  
            VALUES (@HostelSectionVerifierEntries,@IsHostelSectionVerified,@HostelSectionRemarks,@IsCertificateVerified,@HostelSectionVerifiedOn)  
        END  
        ELSE  
        BEGIN  
            UPDATE tbStudentApplication SET HostelSectionVerifierEntries=@HostelSectionVerifierEntries,IsHostelSectionVerified=@IsHostelSectionVerified,HostelSectionRemarks=@HostelSectionRemarks,  
            IsCertificateVerified=@IsCertificateVerified, HostelSectionVerifiedOn=@HostelSectionVerifiedOn,IsCertificatePrinted=0,IsCertificateReady=0 WHERE Id=@Id  
        END  
    END 
    IF @ActionType = 'DeleteData'  
    BEGIN  
        DELETE tbStudentApplication WHERE Id=@Id  
    END  
    IF @ActionType = 'FetchDataAdminSection'  
    BEGIN  
        Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue, AdminSectionVerifiedOn,Left(AdminSectionRemarks, 15) as TruncatedAdminRemarks, AdminSectionRemarks,
		IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where (ExamAdminTypeValue = 'A' OR ExamAdminTypeValue = 'EA') and IsAdminSectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())<=4  order by AppliedOn desc 

		 Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,AdminSectionVerifiedOn,Left(AdminSectionRemarks, 15) as TruncatedAdminRemarks, AdminSectionRemarks,
		 IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where (ExamAdminTypeValue = 'A' OR ExamAdminTypeValue = 'EA')and IsAdminSectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())>4 
		order by AppliedOn desc

		  Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,AdminSectionVerifiedOn,Left(AdminSectionRemarks, 15) as TruncatedAdminRemarks, AdminSectionRemarks,
		  IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where (ExamAdminTypeValue = 'A' OR ExamAdminTypeValue = 'EA') and IsAdminSectionVerified=1 order by AppliedOn desc 
    END  
	   IF @ActionType = 'FetchDataExamSection'  
    BEGIN  
        Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,ExamSectionVerifiedOn,Left(ExamSectionRemarks, 15) as TruncatedExamRemarks, ExamSectionRemarks, 
		IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where (ExamAdminTypeValue = 'E' OR ExamAdminTypeValue = 'EA') and IsExamSectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())<=4 order by AppliedOn desc 

		 Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,ExamSectionVerifiedOn,ExamSectionVerifiedOn,Left(ExamSectionRemarks, 15) as TruncatedExamRemarks,ExamSectionRemarks, 
		 IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where (ExamAdminTypeValue = 'E' OR ExamAdminTypeValue = 'EA')and IsExamSectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())>4 
		order by AppliedOn desc

		  Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,ExamSectionVerifiedOn,ExamSectionVerifiedOn,Left(ExamSectionRemarks, 15) as TruncatedExamRemarks,ExamSectionRemarks, 
		  IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where (ExamAdminTypeValue = 'E' OR ExamAdminTypeValue = 'EA') and IsExamSectionVerified=1 order by AppliedOn desc 
    END  
	    IF @ActionType = 'FetchDataLibrarySection'  
    BEGIN  
        Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue, LibrarySectionVerifiedOn,Left(LibrarySectionRemarks, 15) as TruncatedLibraryRemarks, LibrarySectionRemarks,
		IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsLibrarySectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())<=4  order by AppliedOn desc 

		 Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,LibrarySectionVerifiedOn,Left(LibrarySectionRemarks, 15) as TruncatedLibraryRemarks, LibrarySectionRemarks,
		 IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsLibrarySectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())>4 
		order by AppliedOn desc

		  Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,LibrarySectionVerifiedOn,Left(LibrarySectionRemarks, 15) as TruncatedLibraryRemarks, LibrarySectionRemarks,
		  IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsLibrarySectionVerified=1 order by AppliedOn desc 
    END
		    IF @ActionType = 'FetchDataPhyEduSection'  
    BEGIN  
        Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue, PhysicalEduSectionVerifiedOn,Left(PhysicalEduSectionRemarks, 15) as TruncatedPhysicalEduRemarks, PhysicalEduSectionRemarks,
		IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsPhysicalEduSectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())<=4  order by AppliedOn desc 

		 Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,PhysicalEduSectionVerifiedOn,Left(PhysicalEduSectionRemarks, 15) as TruncatedPhysicalEduRemarks, PhysicalEduSectionRemarks,
		 IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsPhysicalEduSectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())>4 
		order by AppliedOn desc

		  Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,PhysicalEduSectionVerifiedOn,Left(PhysicalEduSectionRemarks, 15) as TruncatedPhysicalEduRemarks, PhysicalEduSectionRemarks,
		  IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsPhysicalEduSectionVerified=1 order by AppliedOn desc 
    END
		    IF @ActionType = 'FetchDataHostelSection'  
    BEGIN  
        Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue, HostelSectionVerifiedOn,Left(HostelSectionRemarks, 15) as TruncatedHostelRemarks, HostelSectionRemarks,
		IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsHostelSectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())<=4  order by AppliedOn desc 

		 Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,HostelSectionVerifiedOn,Left(HostelSectionRemarks, 15) as TruncatedHostelRemarks, HostelSectionRemarks,
		 IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsHostelSectionVerified=0 and DATEDIFF(day, AppliedOn, GETDATE())>4 
		order by AppliedOn desc

		  Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsAdminSectionVerified,IsExamSectionVerified,PaymentStatus,ExamAdminTypeValue,HostelSectionVerifiedOn,Left(HostelSectionRemarks, 15) as TruncatedHostelRemarks, HostelSectionRemarks,
		  IsLibrarySectionVerified, IsPhysicalEduSectionVerified, IsHostelSectionVerified from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsHostelSectionVerified=1 order by AppliedOn desc 
    END
	  IF @ActionType = 'FetchDataById'  
    BEGIN  
		 Select Id, [Name], RollNo, CertificateType, PaymentStatus, AppliedOn, IsAdminSectionVerified,Left(AdminSectionRemarks, 15) as TruncatedAdminRemarks, AdminSectionRemarks, 
		 IsExamSectionVerified, ExamSectionVerifiedOn,Left(ExamSectionRemarks, 15) as TruncatedExamRemarks, ExamSectionRemarks,
		 IsLibrarySectionVerified, LibrarySectionVerifiedOn,Left(LibrarySectionRemarks, 15) as TruncatedLibraryRemarks, LibrarySectionRemarks,
		 IsPhysicalEduSectionVerified, PhysicalEduSectionVerifiedOn,Left(PhysicalEduSectionRemarks, 15) as TruncatedPhysicalEduRemarks, PhysicalEduSectionRemarks,
		 IsHostelSectionVerified, HostelSectionVerifiedOn,Left(HostelSectionRemarks, 15) as TruncatedHostelRemarks, HostelSectionRemarks
		 from tbStudentApplication sa inner  join tbStudentDetails td on sa.RollNo = td.classrollno where Id=  @Id 
    END	
	IF @ActionType = 'FetchStuDetailsByRollNo'  
    BEGIN  
        select * from tbStudentDetails WHERE classrollno =  @RollNo--WHERE classrollno =  @RollNo  /*'21770006'*/       
    END  
	 IF @ActionType = 'FetchSADetailsByRNnCert'  
    BEGIN  
        select * from tbStudentApplication where rollno=@RollNo and CertificateType=@CertificateType
    END  
	 IF @ActionType = 'FetchSADetailsByRollNo'  
    BEGIN  	
	--DECLARE @RollNo int= 21130050   
        select * from tbStudentApplication where rollno=@RollNo
		select ID, RollNo, Certificatetype, IsAdminSectionVerified, IsExamSectionVerified, AdminSectionVerifiedOn, ExamSectionVerifiedOn
		AdminSectionRemarks,ExamSectionRemarks, 	(SELECT  
		Case  Certificatetype  
		 WHEN  'Provisional cum Character Certificate'  THEN  (Select AdminSectionRemarks from tbStudentApplication where Certificatetype='Provisional cum Character Certificate' and IsAdminSectionVerified=0
		 and RollNo=@RollNo)  
		 WHEN  'Marks Certificate' THEN  (Select ExamSectionRemarks from tbStudentApplication where Certificatetype='Marks Certificate' and IsExamSectionVerified=0 and RollNo=@RollNo)  
		 WHEN  'Bonafide/Studentship Certificate' THEN    (Select AdminSectionRemarks from tbStudentApplication where Certificatetype='Bonafide/Studentship Certificate' and IsAdminSectionVerified=0  and RollNo=@RollNo)  
		  WHEN  'Migration Certificate' THEN    (Select AdminSectionRemarks from tbStudentApplication where Certificatetype='Migration Certificate'and IsAdminSectionVerified=0 and RollNo=@RollNo) 
		  WHEN  'Discharge/Transfer Certificate' THEN    (Select AdminSectionRemarks from tbStudentApplication where Certificatetype='Discharge/Transfer Certificate' and IsAdminSectionVerified=0 and RollNo=@RollNo) 
		ELSE 'NA'  
		END   )AS Remarks		
		from tbStudentApplication where rollno=@RollNo
    END 

		  IF @ActionType = 'SaveStuAppDetails'  
    BEGIN  
        IF NOT EXISTS (SELECT * FROM tbStudentApplication WHERE rollno=@RollNo and CertificateType=@CertificateType)  
        BEGIN   
			Insert into tbStudentApplication (RollNo,CertificateType,PaymentStatus,AppliedOn,ExamAdminTypeValue, IsExamSectionVerified,IsAdminSectionVerified,IsLibrarySectionVerified,IsPhysicalEduSectionVerified,IsHostelSectionVerified)
                     values(@RollNo,@CertificateType,@PaymentStatus,@AppliedOn,@ExamAdminTypeValue,@IsExamSectionVerified,@IsAdminSectionVerified,0,0,0)
        END  
        ELSE  
        BEGIN  
            UPDATE tbStudentApplication SET ExamSectionVerifierEntries=@ExamSectionVerifierEntries,IsExamSectionVerified=@IsExamSectionVerified,ExamSectionRemarks=@ExamSectionRemarks,  
            IsCertificateVerified=@IsCertificateVerified, ExamSectionVerifiedOn=@ExamSectionVerifiedOn,IsLibrarySectionVerified = @IsLibrarySectionVerified,
			IsPhysicalEduSectionVerified=@IsPhysicalEduSectionVerified,IsHostelSectionVerified=@IsHostelSectionVerified WHERE Id=@Id  
        END  
    END
		     IF @ActionType = 'FetchAllApplications'  
    BEGIN
	
	  SELECT * FROM tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno
		WHERE ((@RollNo IS  NULL) OR RollNo like '%' + CAST(@RollNo AS NVARCHAR) + '%')  --Empname like'"
		AND (@Name IS NULL OR [Name]  LIKE '%' + @Name + '%')
		AND (@CertificateType IS NULL OR CertificateType  LIKE '%' + @CertificateType + '%')
		AND (@Course IS NULL OR CourseApplied  LIKE '%' + @Course + '%'  )
		AND ((@FromOrderDate IS NULL AND @ToOrderDate IS NULL)
        OR (@FromOrderDate IS NOT NULL AND @ToOrderDate IS NULL AND AppliedOn =  @FromOrderDate)
        OR (@FromOrderDate IS NOT NULL AND @ToOrderDate IS NOT NULL AND AppliedOn BETWEEN @FromOrderDate AND @ToOrderDate)) order by AppliedOn desc

    END	
END 
GO

CREATE PROCEDURE [dbo].[spCertificates]  
(  
    @Id INT = NULL,  
	@CertificateSectionIssuerEntries NVARCHAR(max) = NULL,
    @CertificateSectionIssuedOn datetime = NULL,	
	@IsCertificateReady Bit = NULL,
	@certificateSectionReceivedEntries NVARCHAR(max) = NULL,
	@CertificateSectionReceivedRemarks NVARCHAR(max) = NULL,
	@CertificateSectionReceivedOn datetime = NULL,	
	@CertificateType nvarchar(50)=NULL,
	@IsCertificatePrinted bit = NULL,	
	@CertificateSectionPrintedDate datetime=NULL,
	@CertificateNo int =NULL,
	@CertificateSectionIssuedNumber nvarchar(30)=NULL,
    @ActionType VARCHAR(25)  

	--delete  from tbStudentApplication
)  
AS  
BEGIN  
    IF @ActionType = 'SaveDataIssued'  
    BEGIN  
        IF NOT EXISTS (SELECT * FROM tbStudentApplication WHERE Id=@Id)  
        BEGIN  
          INSERT INTO tbStudentApplication (CertificateSectionIssuerEntries,CertificateSectionIssuedOn,IsCertificateReady)  
            VALUES (@CertificateSectionIssuerEntries,@CertificateSectionIssuedOn,@IsCertificateReady) 
        END  
        ELSE  
        BEGIN  
            UPDATE tbStudentApplication SET CertificateSectionIssuerEntries=@CertificateSectionIssuerEntries,CertificateSectionIssuedOn=@CertificateSectionIssuedOn,
			IsCertificateReady=@IsCertificateReady WHERE Id=@Id   
        END  
    END  
	 IF @ActionType = 'SaveDataReceived'  
    BEGIN   
            UPDATE tbStudentApplication SET CertificateSectionReceivedOn=@CertificateSectionReceivedOn,certificateSectionReceivedEntries=@certificateSectionReceivedEntries,
			CertificateSectionReceivedRemarks=@CertificateSectionReceivedRemarks WHERE Id=@Id          
    END 

	
	 IF @ActionType = 'SaveDataPrinted'  
    BEGIN   
            UPDATE tbStudentApplication SET IsCertificatePrinted=@IsCertificatePrinted, CertificateSectionPrintedDate=@CertificateSectionPrintedDate, CertificateNo=@CertificateNo, CertificateSectionIssuedNumber=@CertificateSectionIssuedNumber WHERE Id=@Id          
    END 

	    IF @ActionType = 'FetchDataForNumberDate'  
    BEGIN  
	--	select ID, RollNo, CertificateType, AppliedOn, IsCertificateVerified, IsCertificatePrinted, CertificateSectionPrintedDate, CertificateNo, CertificateSectionIssuedNumber from tbStudentApplication 
   --where CertificateType='discharge Certificate'  order by CertificateSectionPrintedDate desc
	   -- IF NOT EXISTS (SELECT * FROM tbStudentApplication WHERE Id=9 and CertificateType='Marks Certificate' and IsCertificatePrinted=1)  
	
	BEGIN
      	select ID,RollNo, CertificateType, AppliedOn, IsCertificateVerified, IsCertificatePrinted, CertificateSectionPrintedDate, CertificateNo, CertificateSectionIssuedNumber from tbStudentApplication 
	where CertificateType=@CertificateType  order by CertificateSectionPrintedDate desc
	--and IsCertificatePrinted=1
	  END  
  --      ELSE  
  --      BEGIN
		--nnn
		--END
    END

    IF @ActionType = 'DeleteData'  
    BEGIN  
        DELETE tbStudentApplication WHERE Id=@Id  
    END  
    IF @ActionType = 'FetchData'  
    BEGIN  
        Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsCertificateVerified,IsCertificateReady,IsCertificatePrinted,
		CertificateSectionPrintedDate, CertificateNo, CertificateSectionIssuedNumber  from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where IsCertificateVerified=1  and  ISNULL(IsCertificateReady, 0) = 0 order by AppliedOn desc 

		Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsCertificateVerified,CertificateSectionIssuedOn, CertificateSectionReceivedOn,
		CertificateSectionReceivedRemarks,IsCertificateReady,IsCertificatePrinted, CertificateSectionPrintedDate, CertificateNo, CertificateSectionIssuedNumber  from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where  IsCertificateReady=1 order by AppliedOn desc 
    END
      IF @ActionType = 'FetchDataById'  
    BEGIN  
		 Select Id, [Name], RollNo,CourseApplied, CertificateType, AppliedOn, IsCertificateVerified, parentage, [address], email, dob, obtmarks, CertificateType as RegistrationNo, 
		 CourseApplied,CertificateType as [Session-Year], CertificateType as [Session], CertificateType as Semester, CertificateType as ExamMonthYear, CertificateNo, CertificateSectionIssuedNumber, 
		 CertificateType as GazetteNotificationNo, CertificateType as GazetteNotificationDate,  CertificateType as CGPA, CertificateType as Grade
		 from tbStudentApplication sa inner  join tbStudentDetails td on sa.RollNo = td.classrollno where Id= @Id 
    END	 
END 
GO

CREATE PROCEDURE [dbo].[spUsers]  
(  
    @Id INT = NULL, 
    @Name NVARCHAR(100) = NULL,  
	@Email NVARCHAR(100)=NULL,
    @Password NVARCHAR(100)=NULL, 
    @PhoneNo bigint = NULL,
	@UserType NVARCHAR(100) = NULL,
	@RollNo NVARCHAR(10)   = NULL,
	@DepartmentType NVARCHAR(100)  = NULL,
	@ActionType VARCHAR(25)
)  
AS  
BEGIN  
    IF @ActionType = 'SaveUsers'  
    BEGIN  
        IF NOT EXISTS (SELECT * FROM tbUsers WHERE Id=@Id)  
        BEGIN  
            INSERT INTO tbUsers ([Name],[Email],[Password],PhoneNo,UserType, RollNo, DepartmentType)  
            VALUES (@Name, @Email, @Password, @PhoneNo, @UserType, @RollNo, @DepartmentType) 

		if (@DepartmentType is NULL)
			BEGIN			
				INSERT INTO tbStudentDetails ([Name],Email,classrollno)  
				VALUES (@Name, @Email, @RollNo) 
			END			
        END  
        ELSE  
        BEGIN  
            UPDATE tbUsers SET [Name]=@Name,Email=@Email,[Password]=@Password,  
            PhoneNo=@PhoneNo, UserType=@UserType,RollNo=@RollNo,DepartmentType=@DepartmentType WHERE Id=@Id  
        END  
    END 

	    IF @ActionType = 'FetchLoginUser'  
    BEGIN  
        Select * from tbUsers where Email=@Email and [Password]=@Password
    END 
	
    IF @ActionType = 'DeleteUsers'  
    BEGIN  
        DELETE tbUsers WHERE Id=@Id  
    END  
 
END
GO
