create database dbdistribuidora;

use dbdistribuidora;

create table tbproduto(
CodigoBarras decimal(14,0) primary key,
Nome varchar(200) not null,
Valor decimal(8,2) not null,
Qtd int null
);

create table tbfornecedor(
Codigo int primary key auto_increment,
CNPJ decimal(14,0) null unique,
Nome varchar (200) not null,
Telefone decimal(11,0) not null
);

create table tbcompra(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal (8,2) not null,
QtdTotal int not null,
Codigo int null,
foreign key (Codigo) references tbfornecedor (Codigo)
);

create table tbitemcompra(
NotaFiscal int not null,
CodigoBarras decimal(14,0) not null,
ValorItem decimal (8,2) not null,
Qtd int not null,
foreign key (NotaFiscal) references tbcompra (NotaFiscal),
foreign key (CodigoBarras) references tbproduto (CodigoBarras)
);

create table tbNota_Fiscal(
NF int primary key,
TotalNota decimal (8,2) not null,
DataEmissao date not null
);

create table tbbairro(
BairroId int primary key auto_increment,
Bairro varchar(200) not null
);

create table tbcidade(
cidadeId int primary key auto_increment,
Cidade varchar(200) not null
);

create table tbestado(
UfId int primary key auto_increment,
UF varchar(2) not null
);

create table tbendereco(
Logradouro varchar(200) not null,
CEP decimal (8,0) primary key,
BairroID int not null,
CidadeID int not null,
UfID int not null,
foreign key (BairroId) references tbbairro (BairroId),
foreign key (CidadeId) references tbcidade (CidadeId),
foreign key (UfId) references tbestado (UfId)
);

-- foreign key () references tb ()

create table tbcliente (
Id int primary key auto_increment,
NomeCli varchar(200) not null,
NumEnd Decimal(6,0) not null,
CompEnd Varchar (50) null,
CepClI decimal(8,0) null,
foreign key (CepCli) references tbendereco (Cep)
);

create table tbcliente_pf(
CPF decimal(11,0) primary Key,
Rg decimal (9,0) not null,
Rg_Dig char (1) not null,
Nasc date null,
Id int null
);

create table tbcliente_pj(
CNPJ decimal(14,0) primary key,
IE decimal(11,0) null unique,
Id int null
);

create table tbvenda(
NumeroVenda int primary key,
DataVenda date not null,
TotalVenda decimal (8,2) not null,
IdCli int not null,
NF int null,
foreign key (NF) references tbNota_Fiscal (NF),
foreign key (IdCli) references tbcliente (Id)
);

create table tbitemvenda(
NumeroVenda int not null,
CodigoBarras decimal(14,0) not null,
ValorItem decimal (8,2) not null,
Qtd int not null,
foreign key (NumeroVenda) references tbvenda (NumeroVenda),
foreign key (CodigoBarras) references tbproduto (CodigoBarras)
);

-- exercicio 1
insert into tbfornecedor values
(1, 1245678937123, 'Revenda Chico Loco', 11934567897),
(2, 1345678967123, 'José Faz Tudo S/A', 11934567898),
(3, 1445678967123, 'Vadalto Entregas', 11934567899),
(4, 1545678967123, 'Astrogildo das Estrelas', 11934567800),
(5, 1645678967123, 'Amoroso e Doce', 11934567801),
(6, 1745678967123, 'Marcelo Dedal', 11934567802),
(7, 1845678967123, 'Franciscano Cachaça', 11934567803),
(8, 1945678967123, 'Joãozinho Chupeta', 11934567804);

-- exercicio 2

delimiter $$
CREATE PROCEDURE spInsertCidade (vCidadeId int, vCidade varchar (200))
BEGIN
insert into tbcidade (CidadeId, Cidade)
			values (vCidadeId, vCidade);
END $$

call spInsertCidade (1 , 'Rio de Janeiro');
call spInsertCidade (2 , 'Sao Carlos');
call spInsertCidade (3 , 'Campinas');
call spInsertCidade (4 , 'Franco da Rocha');
call spInsertCidade (5 , 'Osasco');
call spInsertCidade (6 , 'Pirituba');
call spInsertCidade (7 , 'Lapa');
call spInsertCidade (8 , 'Ponta Grossa');

select * from tbcidade;

-- exercicio 3
delimiter $$
CREATE PROCEDURE spInsertUf (vUfId int, vUF varchar (200))
BEGIN
insert into tbestado (UfId, UF)
			values (vUfId, vUF);
END $$

call spInsertUf (1, 'SP');
call spInsertUf (2, 'RJ');
call spInsertUf (3, 'RS');

select * from tbestado;

-- exercicio 4

delimiter $$
CREATE PROCEDURE spInsertBairro (vBairroId int, vBairro varchar (200))
BEGIN
insert into tbbairro (BairroId, Bairro)
			values (vBairroId, vBairro);
END $$

call spInsertBairro (1, 'Aclimação');
call spInsertBairro (2, 'Capão Redondo');
call spInsertBairro (3, 'Pirituba');
call spInsertBairro (4, 'Liberdade');

select * from tbbairro;

-- exercicio 5
delimiter $$
CREATE PROCEDURE spInsertProduto (vCodigoBarras decimal(14,0), vNome varchar (200), vValor decimal(8,2), vQtd int)
BEGIN
insert into tbproduto (CodigoBarras, Nome, Valor, Qtd)
			values (vCodigoBarras, vNome, vValor, vQtd);
END $$

call spInsertProduto (12345678910111, 'Rei de Papel Mache', 54.61, 120);
call spInsertProduto (12345678910112, 'Bolinha de Sabão', 100.45, 120);
call spInsertProduto (12345678910113, 'Carro Bate', 44.00, 120);
call spInsertProduto (12345678910114, 'Bola Furada', 10.00, 120);
call spInsertProduto (12345678910115, 'Maça Laranja', 99.44, 120);
call spInsertProduto (12345678910116, 'Boneco do Hitler', 124.00, 200);
call spInsertProduto (12345678910117, 'Farinha de Surui', 50.00, 200);
call spInsertProduto (12345678910118, 'Zelador de Cemiterio', 24.50, 100);

select * from tbproduto;

-- exercicio 6

/*delimiter $$
CREATE PROCEDURE spInsertEndereco (vLogradouro varchar(200), vCEP decimal (8,0), vBairroID int, vCidadeID int, vUfID int)
BEGIN
insert into tbproduto (Logradouro, CEP, BairroID, CidadeID, UfID)
			values (vLogradouro, vCEP, vBairroID, vCidadeID, vUfID);
END $$
*/
