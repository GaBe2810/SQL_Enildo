create database Nicollas_Gabriel;

use Nicollas_Gabriel;

create table tbUsuario(
idUsuario int primary key,
NomeUsuario varchar(45) null,
DataNasc date null
);

create table tbCliente(
CodigoCli int primary key,
Nome varchar(50) null,
Endereco varchar(60) null
);

create table tbEstado(
Id int primary key,
UF char(2) null
);

create table tbProduto(
Barras decimal(13) primary key,
Valor decimal(8,4) null,
Descricao varchar(250) null
);


describe tbProduto;
show tables;
show databases;

alter table tbCliente modify Nome varchar(58) null;
alter table tbProduto add Qtd int null;
drop table tbEstado;
alter table tbUsuario drop DataNasc;