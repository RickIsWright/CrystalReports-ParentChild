Use Demo
go
TRUNCATE TABLE Demo.dbo.employee_lookup 
go

SET IDENTITY_INSERT dbo.employee_lookup ON
INSERT INTO Demo.dbo.employee_lookup
      (EmployeeID,
       active_flag,
       first_name,
       last_name)
VALUES
      (1001 /*EmployeeID_Value*/,
       'Y' /*active_flag_Value*/,
       'Billy' /*first_name_Value*/,
       'Testuser' /*last_name_Value*/)

INSERT INTO Demo.dbo.employee_lookup
      (EmployeeID,
       active_flag,
       first_name,
       last_name)
VALUES
      (1002 /*EmployeeID_Value*/,
       'Y' /*active_flag_Value*/,
       'Bobby' /*first_name_Value*/,
       'Testuser' /*last_name_Value*/)

INSERT INTO Demo.dbo.employee_lookup
      (EmployeeID,
       active_flag,
       first_name,
       last_name)
VALUES
      (1003 /*EmployeeID_Value*/,
       'Y' /*active_flag_Value*/,
       'Susie' /*first_name_Value*/,
       'Testuser' /*last_name_Value*/)

INSERT INTO Demo.dbo.employee_lookup
      (EmployeeID,
       active_flag,
       first_name,
       last_name)
VALUES
      (1004 /*EmployeeID_Value*/,
       'Y' /*active_flag_Value*/,
       'Debbie' /*first_name_Value*/,
       'Testuser' /*last_name_Value*/)


SET IDENTITY_INSERT dbo.employee_lookup OFF
