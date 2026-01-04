use Pulse360_FinalDb;

select *  from [User];
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
        create procedure Pro_StatusAppr_Timesheets
		as
		begin
		  update Timesheets
		  set [Status]='Approved';
		end
  --6.2)Admin timesheet Management Rejected
       create procedure Pro_StatusRejec_Timesheets
		as
		begin
		  update Timesheets
		  set [Status]='Rejected';
		end

  --6.3)Admin timesheet show
        create procedure Pro_showTimesheets
		as
		begin
		    select  UserId,CreatedAt,ProjectId,WorkHours,[Status] from Timesheets;
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

  --1.1)add(Apply leaves)
        create procedure Pro_EmpApply_leaves
		@LeaveTypeId int,
		@StartDate datetime2(7),
		@EndDate datetime2(7),
		@Reason nvarchar(max)
		as
		begin
		   insert into LeaveRequests (LeaveTypeId,StartDate,EndDate,Reason) values (@LeaveTypeId,@StartDate,@EndDate,@Reason);
		end
  --1.2)show(Apply leaves)
       create procedure Pro_EmpShow_leaves
	   as
	   begin
	     select LeaveRequestId,LeaveTypeId,StartDate,EndDate,Reason,NumberOfDays from LeaveRequests;
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
USE Pulse360_FinalDb;
GO
CREATE PROCEDURE dbo.usp_Promotion_Save
(
    @PromotionId INT,
    @UserID INT,
    @DesignationFrom NVARCHAR(100),
    @DesignationTo NVARCHAR(100),
    @Date DATETIME2
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @PromotionId = 0
    BEGIN
        INSERT INTO dbo.Promotion
        (
            UserID,
            DesignationFrom,
            DesignationTo,
            Date
        )
        VALUES
        (
            @UserID,
            @DesignationFrom,
            @DesignationTo,
            @Date
        );
    END
    ELSE
    BEGIN
        UPDATE dbo.Promotion
        SET
            UserID = @UserID,
            DesignationFrom = @DesignationFrom,
            DesignationTo = @DesignationTo,
            Date = @Date
        WHERE PromotionId = @PromotionId;
    END
END;
GO


-----usp_Promotion_GetAll ---------
CREATE PROCEDURE dbo.usp_Promotion_GetAll
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        p.PromotionId,
        p.UserID,
        u.EmployeeName,
        p.DesignationFrom,
        p.DesignationTo,
        p.Date
    FROM dbo.Promotion p
    INNER JOIN dbo.Users u
        ON u.UserID = p.UserID
    ORDER BY p.Date DESC;
END;
GO


-----Get By ID — usp_Promotion_GetById---
CREATE PROCEDURE dbo.usp_Promotion_GetById
(
    @PromotionId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        PromotionId,
        UserID,
        DesignationFrom,
        DesignationTo,
        Date
    FROM dbo.Promotion
    WHERE PromotionId = @PromotionId;
END;
GO


----Delete — usp_Promotion_Delete-----
CREATE PROCEDURE dbo.usp_Promotion_Delete
(
    @PromotionId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.Promotion
    WHERE PromotionId = @PromotionId;
END;
GO



-----------CREATE TRIGGER dbo.trg_Promotion_UpdateUserDesignation----------
CREATE TRIGGER dbo.trg_Promotion_UpdateUserDesignation
ON dbo.Promotion
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE u
    SET u.Designation = i.DesignationTo
    FROM dbo.Users u
    INNER JOIN inserted i
        ON u.UserID = i.UserID;
END;
GO

SELECT name FROM sys.tables;
select * from User;
SELECT * FROM [User];
