

select *  from [User];
-- user procs
-- user triggers
select * from Trainer;
select * from Training;
select * from TrainingType;
select * from AdminDocuments;
select * from addAdminDocNames;
select * from addEmployeeDocNames;

<<<<<<< HEAD
--Dheeraj Module
--Admin 
=======
>>>>>>> 9964774111d34aeccbd4eb8435f06ddf9c2bd22a
<<<<<<< HEAD
select * from Events
select * from EventTypes
=======

<<<<<<< HEAD
create procedure Pro_EventType
@Name nvarchar(50),
@Color nvarchar(20) 
as
begin
insert into EventTypes values(@Name, @Color)
end;

--Show 
create procedure show_EventType
as
begin
select * from EventTypes
end;

--delete
create procedure delete_EventType
@id int
as
begin
delete from EventTypes where id =@id
end;

-- Event insert
create procedure insert_Event
@title nvarchar(max),
@Date nvarchar(max),
@EventTypeId int
as
begin
insert into Events (title, [Date], EventTypeId) values(@title, @Date, @EventTypeId)
end

-- event update
create procedure update_Event
@id int,
@title nvarchar(max),
@Date nvarchar(max),
@EventTypeId int
as
begin
update Events set Title=@title, [Date]= @Date, EventTypeId=@EventTypeId where id=@id
end;

-- event delete 
create procedure delete_Event
@id int
as
begin
delete from Events where id = @id
end



=======
>>>>>>> 9964774111d34aeccbd4eb8435f06ddf9c2bd22a
--Siddhesh Module
--Admin
--1) Adding leave type
select*from MasterLeaveTypes;

--2)Attdendance
select*from Attendance;
select*from Deduction;
select*from Earning;
select*from EarningType;
select*from EmployeeDeductions;
select*from DeductionType;
select*from EmployeeEarnings;
select*from EmployeeSalaries;
select*from LeaveBalances;
select*from LeaveRequests;

select*from Payslips;
select*from Timesheets;
select*from [User];





>>>>>>> 90c677be47ae38f2e575c343a842c4eb354b3ae9
