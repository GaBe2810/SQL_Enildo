create database Manoel_Pedro;

Use Manoel_Pedro;

create table tbproduto(
IdProp int Primary Key,
NomeProd varchar(50) not null,
Qtd int not null,
DataValidade date not null,
Preco float not null
);
drop table tbproduto;

create table tbcliente(
Codigo int Primary Key,
NomeCli varchar(50) not null,
DataNascimento date null
);


