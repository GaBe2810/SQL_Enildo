create database PontoVirgula_db;
create database ExeJd_db;
drop database PontoVirgula_db;
use ExeJd_db;

show databases;

create table aluno_tb(
Id integer not null, 
NomeAlu varchar(50) null, 
Nota decimal(6,2) 
);

show tables;

describe aluno_tb;



create table tbAluno2_tb(
Id int primary key,
Sexo char (1) not null default 'F',
DataNasc date not null,
Salario float null,
check (Salario < 1000),
cpf bigint not null unique
);
describe tbAluno2_tb;
alter table tbAluno2_tb drop DataNasc;

describe tbAluno2_tb; 

alter table tbAluno2_tb add DataNasc date null;

alter table tbAluno2_tb modify DataNasc date not null;

truncate table tbAluno_tb;