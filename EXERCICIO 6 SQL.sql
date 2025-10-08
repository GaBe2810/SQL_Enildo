create database dbdesenvolvimento;


use dbdesenvolvimento;
create table tbproduto(
IdProp int primary key,
NomeProd varchar(50) not null,
Qtd int null,
DataValidade date not null,
Preco float not null
);


alter table tbproduto add Peso decimal (6,2) null;
alter table tbproduto add Cor varchar(50) null;
alter table tbproduto add Marca varchar(50) not null;

alter table tbproduto drop Cor;

alter table tbproduto modify Peso decimal (6,2) not null;

-- alter table tbproduto drop Cor;
/* o comando acima não funcionou, não foi possivel apagar.
Isso acontece porque já foi utilizado esse comando antes, ou seja, a coluna já foi apagada.
Só funcionará o comando para apagar a coluna caso ela for adicionado novamente e tentar apaga-la outra vez*/

create database dbLojaGrande;

alter table tbproduto add Cor varchar(50) null;


create database dblojica;
use dblojica;

create table tbcliente(
NomeCli varchar(50) not null,
CodigoCli int primary key,
DataCadastro date not null
);

use dblojagrande;

create table tbfuncionario(
NomeFunc varchar(50) not null,
CodigoFunc int primary key,
DataCadastro date not null
);

drop database dbLojaGrande;

use dblojica;
alter table tbcliente add cpf decimal (11,0) not null unique;

show databases;