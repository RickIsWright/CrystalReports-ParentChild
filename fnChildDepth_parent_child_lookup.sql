USE Demo
go
IF OBJECT_ID(N'dbo.fnChildDepth_parent_child_lookup') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnChildDepth_parent_child_lookup
    IF OBJECT_ID(N'dbo.fnChildDepth_parent_child_lookup') IS NOT NULL
        PRINT N'<<< FAILED DROPPING FUNCTION dbo.fnChildDepth_parent_child_lookup >>>'
    ELSE
        PRINT N'<<< DROPPED FUNCTION dbo.fnChildDepth_parent_child_lookup >>>'
END
go
SET ANSI_NULLS ON
go
CREATE FUNCTION dbo.fnChildDepth_parent_child_lookup
  (@target_ID as int) 
  RETURNS int 
AS BEGIN 
  /*
  ** FUNCTION:  dbo.fnChildDepth_parent_child_lookup
  **
  ** Author: 
  **
  ** Description:
  ** ---------------------------------------------------------------------------------------------------------------------------------
  **   Returns an integer value indicating the parent-child relationship depth from root (root: parent = 0)
  **
  ** ---------------------------------------------------------------------------------------------------------------------------------
  ** Used By:
  **
  **
  ** ---------------------------------------------------------------------------------------------------------------------------------
  ** Mods:
  **
  ** Date      Version  By             Description
  ** ---------------------------------------------------------------------------------------------------------------------------------
  ** 26NOV18    1.0     
  */
  Declare @MAX_DEPTH int;   SET @MAX_DEPTH = 32
  Declare @res int;         SET @res = 0
  Declare @this_parent int; SET @this_parent = -1
  
  SELECT
    @this_parent = parent_id
  FROM
    dbo.parent_child_lookup p
  WHERE
    p.ID = @target_ID

  WHILE (@this_parent > 0) AND (@res <= @MAX_DEPTH) BEGIN
    SET @res = @res + 1
    SET @target_ID = @this_parent -- the target child to look at is now the prior child's parent
    SELECT
      @this_parent = parent_id
    FROM
      dbo.parent_child_lookup p
    WHERE
      p.ID = @target_ID   
  END
  
  RETURN @res
END
go
SET ANSI_NULLS OFF
go
IF OBJECT_ID(N'dbo.fnChildDepth_parent_child_lookup') IS NOT NULL
    PRINT N'<<< CREATED FUNCTION dbo.fnChildDepth_parent_child_lookup >>>'
ELSE
    PRINT N'<<< FAILED CREATING FUNCTION dbo.fnChildDepth_parent_child_lookup >>>'
go
