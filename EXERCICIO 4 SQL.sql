create database Dirce_Geni;
show databases;

use Dirce_Geni;

create table tbproduto(
IdProp int primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
Preco float not null
);

alter table tbproduto add peso decimal(7,2) null;
alter table tbproduto add cor varchar(50) null;
alter table tbproduto add marca varchar(50) not null;
alter table tbproduto drop cor;
alter table tbproduto modify peso decimal(7,2) not null;
alter table tbproduto drop DataValidade;

show tables;
describe tbproduto;