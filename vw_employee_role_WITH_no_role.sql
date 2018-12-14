USE Demo
go
IF OBJECT_ID(N'dbo.vw_employee_role_WITH_no_role') IS NOT NULL
BEGIN
    DROP VIEW dbo.vw_employee_role_WITH_no_role
    IF OBJECT_ID(N'dbo.vw_employee_role_WITH_no_role') IS NOT NULL
        PRINT N'<<< FAILED DROPPING VIEW dbo.vw_employee_role_WITH_no_role >>>'
    ELSE
        PRINT N'<<< DROPPED VIEW dbo.vw_employee_role_WITH_no_role >>>'
END
go
CREATE VIEW dbo.vw_employee_role_WITH_no_role AS
  /*
  ** View: vw_employee_role_WITH_no_role
  **
  ** Params: none
  **
  ** Author:  
  **
  ** Description:
  ** ---------------------------------------------------------------------------------------------------------------------------------
  **
  **  full list of all Role records, appended with all active staff without a role (assigned PhepRoleID = -1)
  **
  ** ---------------------------------------------------------------------------------------------------------------------------------
  ** Mods:
  **
  ** Date      Version  By             Description
  ** ---------------------------------------------------------------------------------------------------------------------------------
  ** 30NOV18    1.0     
  */
  SELECT
    EmployeeID,
    RoleID,
    active_flag,
    role_comment,
    modify_dt
  FROM 
    dbo.employee_role
  WHERE
    active_flag = 'Y'
    
    UNION
    
  SELECT
    e.EmployeeID,
    ID      = cast(-1 as int),
    active_flag   = cast('Y' as char(1)),
    item_comment  = cast('No role assigned' as varchar(80)),
    modify_dt       = getdate()
  FROM
    dbo.employee_lookup e LEFT OUTER JOIN dbo.employee_role r ON (e.EmployeeID = r.EmployeeID 
                                                                  and r.active_flag = 'Y' )
  WHERE
   r.active_flag is Null
   AND e.active_flag = 'Y'
go
IF OBJECT_ID(N'dbo.vw_employee_role_WITH_no_role') IS NOT NULL
    PRINT N'<<< CREATED VIEW dbo.vw_employee_role_WITH_no_role >>>'
ELSE
    PRINT N'<<< FAILED CREATING VIEW dbo.vw_employee_role_WITH_no_role >>>'
go
