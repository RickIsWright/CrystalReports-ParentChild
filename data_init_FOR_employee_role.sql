
truncate table Demo.dbo.employee_role
go
INSERT INTO Demo.dbo.employee_role
      (EmployeeID,
       RoleID,
       is_primary_role,
       active_flag,
       role_comment)
VALUES
      (1001/*EmployeeID_Value*/,
       1 /*RoleID_Value*/,
       1 /*is_primary_role_Value*/,
       'Y' /*active_flag_Value*/,
       'Employee ID = 1, assigned to role = 1' /*role_comment_Value*/)
go
select * from dbo.employee_role
