create database dbBanco;
use dbBanco;

create table tbbanco(
Codigo int primary key,
Nome varchar(50) not null
);

create table tbagencia(
NumeroAgencia int primary key,
CodBanco int null,
Endereco varchar(50) not null,
foreign key (CodBanco) references tbbanco(Codigo)
);

create table tbconta(
NumeroConta int primary key,
NumAgencia int not null,
Saldo decimal(7,2) null,
TipoConta smallint null,
foreign key (NumAgencia) references tbagencia(NumeroAgencia)
);

create table tbcliente(
Cpf bigint primary key,
nome varchar(50) not null,
Sexo char(1) not null,
Endereco varchar(50) not null
);

create table tbhistorico(
Cpf bigint primary key,
NumeroConta int not null,
DataInicio date null,
foreign key (Cpf) references tbcliente (Cpf),
foreign key (NumeroConta) references tbconta (NumeroConta)
);

create table tbtelefone_cliente(
Telefone int primary key,
Cpf bigint not null,
foreign key (Cpf) references tbcliente (Cpf)
);

INSERT INTO tbbanco VALUES
(1, 'Banco do Brasil'),
(104, 'Caixa Economica Federal'),
(801, 'Banco Escola');

INSERT INTO tbagencia VALUES
(123, 1, 'Av Paulista,78'),
(159, 104, 'Rua Liberdade, 124'),
(401, 801, 'Rua Vinte Três, 23'),
(485, 801, 'Av Marechal, 68');

INSERT INTO tbconta VALUES
(9876, 123, 456.05, 1),
(9877, 123, 321.00, 1),
(9878, 485, 2, 100.00),
(9879, 401, 1, 5589.48);

INSERT INTO tbcliente VALUES
(12345678910, 'Enildo', 'M', 'Rua Grande, 75'),
(12345678911, 'Astrogildo', 'M', 'Rua Pequena, 789'),
(12345678912, 'Monica', 'F', 'Rua Larga, 148'),
(12345678913, 'Cascão', 'M', 'Rua Principal, 369');

INSERT INTO tbhistorico VALUES
(12345678910, 9876, '2001-04-15'),
(12345678911, 9877, '2011-03-10'),
(12345678912, 9878, '2021-03-11'),
(12345678913, 9879, '2000-07-05');

INSERT INTO tbtelefone_cliente VALUES
(912345678, 12345678910),
(912345679, 12345678911),
(912345680, 12345678912),
(912345681, 12345678913);

alter table tbcliente add email varchar (50) null;

select Cpf, Endereco from tbcliente where Nome='Monica';
select NumeroAgencia, Endereco from tbagencia where CodBanco=801;
select * from tbcliente where Sexo='M';