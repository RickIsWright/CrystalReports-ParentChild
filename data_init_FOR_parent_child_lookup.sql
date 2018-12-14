-- uncomment to remove all existing data
TRUNCATE TABLE dbo.parent_child_lookup

-- normally, we'd let the identity field assign PK values, but here we are inserting exlicit test data
SET IDENTITY_INSERT dbo.parent_child_lookup ON

INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES -- this is a special value, when no data is found, but we don't want null values
      (-1 /*ID_Value*/,
       0 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'No assignment' /*item_desc_Value*/,
       'No Assignment' /* item_comment_Value */)
       
-- root
INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (1 /*ID_Value*/,
       0 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'Root' /*item_desc_Value*/,
       'This is the root item' /* item_comment_Value */)
       
-- children of root
INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (2 /*ID_Value*/,
       1 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'Child 2' /*item_desc_Value*/,
       'This child has the root as a parent' /* item_comment_Value */)       

INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (3 /*ID_Value*/,
       1 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'Child 3' /*item_desc_Value*/,
       'This is another child that has the root as a parent' /* item_comment_Value */)   
 
-- children of children of root (Parent ID = 2)
INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (4 /*ID_Value*/,
       2 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'Grand Child 2.4' /*item_desc_Value*/,
       'This child is two levels below the root' /* item_comment_Value */)   

INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (5 /*ID_Value*/,
       2 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'Grand Child 2.5' /*item_desc_Value*/,
       'This child is two levels below the root (#2)' /* item_comment_Value */)          

INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (6 /*ID_Value*/,
       2 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'Grand Child 2.6' /*item_desc_Value*/,
       'This child is two levels below the root (#3)' /* item_comment_Value */)          

-- children of children of root (Parent ID = 3)
INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (7 /*ID_Value*/,
       3 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'Grand Child 2.4' /*item_desc_Value*/,
       'This child is two levels below the root, under parent = 3' /* item_comment_Value */)   

-- with no foreign key restraints, we might have orphans
INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (8 /*ID_Value*/,
       -2 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'Orphan' /*item_desc_Value*/,
       'This child has a parent that does not exist. (la pauvre)' /* item_comment_Value */)   

-- even with foreign key restraints, we might have orphans for inactive parents
INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (9 /*ID_Value*/,
       5 /*parent_id_Value*/,
       'N' /*active_flag_Value*/,
       'Inactive item' /*item_desc_Value*/,
       'This item has a parent, but the child is inactive' /* item_comment_Value */)   


INSERT INTO dbo.parent_child_lookup
      (ID,
       parent_id,
       active_flag,
       item_desc,
       item_comment)
VALUES
      (10 /*ID_Value*/,
       9 /*parent_id_Value*/,
       'Y' /*active_flag_Value*/,
       'Active child, pointing to inactive parent' /*item_desc_Value*/,
       'This item has a parent, but the parent is inactive' /* item_comment_Value */)   

SET IDENTITY_INSERT dbo.parent_child_lookup OFF
 