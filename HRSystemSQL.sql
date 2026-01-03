select *  from [User];
-- user procs
-- user triggers
select * from Trainer;
select * from Training;
select * from TrainingType;
select * from AdminDocuments;
select * from addAdminDocNames;
select * from addEmployeeDocNames;

----------Resignation Table--------
---ResignationID(PK,int,not null)
----UserID(FK,int,not null)
--DepartmentId(FK,not null)
---NoticeDate(datetime2(7),not null)

--ResignDate(datetime2(7),not null)
---Reason(nvarchar(500),not null)

---INSERT Resignation-----

use Pulse360_FinalDb;

CREATE PROCEDURE sp_InsertResignation
(
    @UserID INT,
    @DepartmentId INT,
    @NoticeDate DATETIME2(7),
    @ResignDate DATETIME2(7),
    @Reason NVARCHAR(500)
)
AS
BEGIN
    INSERT INTO [dbo].[Resignation]
    VALUES (@UserID, @DepartmentId, @NoticeDate, @ResignDate, @Reason)
END
----GET ALL Resignations-----
CREATE PROCEDURE sp_GetResignation
AS
BEGIN
    SELECT * FROM [dbo].[Resignation]
    ORDER BY ResignationID DESC
END

-----DELETE Resignation-----
CREATE PROCEDURE sp_DeleteResignation
(
    @ResignationID INT
)
AS
BEGIN
    DELETE FROM  WHERE ResignationID = @ResignationID
END

----Update Resignation-----
CREATE PROCEDURE sp_UpdateResignation
(
    @ResignationID INT,
    @UserID INT,
    @DepartmentId INT,
    @NoticeDate DATETIME2(7),
    @ResignDate DATETIME2(7),
    @Reason NVARCHAR(500)
)
AS
BEGIN
    UPDATE Resignation
    SET
        UserID = @UserID,
        DepartmentId = @DepartmentId,
        NoticeDate = @NoticeDate,
        ResignDate = @ResignDate,
        Reason = @Reason
    WHERE ResignationID = @ResignationID;
END

-----TRIGGER (VALIDATION)------
CREATE TRIGGER trg_CheckResignDate1
ON [dbo].[Resignation]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE ResignDate < NoticeDate
    )
    BEGIN
        RAISERROR('Resign Date cannot be earlier than Notice Date',16,1);
        ROLLBACK TRANSACTION;
    END
END




select * from [dbo].[Resignation];

------
USE Pulse360_FinalDb;
GO
CREATE OR ALTER PROCEDURE dbo.sp_GetResignations1
AS
BEGIN
    SELECT ResignationID, UserID, DepartmentId, NoticeDate, ResignDate, Reason
    FROM Resignation;
END;
GO



USE Pulse360_FinalDb;
GO

CREATE OR ALTER PROCEDURE dbo.sp_InsertResignation1
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
END;
GO
