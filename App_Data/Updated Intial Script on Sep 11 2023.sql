DROP Database [IC]
GO
CREATE DATABASE [IC]
GO


USE [IC]
GO

/****** Object: Table [dbo].[tbStudentApplication] Script Date: 11-09-2023 00:40:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
	Tables
*/

CREATE TABLE [dbo].[tbStudentApplication] (
    [Id]                                BIGINT         IDENTITY (1, 1) NOT NULL,
    [RollNo]                            INT            NULL,
    [CertificateType]                   NVARCHAR (100) NULL,
    [PaymentStatus]                     BIT            NULL,
    [AppliedOn]                         DATETIME       NULL,
    [ExamAdminTypeValue]                NVARCHAR (10)  NULL,
    [IsExamSectionVerified]             BIT            NULL,
    [IsAdminSectionVerified]            BIT            NULL,
    [IsLibrarySectionVerified]          BIT            NULL,
    [IsPhysicalEduSectionVerified]      BIT            NULL,
    [IsHostelSectionVerified]           BIT            NULL,
    [ExamSectionRemarks]                NVARCHAR (MAX) NULL,
    [AdminSectionRemarks]               NVARCHAR (MAX) NULL,
    [LibrarySectionRemarks]             NVARCHAR (MAX) NULL,
    [PhysicalEduSectionRemarks]         NVARCHAR (MAX) NULL,
    [HostelSectionRemarks]              NVARCHAR (MAX) NULL,
    [ExamSectionVerifierEntries]        NVARCHAR (MAX) NULL,
    [AdminSectionVerifierEntries]       NVARCHAR (MAX) NULL,
    [LibrarySectionVerifierEntries]     NVARCHAR (MAX) NULL,
    [PhysicalEduSectionVerifierEntries] NVARCHAR (MAX) NULL,
    [HostelSectionVerifierEntries]      NVARCHAR (MAX) NULL,
    [AdminSectionVerifiedOn]            DATETIME       NULL,
    [ExamSectionVerifiedOn]             DATETIME       NULL,
    [LibrarySectionVerifiedOn]          DATETIME       NULL,
    [PhysicalEduSectionVerifiedOn]      DATETIME       NULL,
    [HostelSectionVerifiedOn]           DATETIME       NULL,
    [IsCertificateVerified]             BIT            NULL,
    [IsCertificatePrinted]              BIT            NULL,
    [CertificateSectionPrintedDate]     DATETIME       NULL,
    [CertificateNo]                     INT            NULL,
    [CertificateSectionIssuedNumber]    NVARCHAR (100) NULL,
    [CertificateSectionIssuerEntries]   NVARCHAR (200) NULL,
    [CertificateSectionIssuedOn]        DATETIME       NULL,
    [CertificateSectionReceivedEntries] NVARCHAR (MAX) NULL,
    [CertificateSectionReceivedOn]      DATETIME       NULL,
    [CertificateSectionReceivedRemarks] NVARCHAR (MAX) NULL,
    [IsCertificateReady]                BIT            NULL
);
GO

CREATE TABLE [dbo].[tbStudentDetails] (
    [Classrollno]    INT            NOT NULL,
    [Name]           NVARCHAR (255) NULL,
    [Parentage]      NVARCHAR (255) NULL,
    [Email]          NVARCHAR (255) NULL,
    [DOB]            DATETIME       NULL,
    [PhoneNo]        BIGINT         NULL,
    [RegistrationNo] NVARCHAR (255) NULL,
    [CourseApplied]  NVARCHAR (255) NULL,
    [Address]        NVARCHAR (255) NULL,
    [Obtmarks]       FLOAT (53)     NULL,
    [Twelvemarks]    NVARCHAR (255) NULL,
    [Session]        NVARCHAR (255) NULL,
    [Semester]       NVARCHAR (255) NULL,
    [Batch]          NVARCHAR (255) NULL
);
GO

CREATE TABLE [dbo].[tbUsers] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (100) NOT NULL,
    [Email]          NVARCHAR (100) NOT NULL,
    [Password]       NVARCHAR (100) NOT NULL,
    [PhoneNo]        BIGINT         NULL,
    [UserType]       NVARCHAR (100) NULL,
    [RollNo]         NVARCHAR (10)  NULL,
    [DepartmentType] NVARCHAR (100) NULL
);
GO

/*
	End of Tables
*/


/*
	Procedures
*/

Create PROCEDURE [dbo].[spApplications]  
(  
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
        select * from tbStudentDetails WHERE classrollno =  @RollNo--WHERE classrollno =  @RollNo --'21770006'
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
		 Select Id, [Name], RollNo,CourseApplied, CertificateType, AppliedOn, IsCertificateVerified, parentage, [address], email, dob, obtmarks, RegistrationNo as RegistrationNo, 
		 CourseApplied,[Session] as [Session], [Batch] as [Batch], Semester as Semester, CertificateType as ExamMonthYear, CertificateNo, CertificateSectionIssuedNumber, 
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
            INSERT INTO tbUsers ([Name],Email,[Password],PhoneNo,UserType, RollNo, DepartmentType)  
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

	    IF @ActionType = 'FetchStudentUser'  
    BEGIN  
        Select * from tbStudentDetails where classrollno=@RollNo and [PhoneNo]=@Password
    END 

	
	
    IF @ActionType = 'DeleteUsers'  
    BEGIN  
        DELETE tbUsers WHERE Id=@Id  
    END  
 
END
GO


/*
	End of Procedures
*/

/*
	Insertion Data for the table tbStudentDetails
*/

INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20191701, N'Yasir', N'Mehraj u Din', N'yasir@gmail.com', '07-22-2007', 9858456312, N'ICSC-2019-1701-BBA', N'BBA', NULL, NULL, NULL, N'Summer', N'6th', N'2019')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20191702, N'Hashim', N'Waqar Younis', N'waqar@gmail.com', '12-12-2003', 9858456312, N'ICSC-2019-1701-MBA', N'MBA', NULL, NULL, NULL, N'Spring', N'6th', N'2019')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20191703, N'Lubna Hamid', N'Hamid baba', N'hamid@gmail.com', '02-07-2004', 9858456312, N'ICSC-2019-1703-MBA', N'MBA', NULL, NULL, NULL, N'Summer', N'6th', N'2019')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20201201, N'Raja K', N'Bashir Ahmad', N'raja@gmail.com', '07-31-2002', 9858456312, N'ICSC-2020-1201-BCA', N'Computer Science', NULL, NULL, NULL, N'Spring', N'6th', N'2020')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20201202, N'Wasim Thakur', N'Wasee Raja', N'wasim@gmail.com', '07-31-2001', 9858456312, N'ICSC-2020-1202-BCA', N'Computer Science', NULL, NULL, NULL, N'Spring', N'6th', N'2020')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20201203, N'Prateeq Mehra', N'Sham Mehra', N'sham@gmail.com', '07-31-2003', 9858456312, N'ICSC-2020-1203-BCA', N'Computer Science', NULL, NULL, NULL, N'Summer', N'6th', N'2020')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20201204, N'Wahid', N'Junaid Zargar', N'junaid@gmail.com', '07-31-2007', 9858456312, N'ICSC-2020-1204-BCA', N'Computer Science', NULL, NULL, NULL, N'Summer', N'6th', N'2020')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20201205, N'Rameez Khan', N'Qasim Khan', N'rameez@gmail.com', '07-31-2008', 9858456312, N'ICSC-2020-1205-BCA', N'Computer Science', NULL, NULL, NULL, N'Spring', N'6th', N'2020')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20201206, N'Saba Mehraj', N'Mehraj u Din', N'saba@gmail.com', '07-27-2002', 9858456312, N'ICSC-2020-1206-BCA', N'Computer Science', NULL, NULL, NULL, N'Summer', N'6th', N'2020')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20201207, N'Anfa', N'Wahid thakur', N'wahid@gmail.com', '02-26-2002', 9858456312, N'ICSC-2020-1207-BCA', N'Computer Science', NULL, NULL, NULL, N'Summer', N'6th', N'2020')
INSERT INTO [dbo].[tbStudentDetails] ([Classrollno], [Name], [Parentage], [Email], [DOB], [PhoneNo], [RegistrationNo], [CourseApplied], [Address], [Obtmarks], [Twelvemarks], [Session], [Semester], [Batch]) VALUES (20201208, N'Ramesh Kumar', N'Rohit Kumar', N'rohit@gmail.com', '07-31-2001', 9858456312, N'ICSC-2021-1208-BBA', N'BBA', NULL, NULL, NULL, N'Spring', N'4th', N'2021')

/*
	End of Insertion Data for the table tbStudentDetails
*/