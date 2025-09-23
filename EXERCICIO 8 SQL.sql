-- Caso seja nescessário
use dbescola;

create table tbest(
IdUf tinyint primary key,
NomeUfs varchar(2) not null,
NomeEstado varchar(40) not null 
);

alter table tbendereco add CONSTRAINT Fk_IdUF_tbendereco FOREIGN KEY (IdUf) references tbest (IdUf);

alter table tbest drop NomeEstado;

rename table tbest to tbestado;

alter table tbestado rename column NomeUfs to NomeUf;

alter table tbendereco add IdCid mediumint null;

create table tbcidade(
IdCid mediumint primary key,
NomeCidade varchar(50) not null
); 

alter table tbcidade modify NomeCidade varchar(250) null;

alter table tbendereco add CONSTRAINT Fk_IdCid_tbendereco FOREIGN KEY (IdCid) references tbcidade (IdCid);