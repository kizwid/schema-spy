create table EVENT (
    event_id bigint not null
    ,env varchar(10) not null
    ,region varchar(50) not null
    ,domain varchar(50) not null
    ,event_type varchar(50) not null
    ,key_type varchar(50) not null
    ,key varchar(50) not null
    ,timestamp timestamp not null
    ,primary key (event_id)
);
create sequence EVENT_SEQ;

create table WORKFLOW (
    workflow_id bigint not null
    ,event_id bigint not null
    ,name varchar(255)
    ,start_time date
    ,creation_user bigint
    ,primary key (workflow_id)
);
create sequence WORKFLOW_SEQ;
alter table WORKFLOW add constraint fk_event_id foreign key (event_id) references EVENT;

create table TASK_TYPE (
    task_type_id int not null
    ,name varchar(255)
    ,primary key (task_type_id)
);
create sequence TASK_TYPE_SEQ;

create table TASK (
    task_id int not null
    ,task_type_id int not null
    ,name varchar(255)
    ,parent int
    ,ordinal int
    ,primary key (task_id)
);
create sequence TASK_SEQ;
alter table TASK add constraint fk_task_id foreign key (task_type_id) references TASK_TYPE;

create table WORKFLOW_TASK (
    workflow_task_id int not null
    ,workflow_id int not null
    ,task_id int not null
    ,parent int
    ,ordinal int
    ,primary key (workflow_task_id)
);
create sequence WORKFLOW_TASK_SEQ;
alter table WORKFLOW_TASK add constraint fk_wt_task_id foreign key (task_id) references TASK;
alter table WORKFLOW_TASK add constraint fk_wt_workflow_id foreign key (workflow_id) references WORKFLOW;
