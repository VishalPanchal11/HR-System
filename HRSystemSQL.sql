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

CREATE PROCEDURE sp_GetAllResignations
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ResignationID,
        UserID,
        DepartmentId,
        NoticeDate,
        ResignDate,
        Reason
    FROM Resignation
    ORDER BY ResignationID DESC;
END
GO

CREATE PROCEDURE sp_GetResignationById
(
    @ResignationID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ResignationID,
        UserID,
        DepartmentId,
        NoticeDate,
        ResignDate,
        Reason
    FROM Resignation
    WHERE ResignationID = @ResignationID;
END
GO

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
    SET NOCOUNT ON;

    UPDATE Resignation
    SET
        UserID = @UserID,
        DepartmentId = @DepartmentId,
        NoticeDate = @NoticeDate,
        ResignDate = @ResignDate,
        Reason = @Reason
    WHERE ResignationID = @ResignationID;
END
GO


CREATE PROCEDURE sp_DeleteResignation
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







