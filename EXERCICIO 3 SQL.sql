create database dbcomercio;
show databases;

use dbcomercio;

create table tbCliente(
id int primary key,
NomeCli varchar (200) not null,
NumEnd decimal (6) not null,
CompEnd char (50) null
);

create table tbClientePF(
CPF decimal(11) primary key,
RG decimal (9),
RgDig char(1),
Nascimento date not null
);

show tables;
describe tbCliente;
describe tbClientePF;