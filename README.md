# Crystal Reports - Parent Child Relationship

How to display a parent-child relationship hierarchy in Crystal Reports using a SQL Server data source.

## Description

One of the challenges of reporting on parent-child relationships is each of the "groups" are indirectly defined in the same table, rather than simply via links to other tables.

One possible method of using Crystal Reports to display a hierarchy is to group by parents at a given "depth" from the root node. All of the first level group records are those that have the root as a parent. All the second level records are those that have the first level nodes as a parent... and so on.

But how can the depth be determined from simply a list of records each with a parent and child field? The method here is to use SQL functions. Given any record, count how many parents need to be traversed upward before the root (parent = 0) node is found.

Once the depth of a given node can be determined, the text value for that node can then be defined as the "Group By" display value for every level desired.

Note that a separate field will need to be explicitly defined for each level of a given hierarchy like this:

```    Group0_desc = dbo.fnGroupDesc_parent_child_lookup(0,c.RoleID), -- the root (parent=0) at depth = 0 is the first tlevel of grouping
    Group1_desc = dbo.fnGroupDesc_parent_child_lookup(1,c.RoleID), -- the next level (parent = root) at depth = 1 is the next level
    Group2_desc = dbo.fnGroupDesc_parent_child_lookup(2,c.RoleID), -- and so on...
```
Grouping by each of these fields in Crystal Reports, then indenting each nexct-depth child, we can simulate the tree hierarchy typically used to display parent-child relationships.

## Source code:

The data_init prefixed files are simply for the optional pre-population of some data for a demo.

'Demo.sql' creates a SQL database called Demo.

'dbo.fnChildDepth_parent_child_lookup' creates a SQL function that given a node id - will return the depth (from root; parent =0)

'dbo.fnGroupDesc_parent_child_lookup' created the function that is used as a field in the base report view. This is the field to Group By in Crystal Reports.

'parent_child_lookup' creates a table with.. well a parent-child relationship fields. (ID and parent_ID)

The two rpt files are of course Crystal Reports.

`show_vw_cr_hierarchy` is a simple SQL statement to show the dataset used in the report.

`vw_cr_hierarchy_WITH_orphans` is a sample view to be used in the Crystal Report (including orphans)

`vw_cr_hierarchy` - your basic parent-child hierarchy join.

`vw_employee_role_WITH_no_role` sample employees with no role found in the hierarchy.

## Comments & Feedback
You can open an issue here, send me a message via gmail, or contact [me on twitter](https://twitter.com/gojimmypi)
