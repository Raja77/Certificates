USE [IC]
GO

/****** Object: SqlProcedure [dbo].[spApplications] Script Date: 14-09-2023 20:25:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spApplications]  
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
	DECLARE @RollNo int= 20201201   
        select * from tbStudentApplication where rollno=@RollNo
		select ID, RollNo, Certificatetype,IsCertificateVerified, IsAdminSectionVerified, IsExamSectionVerified, AdminSectionVerifiedOn, ExamSectionVerifiedOn, PaymentStatus,
		AdminSectionRemarks,ExamSectionRemarks,AppliedOn,  	(SELECT  
		Case  Certificatetype  
		 WHEN  'Provisional cum Character Certificate'  THEN  (Select AdminSectionRemarks from tbStudentApplication where (Certificatetype='Provisional cum Character Certificate'
		 and IsAdminSectionVerified=0 and RollNo=@RollNo))  
		 WHEN  'Marks Certificate' THEN  (Select ExamSectionRemarks from tbStudentApplication where Certificatetype='Marks Certificate' and IsExamSectionVerified=0 and RollNo=@RollNo)  
		 WHEN  'Bonafide/Studentship Certificate' THEN    (Select AdminSectionRemarks from tbStudentApplication where Certificatetype='Bonafide/Studentship Certificate' and
		 IsAdminSectionVerified=0  and RollNo=@RollNo)  
		  WHEN  'Migration Certificate' THEN    (Select AdminSectionRemarks from tbStudentApplication where Certificatetype='Migration Certificate'and IsAdminSectionVerified=0 
		  and RollNo=@RollNo) 
		  WHEN  'Discharge/Transfer Certificate' THEN    (Select AdminSectionRemarks from tbStudentApplication where Certificatetype='Discharge/Transfer Certificate' and
		  IsAdminSectionVerified=0 and RollNo=@RollNo) 
		ELSE 'NA'  
		END   )AS Remarks		
		from tbStudentApplication where rollno=@RollNo AND IsAdminSectionVerified=0 OR (IsExamSectionVerified=0 and Certificatetype='Marks Certificate' AND rollno=@RollNo)

		--For Certificates from Student side
		Select Id, [Name], CourseApplied, parentage, [address], Email, DOB,  RollNo, CertificateType, AppliedOn,IsCertificateVerified,IsCertificateReady, IsCertificatePrinted, 
		CertificateSectionPrintedDate, CertificateNo, CertificateSectionIssuedNumber, RegistrationNo  from tbStudentApplication sa
		inner  join tbStudentDetails td on sa.RollNo = td.classrollno where rollno=@RollNo and  IsCertificateVerified=1  
		--and ISNULL(IsCertificateReady, 0) = 0 
		order by AppliedOn desc 

		--Select top 1 * from tbStudentApplication
		--select top 1 * from tbStudentDetails
		
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

ALTER PROCEDURE [dbo].[spUsers]  
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

	--select * from tbusers

	    IF @ActionType = 'CheckUserExist'  
    BEGIN  
        Select count(*) from tbusers where DepartmentType=@DepartmentType or Email=@Email
    END 	
	
    IF @ActionType = 'DeleteUsers'  
    BEGIN  
        DELETE tbUsers WHERE Id=@Id  
    END  
 
END
GO