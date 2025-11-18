# SQL_Enildo

my sql comandos:
``` csharp
create database PontoVirgula_db; //cria a database
create database ExeJd_db;
drop database PontoVirgula_db; // deleta a database
use ExeJd_db; // usa a database

show databases; // mostra a database

create table aluno_tb(
Id integer not null, 
NomeAlu varchar(50) null, 
Nota decimal(6,2) 
);

show tables;

describe aluno_tb;



create table tbAluno2_tb(
Id int primary key,
Sexo char (1) not null default 'F',
DataNasc date not null,
Salario float null,
check (Salario < 1000),
cpf bigint not null unique
);
describe tbAluno2_tb;
alter table tbAluno2_tb drop DataNasc;

describe tbAluno2_tb; 

alter table tbAluno2_tb add DataNasc date null;

alter table tbAluno2_tb modify DataNasc date not null;

truncate table tbAluno_tb; // tira os gaps da tabela
```

``` sql
7
SELECT 
    c.Id,
    c.NomeCli,
    pf.CPF,
    pf.RG,
    pf.RG_Dig,
    pf.Nasc,
    c.NumEnd,
    c.CompEnd,
    c.CepCli,
    e.Logradouro,
    b.Bairro,
    ci.Cidade,
    uf.UF
FROM tbCliente c
INNER JOIN tbCliente_PF pf ON pf.Id = c.Id
LEFT JOIN tbEndereco e ON e.CEP = c.CepCli
LEFT JOIN tbBairro b ON b.BairroId = e.BairroId
LEFT JOIN tbCidade ci ON ci.CidadeId = e.CidadeId
LEFT JOIN tbEstado uf ON uf.UfId = e.UfId
ORDER BY c.Id;
```

``` sql
6
SELECT
    e.CEP,
    e.Logradouro,
    b.Bairro,
    c.Cidade,
    uf.UF
FROM tbEndereco e
JOIN tbBairro b ON b.BairroId = e.BairroId
JOIN tbCidade c ON c.CidadeId = e.CidadeId
JOIN tbEstado uf ON uf.UfId = e.UfId;

```
