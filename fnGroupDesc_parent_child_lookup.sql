USE Demo
go
IF OBJECT_ID(N'dbo.fnGroupDesc_parent_child_lookup') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnGroupDesc_parent_child_lookup
    IF OBJECT_ID(N'dbo.fnGroupDesc_parent_child_lookup') IS NOT NULL
        PRINT N'<<< FAILED DROPPING FUNCTION dbo.fnGroupDesc_parent_child_lookup >>>'
    ELSE
        PRINT N'<<< DROPPED FUNCTION dbo.fnGroupDesc_parent_child_lookup >>>'
END
go
SET ANSI_NULLS ON
go
CREATE FUNCTION dbo.fnGroupDesc_parent_child_lookup
  (@atDepth as int,
   @target_ID as int) 
  RETURNS varchar(120) 
AS BEGIN 
  /*
  ** FUNCTION:  dbo.fnGroupDesc_parent_child_lookup
  **
  **
  ** Author:  
  **
  ** Description:
  ** ---------------------------------------------------------------------------------------------------------------------------------
  **   Returns a text value of the parent [@atDepth] levels deep from root = 0
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
  ** 27NOV18    1.0      
  */
  Declare @MAX_DEPTH int;   SET @MAX_DEPTH = 32
  Declare @res varchar(120) = ''
  
  Declare @this_ID_depth as int = dbo.fnChildDepth_parent_child_lookup(@target_ID)
 
  
  if (0 <= @atDepth) and (@atDepth <= @this_ID_depth) Begin
    -- we can only have values for parents UP the tree from the current node reference
    Declare @this_node int = @target_ID -- start with self

    WHILE (@this_ID_depth > @atDepth) BEGIN
      SET @this_ID_depth = @this_ID_depth - 1
      SELECT
        @this_node = parent_id
      FROM
        dbo.parent_child_lookup p
      WHERE
        p.ID = @this_node   
    END
    
    /*
    ** assign the result to a string to return
    */
    SELECT 
      @res = r.item_desc
    FROM
      dbo.parent_child_lookup r 
    WHERE
      r.ID = @this_node 
      
    End --  if (@this_ID_depth <= @atDepth)
    
  Else Begin
    SET @res = '~'
  End
    
  RETURN @res
END
go
SET ANSI_NULLS OFF
go
IF OBJECT_ID(N'dbo.fnGroupDesc_parent_child_lookup') IS NOT NULL
    PRINT N'<<< CREATED FUNCTION dbo.fnGroupDesc_parent_child_lookup >>>'
ELSE
    PRINT N'<<< FAILED CREATING FUNCTION dbo.fnGroupDesc_parent_child_lookup >>>'
go
