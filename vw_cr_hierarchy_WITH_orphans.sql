USE Demo
go
IF OBJECT_ID(N'dbo.vw_cr_hierarchy_WITH_orphans') IS NOT NULL
BEGIN
    DROP VIEW dbo.vw_cr_hierarchy_WITH_orphans
    IF OBJECT_ID(N'dbo.vw_cr_hierarchy_WITH_orphans') IS NOT NULL
        PRINT N'<<< FAILED DROPPING VIEW dbo.vw_cr_hierarchy_WITH_orphans >>>'
    ELSE
        PRINT N'<<< DROPPED VIEW dbo.vw_cr_hierarchy_WITH_orphans >>>'
END
go
CREATE VIEW dbo.vw_cr_hierarchy_WITH_orphans AS
  /*
  ** View: vw_cr_hierarchy
  **
  ** Author: 
  **
  ** Description:
  ** ---------------------------------------------------------------------------------------------------------------------------------
  **
  **  Demo for using parent-child relationship lookup table view in hierarchy tree format in Crystal Reports
  **
  **  Note that LEVT OUTER JOIN to dbo.parent_child_lookup could be replaced with a view, such as in the case of employee 
  **  assignments to roles in the parent_child_lookup table; the view would contain all staff with special no-role assignment records
  **    (see dbo.vw_employee_rolee_WITH_no_role)
  **
  ** ---------------------------------------------------------------------------------------------------------------------------------
  ** Mods:
  **
  ** Date      Version  By             Description
  ** ---------------------------------------------------------------------------------------------------------------------------------
  ** 26NOV18    1.0      
  */
  SELECT DISTINCT
    c.RoleID, -- we'll look at each chid element
    c.create_dt,
    c.create_suser_sname,
    c.item_desc,
    c.item_comment,
    child_depth = dbo.fnChildDepth_parent_child_lookup(c.RoleID), -- here one of the child attributes, is the child depth in th tree
    Group0_desc = dbo.fnGroupDesc_parent_child_lookup(0,c.RoleID), -- the root (parent=0) at depth = 0 is the first tlevel of grouping
    Group1_desc = dbo.fnGroupDesc_parent_child_lookup(1,c.RoleID), -- the next level (parent = root) at depth = 1 is the next level
    Group2_desc = dbo.fnGroupDesc_parent_child_lookup(2,c.RoleID), -- and so on...
    Group3_desc = dbo.fnGroupDesc_parent_child_lookup(3,c.RoleID),
    Group4_desc = dbo.fnGroupDesc_parent_child_lookup(4,c.RoleID),
    Group5_desc = dbo.fnGroupDesc_parent_child_lookup(5,c.RoleID),
    Group6_desc = dbo.fnGroupDesc_parent_child_lookup(6,c.RoleID),
    Group7_desc = dbo.fnGroupDesc_parent_child_lookup(7,c.RoleID),
    Group8_desc = dbo.fnGroupDesc_parent_child_lookup(8,c.RoleID),
    Group9_desc = dbo.fnGroupDesc_parent_child_lookup(9,c.RoleID)
  FROM  
    dbo.parent_child_lookup c FULL OUTER JOIN dbo.vw_employee_role_WITH_no_role p on (c.parent_RoleID = p.RoleID)
go
IF OBJECT_ID(N'dbo.vw_cr_hierarchy_WITH_orphans') IS NOT NULL
    PRINT N'<<< CREATED VIEW dbo.vw_cr_hierarchy_WITH_orphans >>>'
ELSE
    PRINT N'<<< FAILED CREATING VIEW dbo.vw_cr_hierarchy_WITH_orphans >>>'
go
