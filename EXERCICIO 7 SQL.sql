-- Gabriel e Vitoria
create database dbescola;

use dbescola;

create table tbcliente(
IdCli int primary key,
NomeCli varchar(50) not null,
NumEnd smallint null,
DataCadastro datetime default current_timestamp()
);

alter table tbcliente add CPF decimal (11,0) null unique;
alter table tbcliente add Cep decimal(5,0) null;

create database dbempresa;

-- ainda dentro da database dbescola
create table tbendereco(
Cep decimal(5,0) primary key,
Logradouro varchar(250) not null,
IdUf tinyint null
);

alter table tbcliente add CONSTRAINT Fk_Cep_tbcliente FOREIGN KEY (Cep) references tbendereco (Cep);

describe tbcliente;
/*Dificuldades
1 - Entender o funcionamento do decimal
2 - entender tabelas intermediarias
3 - Entender o "Não pode ser nulo"
*/

drop database dbempresa;
show databases;