create database xcpc_board;
use xcpc_board;
create table id_platform
(
    id       int auto_increment
        primary key,
    uid      varchar(20) null,
    platform varchar(20) null,
    name_id  int         null,
    constraint id_platform_id_uindex
        unique (id)
)
    auto_increment = 4;

create index id_platform_score_id_fk
    on id_platform (name_id);

create table posts
(
    id         int auto_increment comment '主键id'
        primary key,
    user_id    int           not null comment '用户id',
    title      varchar(64)   null comment '帖子标题',
    content    varchar(1500) null comment '帖子内容',
    note       varchar(64)   null comment '备注（备用字段）',
    created_at datetime      null comment '创建时间',
    updated_at datetime      null comment '更新时间'
)
    comment '帖子表';

create table score
(
    id         int auto_increment
        primary key,
    name       varchar(10)   null,
    cf_problem int default 0 not null,
    nowcoder   int default 0 not null,
    cf_rank    int default 0 null,
    now_rank   int default 0 null,
    total      int default 0 not null,
    constraint score_id_uindex
        unique (id)
);

create definer = root@`%` trigger get_total
    before update
    on score
    for each row
begin
    if old.cf_problem != new.cf_problem  || old.nowcoder != new.nowcoder then
        set new.total = new.nowcoder + new.cf_problem ;
    end if;
end;

create table users
(
    id               int auto_increment comment '用户id'
        primary key,
    account          varchar(64)  not null comment '账号',
    keyword          varchar(64)  not null comment '密码',
    email            varchar(64)  not null comment '邮箱',
    is_administrator varchar(1)   not null comment '管理员标签',
    name             varchar(64)  not null comment '姓名',
    image_path       varchar(255) null comment '头像路径',
    signature        varchar(255) null comment '个性签名',
    phone_number     varchar(64)  null comment '手机号',
    qq_number        varchar(64)  null comment 'qq号',
    created_at       datetime     null comment '创建时间',
    updated_at       datetime     null comment '更新时间',
    constraint check_account
        unique (account),
    constraint check_email
        unique (email)
)
    comment '用户表';

create table website_account
(
    id         int         not null comment 'id'
        primary key,
    codeforces varchar(64) null comment 'codeforces',
    nowcoder   varchar(64) null comment 'nowcoder',
    luogu      varchar(64) null comment 'luogu',
    atcoder    varchar(64) null comment 'atcoder',
    vjudge     varchar(64) null comment 'vjudge',
    created_at datetime    null comment '创建时间',
    updated_at datetime    null comment '更新时间'
)
    comment '网站账户名';

create definer = root@`%` trigger xcpc_board.get_total
    before update
                      on xcpc_board.score
                      for each row
begin
    if old.cf_problem != new.cf_problem  || old.nowcoder != new.nowcoder then
        set new.total = new.nowcoder + new.cf_problem ;
end if;
end;

