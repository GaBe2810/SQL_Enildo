create database Tais_Luzia;


use Tais_Luzia;
create table tbvenda(
NF int auto_increment primary key,
DataValidade datetime not null
);


alter table tbvenda add preco decimal(6,2) not null;
alter table tbvenda add qtd smallint, add check(qtd > 0);
alter table tbvenda drop DataValidade;
alter table tbvenda add DataVenda datetime default current_timestamp();

create table produto(
CodigoB decimal(13,0) primary key,
NomeProd varchar(50) not null
);


alter table tbvenda add CodigoB decimal(13,0);
alter table tbvenda add CONSTRAINT Fk_CodigoB_tbvenda FOREIGN KEY (CodigoB) references produto (CodigoB);
show databases;
show tables;
describe produto;
describe tbvenda;