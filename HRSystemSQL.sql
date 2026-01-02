select *  from [User];
-- user procs
-- user triggers
select * from Trainer;
select * from Training;
select * from TrainingType;
select * from AdminDocuments;
select * from addAdminDocNames;
select * from addEmployeeDocNames;
---project nodule--
Select * from AllProjects;
---Store procedure for all projets ---
CREATE PROC sp_AllProjects_Insert
(
    @ProjectName   VARCHAR(100),
    @ClientName    VARCHAR(100),
    @Description   VARCHAR(500),
    @StartDate     DATE,
    @EndData       DATE,
    @Priority      VARCHAR(20),
    @ProjectValue  DECIMAL(10,2),
    @PriceType     VARCHAR(20),
    @FilePath      VARCHAR(200),
    @LogoPath      VARCHAR(200),
    @Status        VARCHAR(20),
    @ManagerName   VARCHAR(100)
)
AS
BEGIN
    INSERT INTO dbo.AllProjects
    (
        ProjectName, ClientName, Description,
        StartDate, EndData, Priority,
        ProjectValue, PriceType,
        FilePath, LogoPath,
        Status, ManagerName
    )
    VALUES
    (
        @ProjectName, @ClientName, @Description,
        @StartDate, @EndData, @Priority,
        @ProjectValue, @PriceType,
        @FilePath, @LogoPath,
        @Status, @ManagerName
    )
END
---for gird
CREATE PROC sp_AllProjects_List
AS
BEGIN
    SELECT
        ProjectId,
        ProjectName,
        EndData,
        Priority,
        Status,
        ManagerName
    FROM dbo.AllProjects
    ORDER BY ProjectId DESC
END
select  * from ProjectsUser;
select * from Task;
select * from Taskmember;