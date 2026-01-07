--vishal
use Pulse360_FinalDb;
select *  from [User];
--Departments
select * from Departments;
CREATE or alter PROC sp_GetDepartments
    @SortOrder VARCHAR(10) = '',
    @Status VARCHAR(10) = '',
    @Search VARCHAR(50) = ''
AS
BEGIN
    SELECT *
    FROM Departments
    WHERE
        (@Status='' OR Status=@Status)
        AND (@Search='' OR Name LIKE '%'+@Search+'%')
    ORDER BY
        CASE WHEN @SortOrder='ASC' THEN Name END ASC,
        CASE WHEN @SortOrder='DESC' THEN Name END DESC
END

CREATE PROC sp_SaveDepartment
    @DepartmentId INT = NULL,
    @Name VARCHAR(100),
    @Status VARCHAR(10),
    @User VARCHAR(50)
AS
BEGIN
    IF @DepartmentId IS NULL OR @DepartmentId = ''
        INSERT INTO Departments(Name,Status,CreatedBy,CreatedAt)
        VALUES(@Name,@Status,@User,GETDATE())
    ELSE
        UPDATE Departments
        SET Name=@Name,
            Status=@Status,
            ModifiedBy=@User,
            ModifiedAt=GETDATE()
        WHERE DepartmentId=@DepartmentId
END

CREATE PROC sp_DeleteDepartment
    @DepartmentId INT
AS
BEGIN
    DELETE FROM Departments WHERE DepartmentId=@DepartmentId
END



select * from [Role];

select LeaveTypeId from MasterLeaveTypes;
-- user procs
-- user triggers
select * from Trainer;
select * from Training;
select * from TrainingType;
select * from AdminDocuments;
select * from addAdminDocNames;
select * from addEmployeeDocNames;
select * from [Role];

select * from Events
select * from EventTypes

--Siddhesh Module
--Admin

--1) Adding leave type
select*from MasterLeaveTypes;

	--1.1) Insert Leave type (Submit button click)
	create procedure Pro_InsertMasterLeaveTypes
	 @LeaveType nvarchar(max)
	as
	begin
	   insert into MasterLeaveTypes (LeaveType) values (@LeaveType);
	end

	--1.2) Show table leave type
	create procedure Pro_ShowMasterLeaveTypes
	as
	begin
		select LeaveTypeId,LeaveType from MasterLeaveTypes;
	end

	--1.3) Delete leave type
	create procedure Pro_DeleteMasterLeaveTypes
	 @LeaveTypeId int
	as
	begin
	  delete from MasterLeaveTypes where LeaveTypeId=@LeaveTypeId;
	end
---------------------------------------------------------------------------------------------

--2)Allocate Leave DeptWise 
 select*from DepartmentLeaves;
 select*from MasterLeaveTypes;

 --2.1)add leave Deptwise
	create procedure Pro_AddLeave_Dept
	@DepartmentId int,
	@LeaveTypeId int,
	@LeavesCount int,
	@Status nvarchar(max)
	as
	begin
	 insert into DepartmentLeaves (DepartmentId,LeaveTypeId,LeavesCount,[Status]) values (@DepartmentId,@LeaveTypeId,@LeavesCount,@Status);
	end

  --2.2)Delete Departmentwise Leave
   create procedure Pro_DelLeave_Dept
   @DepartmentLeavesId int
   as
   begin
      delete from DepartmentLeaves where DepartmentLeavesId=@DepartmentLeavesId;
   end
-----------------------------------------------------------------------------------------------
--3)Department leave Details
create Procedure Pro_Dept_DeptLeaveCount
as
begin
  select  DL.DepartmentLeavesId, d.[Name],MLT.LeaveType,DL.LeavesCount,DL.[Status]
  from MasterLeaveTypes MLT 
  join DepartmentLeaves DL on DL.LeaveTypeId=MLT.LeaveTypeId
  join Departments d on DL.DepartmentId=d.DepartmentId;

end
------------------------------------------------------------------------------------------------
--4)Manage leave settings 
    create procedure Pro_leaveSetting
     @LeaveTypeId int,
	 @Status nvarchar(max)
   as
   begin
       update DepartmentLeaves
	   set [Status]=@Status
	   where LeaveTypeId=@LeaveTypeId;
   end;
-------------------------------------------------------------------------------------------------
--5)Attdendance admin
select*from Attendance;

  --5.1)Attendance admin show
        alter procedure Pro_showAttendance
		as
		begin
		   --[Break=Lunch out-Lunch IN] [production hr=]
		   --select AttendanceId,[Date],UserId,[Status],CheckIn,CheckOut,LunchIn,LunchOut,Late,ProductionHours from Attendance;
		   SELECT AttendanceId,[Date],UserId,[Status],CheckIn,CheckOut,
           ISNULL(
            CAST(
                DATEDIFF(MINUTE, LunchIn, LunchOut) / 60.0 
                AS DECIMAL(5,2)
            ),0.00) AS [Break],
			Late,
            ProductionHours FROM Attendance;
		end

	--5.2)Attendance admin edit
	     alter procedure Pro_Attendanceadmin_edit
		 @AttendanceId INT,
		 @Date datetime2(7),
		 @CheckIn datetime2(7),
		 @CheckOut datetime2(7),
		 @BreakHours decimal(18,2),
		 @ProductionHours decimal(18,2),
		 @Status nvarchar(max)
		 as
		 begin
		   update Attendance
		   set [Date]=@Date,CheckIn=@CheckIn,CheckOut=@CheckOut,BreakHours=@BreakHours,ProductionHours=@ProductionHours,[Status]=@Status
		   WHERE AttendanceId = @AttendanceId
		 end
-------------------------------------------------------------------------------------------------
--6)Admin Timesheet Management
   select*from Timesheets;

  --6.1)Admin timesheet Management approved
        alter procedure Pro_StatusAppr_Timesheets
		 @TimesheetId INT
		as
		begin
		  update Timesheets
		  set [Status]='Approved'
		  where TimesheetId = @TimesheetId;
		end
  --6.2)Admin timesheet Management Rejected
       alter procedure Pro_StatusRejec_Timesheets
	    @TimesheetId INT
		as
		begin
		  update Timesheets
		  set [Status]='Rejected'
		  WHERE TimesheetId = @TimesheetId;;
		end

  --6.3)Admin timesheet show
       select*from [User];
	   select*from Timesheets;
    	select*from AllProjects;

        alter procedure Pro_showTimesheets
		as
		begin
		    select  t.TimesheetId,u.FirstName,u.LastName,t.CreatedAt,ap.ProjectName,t.WorkHours,t.[Status] 
			from [User] u
			join Timesheets t on u.UserId=t.UserId
			join AllProjects ap on ap.ProjectId=t.ProjectId;
		end
-------------------------------------------------------------------------------------------------
--Payroll Master Payroll
--7)Payroll Earning
    select*from EarningType;

    --7.1) Show Earning type
	       create procedure Pro_EarningType
		   as
		   begin
		      select*from EarningType;
		   end

    --7.2) Add Earning type
           create procedure Pro_InsertEarningType
		   @EarningName nvarchar(max)
		   as
		   begin
		      insert into EarningType (EarningName) values(@EarningName);
		   end
     
	--7.3) Update Earning type
	       create procedure Pro_UpdateEarningType
		   @EarningName nvarchar(max)
		   as
		   begin
		     update EarningType
			 set EarningName=@EarningName;
		   end

	--7.4) delete Earning type
	       create procedure Pro_DeleteEarningType
		   @EarntypeId int 
		   as
		   begin
		      delete from EarningType 
			  where EarntypeId=@EarntypeId
		   end
 ----------------------------------------------------------------------------------------------------------
--8)Payroll Earning
     select*from Earning;

	 --8.1) Show Earning 
	       create procedure Pro_Earning
		   as
		   begin
		      select*from Earning;
		   end

    --8.2) Add Earning 
           create procedure Pro_InsertEarning
		   @EarntypeId int,
		   @EarningsPercentage decimal(18,2),
		   @DepartmentId int,
		   @DesignationId int
		   as
		   begin
		      insert into Earning (EarntypeId,EarningsPercentage,DepartmentId,DesignationId) values (@EarntypeId,@EarningsPercentage,@DepartmentId,@DesignationId);
		   end
     
	--8.3) Update Earning 
	       create procedure Pro_UpdateEarning
		   @EarntypeId int,
		   @EarningName nvarchar(max),
		   @EarningsPercentage decimal(18,2),
		   @DepartmentId int,
		   @DesignationId int
		   as
		   begin
		     update Earning
			 set EarntypeId=@EarntypeId, EarningsPercentage=@EarningsPercentage, DepartmentId=@DepartmentId,DesignationId=@DesignationId;
		   end

	--8.4) delete Earning 
	       create procedure Pro_DeleteEarning
		   @EarntypeId int 
		   as
		   begin
		      delete from Earning
			  where EarntypeId=@EarntypeId
		   end
------------------------------------------------------------------------------------------------------------------------------

--9)Payroll deductiontype
   select*from DeductionType;
	 --9.1) Show deduction type
			   create procedure Pro_DeductionType
			   as
			   begin
				  select*from DeductionType;
			   end

    --9.2) Add deduction type
           create procedure Pro_InsertDeductionType
		   @DeductionsName nvarchar(100)
		   as
		   begin
		      insert into DeductionType values(@DeductionsName);
		   end
     
	--9.3) Update deduction type
	       create procedure Pro_UpdateDeductionType
		    @DeductionsName nvarchar(100)
		   as
		   begin
		     update DeductionType
			 set DeductionsName=@DeductionsName;
		   end

	--9.4) delete deduction type
	       create procedure Pro_DeleteDeductionType
		   @DeductionTypeId int 
		   as
		   begin
		      delete from DeductionType 
			  where DeductionTypeId=@DeductionTypeId;
		   end

-------------------------------------------------------------------------------------------------------------------
--10)Payroll deduction
select*from Deduction;


	 --10.1) Show Deduction
	       create procedure Pro_Deduction
		   as
		   begin
		      select*from Deduction;
		   end

    --8.2) Add Deduction
           create procedure Pro_InsertDeduction
		   @DeductionTypeId int,
		   @DeductionPercentage decimal(5,2),
		   @DepartmentId int,
		   @DesignationId int
		   as
		   begin
		      insert into Deduction(DeductionTypeId,DeductionPercentage,DepartmentId,DesignationId) values (@DeductionTypeId,@DeductionPercentage,@DepartmentId,@DesignationId);
		   end
     
	--8.3) Update Deduction
	       create procedure Pro_UpdateDeduction
		  @DeductionTypeId int,
		   @DeductionPercentage decimal(5,2),
		   @DepartmentId int,
		   @DesignationId int
		   as
		   begin
		     update Deduction
			 set DeductionTypeId=@DeductionTypeId, DeductionPercentage=@DeductionPercentage, DepartmentId=@DepartmentId,DesignationId=@DesignationId;
		   end

	--8.4) delete Earning 
	       create procedure Pro_DeleteDeduction
		   @DeductionId int
		   as
		   begin
		      delete from Deduction
			  where DeductionId=@DeductionId;
		   end
-------------------------------------------------------------------------------------------------------------------
--Payroll/addEmployeeSalary (not done yet)
select*from EmployeeDeductions;
select*from EmployeeEarnings;

------------------------------------------------------------------------------------------------------------------
--Payroll/EmployeeSalaryList
create procedure Pro_EmployeeSalaryList
as
begin
  select u.[UserId],u.FirstName,u.LastName,u.Email,u.PhoneNumber,u.DateOfJoining,e.EarningAmount
  from [User] u
  inner join 
  EmployeeEarnings e
  on u.UserId=e.UserId;
end
------------------------------------------------------------------------------------------------------------------
--9)Transaction history (not done yet)
select*from [User];
select*from Role;
--==============================================================================================================================
--------------------------------------------------------Employee-------------------------------------------------------------
--1)Employee leave request
  select*from LeaveRequests;
  ALTER TABLE LeaveRequests
ADD DEFAULT 'Pending' FOR StatusHistory;

  --1.1)add(Apply leaves)
	ALTER PROCEDURE Pro_EmpApply_leaves
		@UserId INT,
		@LeaveTypeId INT,
		@StartDate DATETIME2(7),
		@EndDate DATETIME2(7),
		@Reason NVARCHAR(MAX) AS
	    BEGIN
		INSERT INTO LeaveRequests (UserId, LeaveTypeId, StartDate, EndDate, Reason)
		VALUES (@UserId, @LeaveTypeId, @StartDate, @EndDate, @Reason) 
	 END 

  --1.2)show(Apply leaves)
      select*from MasterLeaveTypes;
	  select*from LeaveRequests;
      alter procedure Pro_EmpShow_leaves
	   as
	   begin
	     select LR.LeaveRequestId as Leave_ID,ML.LeaveType,LR.StartDate,LR.EndDate,LR.Reason,LR.NumberOfDays,LR.[Status]
		 from LeaveRequests LR
		 join  MasterLeaveTypes ML
		 on LR.LeaveTypeId=ML.LeaveTypeId;
	   end

--2)show Employee attendance
        create procedure Pro_Empshow_Attendance
		as
		begin
		   --[Break=Lunch out-Lunch IN] [production hr=]
		   select [Date],[Status],CheckIn,CheckOut,LunchIn,LunchOut,Late,OvertimeHours,ProductionHours from Attendance;
		end

--3)Employee Timesheet Management
select*from Timesheets;

  --3.1) Timesheet Employee added
  create procedure Pro_EmpTimesheet_insert
   @ProjectId int,
   @Date datetime2(7),
   @WorkHours int
  as
  begin
    insert into Timesheets (ProjectId,[Date],WorkHours) values(@ProjectId,@Date,@WorkHours);
  end

  --3.2)Timesheet Employee show
  create procedure Pro_EmpTime_show
  as
  begin
   select [UserId],ProjectId,[Date],WorkHours from Timesheets;
  end

--=======================================================================================================================================================================================

/*
--4)Employee leaves/leaves details
select*from LeaveBalances;
select*from Payslips;*/


--=========================================================================================================================================
---------------------------------------------------------Manager-------------------------------------------------------------------------
--1)Manager leave request
select*from LeaveRequests;
	--1.1)Show LeaveRequest
	      create procedure Pro_ShowManager_leaveRequest
		  as
		  begin
		    select LeaveRequestId,LeaveTypeId,[UserId],ApprovedBy,StartDate,EndDate,Reason,NumberOfDays,[Status] from LeaveRequests;
		  end


	--1.2)approved request #status (Action)
    	create procedure Pro_ApproManager_leavestatus
		  as
		  begin
		    update LeaveRequests
			set Status='Approve';
		  end

	--1.3)Reject request #status
	   create procedure Pro_RejecManager_leavestatus
		  as
		  begin
		    update LeaveRequests
			set Status='Rejected';
		  end


--2)Manager Timesheet Management
select*from Timesheets;

    --2.1)Show Timesheet show
        create procedure Pro_showManager_Timesheets
		as
		begin
		    select  UserId,CreatedAt,ProjectId,WorkHours,[Status] from Timesheets;
		end

	--2.2)Reject Timesheet @status
	    create procedure Pro_RejecManager_TimesheetStatus
		 @UserId int
		  as
		  begin
		    update LeaveRequests
			set Status='Rejected'
			where [UserId]=@UserId;
		  end

	
	--2.3)accpet Timesheet @status
	    create procedure Pro_AcceptManager_TimesheetStatus
		 @UserId int
		  as
		  begin
		    update LeaveRequests
			set Status='Approved'
			where [UserId]=@UserId;
		  end

--3)Manager leave allocation
select*from MasterLeaveTypes;







select*from LeaveBalances;

----------------------------------------SB Module------------------------------------------------------------------
--INSERT Stored Procedure--
--sp_Resignation_Create--
CREATE PROCEDURE sp_Resignation_Create
(
    @UserID INT,
    @DepartmentId INT,
    @NoticeDate DATETIME2(7),
    @ResignDate DATETIME2(7),
    @Reason NVARCHAR(500)
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Resignation
    (
        UserID,
        DepartmentId,
        NoticeDate,
        ResignDate,
        Reason
    )
    VALUES
    (
        @UserID,
        @DepartmentId,
        @NoticeDate,
        @ResignDate,
        @Reason
    );
END
GO

---SELECT (LIST) Stored Procedure---
-- Used for GridView --
--sp_Resignation_GetList--
CREATE PROCEDURE sp_Resignation_GetList
(
    @Search NVARCHAR(100) = NULL,
    @SortOrder NVARCHAR(10) = NULL,   -- ASC / DESC
    @FromDate DATETIME2(7) = NULL,
    @ToDate DATETIME2(7) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        R.ResignationID,
        R.UserID,
        R.DepartmentId,
        R.NoticeDate,
        R.ResignDate,
        R.Reason
    FROM Resignation R
    WHERE
        (@Search IS NULL OR R.Reason LIKE '%' + @Search + '%')
        AND (@FromDate IS NULL OR R.ResignDate >= @FromDate)
        AND (@ToDate IS NULL OR R.ResignDate <= @ToDate)
    ORDER BY
        CASE WHEN @SortOrder = 'ASC' THEN R.ResignDate END ASC,
        CASE WHEN @SortOrder = 'DESC' THEN R.ResignDate END DESC;
END
GO
----SELECT BY ID (Edit Page)---
--sp_Resignation_GetById--

CREATE PROCEDURE sp_Resignation_GetById
(
    @ResignationID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Resignation
    WHERE ResignationID = @ResignationID;
END
GO
---UPDATE Stored Procedure---
--sp_Resignation_Update--
CREATE PROCEDURE sp_Resignation_Update
(
    @ResignationID INT,
    @DepartmentId INT,
    @NoticeDate DATETIME2(7),
    @ResignDate DATETIME2(7),
    @Reason NVARCHAR(500)
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Resignation
    SET
        DepartmentId = @DepartmentId,
        NoticeDate = @NoticeDate,
        ResignDate = @ResignDate,
        Reason = @Reason
    WHERE ResignationID = @ResignationID;
END
GO

---DELETE Stored Procedure---
--sp_Resignation_Remove--
CREATE PROCEDURE sp_Resignation_Remove
(
    @ResignationID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Resignation
    WHERE ResignationID = @ResignationID;
END
GO

---Trigger 1: Validate ResignDate > NoticeDate---
CREATE TRIGGER trg_Resignation_DateValidation
ON Resignation
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted
        WHERE ResignDate <= NoticeDate
    )
    BEGIN
        RAISERROR ('Resignation Date must be greater than Notice Date.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

---trigger 2: Audit Log (Optional but Professional)---

CREATE TABLE Resignation_Audit
(
    AuditID INT IDENTITY PRIMARY KEY,
    ResignationID INT,
    ActionType NVARCHAR(20),
    ActionDate DATETIME DEFAULT GETDATE()
)

---Trigger---

CREATE TRIGGER trg_Resignation_Audit
ON Resignation
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO Resignation_Audit (ResignationID, ActionType)
        SELECT ResignationID, 'INSERT / UPDATE'
        FROM inserted
    END

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO Resignation_Audit (ResignationID, ActionType)
        SELECT ResignationID, 'DELETE'
        FROM deleted
    END
END
GO

-----------
ALTER PROCEDURE sp_Resignation_Create
(
    @UserID INT,
    @DepartmentId INT,
    @NoticeDate DATETIME2(7),
    @ResignDate DATETIME2(7),
    @Reason NVARCHAR(500)
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Resignation
    (
        UserID,
        DepartmentId,
        NoticeDate,
        ResignDate,
        Reason
    )
    VALUES
    (
        @UserID,
        @DepartmentId,
        @NoticeDate,
        @ResignDate,
        @Reason
    );
END
GO



select * from Resignation;


----------Promotion------------


--PromotionID(PK,int,not null)
--UsersID(FK,int,not null)
--DesignationFrom(nvarchar(100),not null)
--DesignationTo(nvarchar(100),not null)
--Date(datetime2(7),not null)--

---Save (Insert / Update)----

DROP TABLE IF EXISTS Promotion1;
USE Pulse360_FinalDb;
GO
CREATE PROCEDURE sp_Promotion_Insert
(
    @EmployeeName NVARCHAR(150),
    @DesignationFrom NVARCHAR(100),
    @DesignationTo NVARCHAR(100),
    @PromotionDate DATETIME2
)
AS
BEGIN
    INSERT INTO Promotion
    (EmployeeName, DesignationFrom, DesignationTo, PromotionDate)
    VALUES
    (@EmployeeName, @DesignationFrom, @DesignationTo, @PromotionDate);
END
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Promotion';

DROP TABLE IF EXISTS Promotion;
GO

DROP TABLE IF EXISTS Promotion1;

create TABLE Promotion
(
    PromotionID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeName NVARCHAR(150) NOT NULL,
    DesignationFrom NVARCHAR(100) NOT NULL,
    DesignationTo NVARCHAR(100) NOT NULL,
    PromotionDate DATETIME2(7) NOT NULL
);
DROP PROCEDURE sp_Promotion_Insert;
CREATE OR ALTER PROCEDURE sp_Promotion_Insert
(
    @EmployeeName NVARCHAR(150),
    @DesignationFrom NVARCHAR(100),
    @DesignationTo NVARCHAR(100),
    @PromotionDate DATETIME2
)
AS
BEGIN
    INSERT INTO Promotion
    VALUES (@EmployeeName, @DesignationFrom, @DesignationTo, @PromotionDate);
END


drop trigger trg_Promotion_Validate;
CREATE OR ALTER TRIGGER trg_Promotion_Validate
ON Promotion
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE DesignationFrom = DesignationTo
    )
    BEGIN
        RAISERROR('From and To Designation cannot be same',16,1);
        ROLLBACK TRANSACTION;
    END
END;


----Update Promotion---

drop procedure sp_Promotion_Update;
CREATE OR ALTER PROCEDURE sp_Promotion_Update
(
    @PromotionID INT,
    @EmployeeName NVARCHAR(150),
    @DesignationFrom NVARCHAR(100),
    @DesignationTo NVARCHAR(100),
    @PromotionDate DATETIME2
)
AS
BEGIN
    UPDATE Promotion
    SET EmployeeName = @EmployeeName,
        DesignationFrom = @DesignationFrom,
        DesignationTo = @DesignationTo,
        PromotionDate = @PromotionDate
    WHERE PromotionID = @PromotionID;
END
GO

----Delete Promotion---

drop procedure sp_Promotion_Delete;
CREATE OR ALTER PROCEDURE sp_Promotion_Delete
(
    @PromotionID INT
)
AS
BEGIN
    DELETE FROM Promotion WHERE PromotionID = @PromotionID;
END
----Select/List Promotions (with Search, Sort, Date Filter)---

drop procedure sp_Promotion_GetAll;
CREATE OR ALTER PROCEDURE sp_Promotion_GetAll
(
    @SearchEmployee NVARCHAR(150) = NULL,
    @FromDate DATETIME2 = NULL,
    @ToDate DATETIME2 = NULL,
    @SortColumn NVARCHAR(50) = 'PromotionDate',
    @SortOrder NVARCHAR(4) = 'DESC'  -- 'ASC' or 'DESC'
)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = N'SELECT PromotionID, EmployeeName, DesignationFrom, DesignationTo, PromotionDate
                 FROM Promotion
                 WHERE 1=1';

    -- Filter by Employee Name
    IF @SearchEmployee IS NOT NULL AND @SearchEmployee <> ''
        SET @SQL += N' AND EmployeeName LIKE ''%'' + @SearchEmployee + ''%''';

    -- Filter by date range
    IF @FromDate IS NOT NULL
        SET @SQL += N' AND PromotionDate >= @FromDate';
    IF @ToDate IS NOT NULL
        SET @SQL += N' AND PromotionDate <= @ToDate';

    -- Sorting
    SET @SQL += N' ORDER BY ' + QUOTENAME(@SortColumn) + ' ' + @SortOrder;

    EXEC sp_executesql @SQL,
        N'@SearchEmployee NVARCHAR(150), @FromDate DATETIME2, @ToDate DATETIME2',
        @SearchEmployee=@SearchEmployee, @FromDate=@FromDate, @ToDate=@ToDate;
END
GO

CREATE OR ALTER PROCEDURE sp_Promotion_GetById
(
    @PromotionID INT
)
AS
BEGIN
    SELECT * FROM Promotion WHERE PromotionID = @PromotionID;
END

--------Termination-----------
--TerminationId(PK,INT,not null)
--useID(FK,int,not nul)
--TerminationType(nvarchar(100),not null)
--NoticeDate(datetime2(7),not null)
--ResignDate(datetime2(7),not null)
--Reason(nvarchar(500),not null)

USE Pulse360_FinalDb;
GO

DROP TABLE IF EXISTS Termination;
GO

CREATE TABLE Termination
(
    TerminationId INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,   -- FK ? Users table
    TerminationType NVARCHAR(100) NOT NULL,
    NoticeDate DATETIME2(7) NOT NULL,
    ResignDate DATETIME2(7) NOT NULL,
    Reason NVARCHAR(500) NOT NULL
);
GO

---TRIGGER (VALIDATION)

CREATE OR ALTER TRIGGER trg_Termination_Validate
ON Termination
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE NoticeDate > ResignDate
    )
    BEGIN
        RAISERROR('Notice Date cannot be greater than Resign Date',16,1);
        ROLLBACK TRANSACTION;
    END
END;

---INSERT------
CREATE OR ALTER PROCEDURE sp_Termination_Insert
(
    @UserID INT,
    @TerminationType NVARCHAR(100),
    @NoticeDate DATETIME2,
    @ResignDate DATETIME2,
    @Reason NVARCHAR(500)
)
AS
BEGIN
    INSERT INTO Termination
    (UserID, TerminationType, NoticeDate, ResignDate, Reason)
    VALUES
    (@UserID, @TerminationType, @NoticeDate, @ResignDate, @Reason);
END;
GO
GO

---Update---
CREATE OR ALTER PROCEDURE sp_Termination_Update
(
    @TerminationId INT,
    @UserID INT,
    @TerminationType NVARCHAR(100),
    @NoticeDate DATETIME2,
    @ResignDate DATETIME2,
    @Reason NVARCHAR(500)
)
AS
BEGIN
    UPDATE Termination
    SET
        UserID = @UserID,
        TerminationType = @TerminationType,
        NoticeDate = @NoticeDate,
        ResignDate = @ResignDate,
        Reason = @Reason
    WHERE TerminationId = @TerminationId;
END;
GO

----DELETE----
CREATE OR ALTER PROCEDURE sp_Termination_Delete
(
    @TerminationId INT
)
AS
BEGIN
    DELETE FROM Termination
    WHERE TerminationId = @TerminationId;
END;
GO

----GET BY ID (Edit)----
CREATE OR ALTER PROCEDURE sp_Termination_GetById
(
    @TerminationId INT
)
AS
BEGIN
    SELECT * FROM Termination
    WHERE TerminationId = @TerminationId;
END;
GO

----LIST / SEARCH / SORT (LIKE PROMOTION)---
CREATE OR ALTER PROCEDURE sp_Termination_GetAll
(
    @SearchType NVARCHAR(100) = NULL,
    @FromDate DATETIME2 = NULL,
    @ToDate DATETIME2 = NULL,
    @SortColumn NVARCHAR(50) = 'ResignDate',
    @SortOrder NVARCHAR(4) = 'DESC'
)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = N'
        SELECT TerminationId, UserID, TerminationType, NoticeDate, ResignDate, Reason
        FROM Termination
        WHERE 1=1';

    IF @SearchType IS NOT NULL AND @SearchType <> ''
        SET @SQL += N' AND TerminationType LIKE ''%'' + @SearchType + ''%''';

    IF @FromDate IS NOT NULL
        SET @SQL += N' AND ResignDate >= @FromDate';

    IF @ToDate IS NOT NULL
        SET @SQL += N' AND ResignDate <= @ToDate';

    SET @SQL += N' ORDER BY ' + QUOTENAME(@SortColumn) + ' ' + @SortOrder;

    EXEC sp_executesql @SQL,
        N'@SearchType NVARCHAR(100), @FromDate DATETIME2, @ToDate DATETIME2',
        @SearchType=@SearchType, @FromDate=@FromDate, @ToDate=@ToDate;
END;
GO
