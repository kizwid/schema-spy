create table COUNTERPARTY (
    counterparty_id bigint not null
    ,created timestamp not null
    ,deleted timestamp not null
    ,primary key (counterparty_id)
);
create table VERSIONED_COUNTERPARTY (
    counterparty_id bigint not null
    ,revision_number varchar(20)
    ,rxm_code varchar(20)
    ,place_of_organization varchar(20)
    ,region varchar(50) not null
    ,deletion_indicator int not null
    ,effective timestamp not null
    ,primary key (counterparty_id, revision_number)
);
alter table VERSIONED_COUNTERPARTY
add constraint fk_vc_counterparty_id foreign key (counterparty_id)
references COUNTERPARTY;

create table AGREEMENT (
    agreement_id bigint not null
    ,counterparty_id bigint not null
    ,agreement_version varchar(20) not null
    ,revision_number varchar(20) not null
    ,agreement_template varchar(10) not null
    ,agreement_type varchar(50) not null
    ,agreement_status varchar(50) not null
    ,termination_currency varchar(50) not null
    ,collateral_indicator varchar(50) not null
    ,relationship_type varchar(50) not null
    ,ubs_legal_entity varchar(50) not null
    ,region varchar(50) not null
    ,deletion_indicator int not null
    ,agreement_date timestamp not null
    ,requested_date timestamp not null
    ,governing_law_location varchar(50) not null
    ,primary key (agreement_id)
);
create sequence AGREEMENT_SEQ;
alter table AGREEMENT add constraint fk_counterparty_id foreign key (counterparty_id) references COUNTERPARTY;

create table RELATED_AGREEMENT (
    related_agreement_id bigint not null
    ,agreement_id bigint not null
    ,relationship_type varchar(50) not null
    ,region varchar(50) not null
    ,primary key (related_agreement_id)
);
create sequence RELATED_AGREEMENT_SEQ;
alter table RELATED_AGREEMENT add constraint fk_agreement_id foreign key (agreement_id) references AGREEMENT;

create table AGREEMENT_SETTLEMENT_BRANCH (
    agreement_settlement_branch_id bigint not null
    ,agreement_id bigint not null
    ,settlement_branch_code varchar(20)
    ,settlement_branch_name varchar(20)
    ,region varchar(50) not null
    ,primary key (agreement_settlement_branch_id)
);
create sequence AGREEMENT_SETTLEMENT_BRANCH_SEQ;
alter table AGREEMENT_SETTLEMENT_BRANCH add constraint fk_asb_agreement_id foreign key (agreement_id) references AGREEMENT;

create table AGREEMENT_COUNTERPARTY_BRANCH (
    agreement_counterparty_branch_id bigint not null
    ,agreement_id bigint not null
    ,cntparty_rxm_place_code varchar(20)
    ,rxm_country_code varchar(20)
    ,region varchar(50) not null
    ,primary key (agreement_counterparty_branch_id)
);
create sequence AGREEMENT_COUNTERPARTY_BRANCH_SEQ;
alter table AGREEMENT_COUNTERPARTY_BRANCH add constraint fk_acb_agreement_id foreign key (agreement_id) references AGREEMENT;

create table PRODUCT (
    product_code varchar(20) not null
    ,product_name varchar(20)
    ,region varchar(50) not null
    ,primary key (product_code)
);

create table AGREEMENT_PRODUCT (
    agreement_product_id bigint not null
    ,agreement_id bigint not null
    ,product_code varchar(20)
    ,primary key (agreement_product_id)
);
create sequence AGREEMENT_PRODUCT_SEQ;
alter table AGREEMENT_PRODUCT add constraint fk_ap_agreement_id foreign key (agreement_id) references AGREEMENT;
alter table AGREEMENT_PRODUCT add constraint fk_ap_product_code foreign key (product_code) references PRODUCT;

create table AGREEMENT_NETTING (
    netting_id bigint not null
    ,product_code varchar(20) not null
    ,credit_capital_flag varchar(50) not null
    ,credit_only_flag varchar(50) not null
    ,revision_number varchar(50) not null
    ,country varchar(50) not null
    ,region varchar(50) not null
    ,deletion_indicator int not null
    ,primary key (netting_id)
);
create sequence AGREEMENT_NETTING_SEQ;
alter table AGREEMENT_NETTING add constraint fk_an_product_code foreign key (product_code) references PRODUCT;
