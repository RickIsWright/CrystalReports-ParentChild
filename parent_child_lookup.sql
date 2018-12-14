USE Demo
go
CREATE TABLE dbo.parent_child_lookup
(
    ID                 int          IDENTITY,
    parent_id          int          NOT NULL,
    active_flag        char(1)      COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT DF__parent_ch__activ__108B795B DEFAULT 'Y' NOT NULL,
    item_desc          varchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT DF__parent_ch__item___117F9D94 DEFAULT '' NOT NULL,
    item_comment       varchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT DF__parent_ch__item___1FCDBCEB DEFAULT '' NOT NULL,
    create_dt          datetime     CONSTRAINT DF__parent_ch__creat__1273C1CD DEFAULT getdate() NOT NULL,
    create_suser_sname varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT DF__parent_ch__creat__1367E606 DEFAULT suser_sname() NOT NULL,
    create_app_user_id varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT DF__parent_ch__creat__145C0A3F DEFAULT suser_sname() NOT NULL,
    modify_dt          datetime     CONSTRAINT DF__parent_ch__modif__15502E78 DEFAULT getdate() NOT NULL,
    modify_suser_sname varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT DF__parent_ch__modif__164452B1 DEFAULT suser_sname() NOT NULL,
    modify_app_user_id varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT DF__parent_ch__modif__173876EA DEFAULT suser_sname() NOT NULL,
    CONSTRAINT PK_parent_child_lookup
    PRIMARY KEY CLUSTERED (ID)
)
go
IF OBJECT_ID(N'dbo.parent_child_lookup') IS NOT NULL
    PRINT N'<<< CREATED TABLE dbo.parent_child_lookup >>>'
ELSE
    PRINT N'<<< FAILED CREATING TABLE dbo.parent_child_lookup >>>'
go
