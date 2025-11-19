CREATE DATABASE dbDistribuidora;
USE dbDistribuidora;

-- PRODUTO
CREATE TABLE tbProduto(
    CodigoBarras DECIMAL(14,0) PRIMARY KEY,
    Nome VARCHAR(200) NOT NULL,
    ValorUnitario DECIMAL(8,2) NOT NULL,
    Qtd INT
);

-- FORNECEDOR
CREATE TABLE tbFornecedor(
    Codigo INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ DECIMAL(14,0) UNIQUE,
    Nome VARCHAR(200) NOT NULL,
    Telefone DECIMAL(11,0) NOT NULL
);

-- BAIRRO
CREATE TABLE tbBairro(
    BairroId INT PRIMARY KEY AUTO_INCREMENT,
    Bairro VARCHAR(200) NOT NULL
);

-- CIDADE
CREATE TABLE tbCidade(
    CidadeId INT PRIMARY KEY AUTO_INCREMENT,
    Cidade VARCHAR(200) NOT NULL
);

-- ESTADO
CREATE TABLE tbEstado(
    UfId INT PRIMARY KEY AUTO_INCREMENT,
    UF CHAR(2) NOT NULL
);

-- ENDEREÇO
CREATE TABLE tbEndereco(
    CEP DECIMAL(8,0) PRIMARY KEY,
    Logradouro VARCHAR(200) NOT NULL,
    BairroId INT NOT NULL,
    CidadeId INT NOT NULL,
    UfId INT NOT NULL,
    FOREIGN KEY (BairroId) REFERENCES tbBairro(BairroId),
    FOREIGN KEY (CidadeId) REFERENCES tbCidade(CidadeId),
    FOREIGN KEY (UfId) REFERENCES tbEstado(UfId)
);

-- CLIENTE
CREATE TABLE tbCliente(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    NomeCli VARCHAR(200) NOT NULL,
    NumEnd DECIMAL(6,0) NOT NULL,
    CompEnd VARCHAR(50),
    CepCli DECIMAL(8,0),
    FOREIGN KEY (CepCli) REFERENCES tbEndereco(CEP)
);

-- CLIENTE PF
CREATE TABLE tbCliente_PF(
    CPF DECIMAL(11,0) PRIMARY KEY,
    RG DECIMAL(9,0) NOT NULL,
    RG_Dig CHAR(1) NOT NULL,
    Nasc DATE,
    Id INT,
    FOREIGN KEY (Id) REFERENCES tbCliente(Id)
);

-- CLIENTE PJ
CREATE TABLE tbCliente_PJ(
    CNPJ DECIMAL(14,0) PRIMARY KEY,
    IE DECIMAL(11,0),
    Id INT,
    FOREIGN KEY (Id) REFERENCES tbCliente(Id)
);

-- NOTA FISCAL
CREATE TABLE tbNota_Fiscal(
    NF INT PRIMARY KEY,
    TotalNota DECIMAL(8,2),
    DataEmissao DATE
);

-- COMPRA
CREATE TABLE tbCompra(
    NotaFiscal INT PRIMARY KEY,
    DataCompra DATE,
    ValorTotal DECIMAL(8,2),
    QtdTotal INT,
    Codigo INT,
    FOREIGN KEY (Codigo) REFERENCES tbFornecedor(Codigo)
);

-- ITEM COMPRA
CREATE TABLE tbItemCompra(
    NotaFiscal INT,
    CodigoBarras DECIMAL(14,0),
    ValorItem DECIMAL(8,2),
    Qtd INT,
    FOREIGN KEY (NotaFiscal) REFERENCES tbCompra(NotaFiscal),
    FOREIGN KEY (CodigoBarras) REFERENCES tbProduto(CodigoBarras)
);

-- VENDA
CREATE TABLE tbVenda(
    NumeroVenda INT PRIMARY KEY,
    DataVenda DATE,
    TotalVenda DECIMAL(8,2),
    IdCli INT,
    NF INT,
    FOREIGN KEY (NF) REFERENCES tbNota_Fiscal(NF),
    FOREIGN KEY (IdCli) REFERENCES tbCliente(Id)
);

-- ITEM VENDA
CREATE TABLE tbItemVenda(
    NumeroVenda INT,
    CodigoBarras DECIMAL(14,0),
    ValorItem DECIMAL(8,2),
    Qtd INT,
    FOREIGN KEY (NumeroVenda) REFERENCES tbVenda(NumeroVenda),
    FOREIGN KEY (CodigoBarras) REFERENCES tbProduto(CodigoBarras)
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
delimiter ;

call spInsertCidade (1 , 'Rio de Janeiro');
call spInsertCidade (2 , 'Sao Carlos');
call spInsertCidade (3 , 'Campinas');
call spInsertCidade (4 , 'Franco da Rocha');
call spInsertCidade (5 , 'Osasco');
call spInsertCidade (6 , 'Pirituba');
call spInsertCidade (7 , 'Lapa');
call spInsertCidade (8 , 'Ponta Grossa');

-- exercicio 3
delimiter $$
CREATE PROCEDURE spInsertUf (vUfId int, vUF varchar (200))
BEGIN
insert into tbestado (UfId, UF)
			values (vUfId, vUF);
END $$
delimiter ;

call spInsertUf (1, 'SP');
call spInsertUf (2, 'RJ');
call spInsertUf (3, 'RS');


-- exercicio 4

delimiter $$
CREATE PROCEDURE spInsertBairro (vBairroId int, vBairro varchar (200))
BEGIN
insert into tbbairro (BairroId, Bairro)
			values (vBairroId, vBairro);
END $$
delimiter ;

call spInsertBairro (1, 'Aclimação');
call spInsertBairro (2, 'Capão Redondo');
call spInsertBairro (3, 'Pirituba');
call spInsertBairro (4, 'Liberdade');


-- exercicio 5
delimiter $$
CREATE PROCEDURE spInsertProduto (vCodigoBarras decimal(14,0), vNome varchar (200), vValor decimal(8,2), vQtd int)
BEGIN
insert into tbproduto (CodigoBarras, Nome, ValorUnitario, Qtd)
			values (vCodigoBarras, vNome, vValor, vQtd);
END $$
delimiter ;

call spInsertProduto (12345678910111, 'Rei de Papel Mache', 54.61, 120);
call spInsertProduto (12345678910112, 'Bolinha de Sabão', 100.45, 120);
call spInsertProduto (12345678910113, 'Carro Bate', 44.00, 120);
call spInsertProduto (12345678910114, 'Bola Furada', 10.00, 120);
call spInsertProduto (12345678910115, 'Maça Laranja', 99.44, 120);
call spInsertProduto (12345678910116, 'Boneco do Hitler', 124.00, 200);
call spInsertProduto (12345678910117, 'Farinha de Surui', 50.00, 200);
call spInsertProduto (12345678910118, 'Zelador de Cemiterio', 24.50, 100);


-- exercicio 6

INSERT INTO tbCidade (CidadeId, Cidade) VALUES
(9, 'São Paulo'),
(10, 'Barra Mansa');

INSERT INTO tbBairro (BairroId, Bairro) VALUES
(5, 'Lapa'),
(6, 'Consolação'),
(7, 'Penha'),
(8, 'Barra Funda');

DELIMITER $$

CREATE PROCEDURE spInsertEndereco(
    vCEP DECIMAL(8,0),
    vLogradouro VARCHAR(200),
    vBairro VARCHAR(200),
    vCidade VARCHAR(200),
    vUF CHAR(2)
)
BEGIN
    DECLARE vBairroId INT;
    DECLARE vCidadeId INT;
    DECLARE vUfId INT;

    SELECT BairroId INTO vBairroId FROM tbBairro WHERE Bairro = vBairro LIMIT 1;
    SELECT CidadeId INTO vCidadeId FROM tbCidade WHERE Cidade = vCidade LIMIT 1;
    SELECT UfId INTO vUfId FROM tbEstado WHERE UF = vUF LIMIT 1;

    IF vUfId = 1 THEN
        SET vUF = 'SP';
    ELSEIF vUfId = 2 THEN
        SET vUF = 'RJ';
    ELSEIF vUfId = 3 THEN
        SET vUF = 'RS';
    END IF;

    IF vCidadeId = 1 THEN
        SET vCidade = 'Rio de Janeiro';
    ELSEIF vCidadeId = 2 THEN
        SET vCidade = 'São Carlos';
    ELSEIF vCidadeId = 3 THEN
        SET vCidade = 'Campinas';
    ELSEIF vCidadeId = 4 THEN
        SET vCidade = 'Franco da Rocha';
    ELSEIF vCidadeId = 5 THEN
        SET vCidade = 'Osasco';
	ELSEIF vCidadeId = 6 THEN
        SET vCidade = 'Pirituba';
	ELSEIF vCidadeId = 7 THEN
        SET vCidade = 'Lapa';
	ELSEIF vCidadeId = 8 THEN
        SET vCidade = 'Ponta Grossa';
	ELSEIF vCidadeId = 9 THEN
        SET vCidade = 'São Paulo';
	ELSEIF vCidadeId = 10 THEN
        SET vCidade = 'Barra Mansa';
    END IF;

    IF vBairroId = 1 THEN
        SET vBairro = 'Aclimação';
    ELSEIF vBairroId = 2 THEN
        SET vBairro = 'Capão Redondo';
    ELSEIF vBairroId = 3 THEN
        SET vBairro = 'Pirituba';
    ELSEIF vBairroId = 4 THEN
        SET vBairro = 'Liberdade';
    ELSEIF vBairroId = 5 THEN
        SET vBairro = 'Barra Funda';
	ELSEIF vBairroId = 6 THEN
        SET vBairro = 'Consolação';
	ELSEIF vBairroId = 7 THEN
        SET vBairro = 'Penha';
	ELSEIF vBairroId = 8 THEN
        SET vBairro = 'Lapa';
    END IF;

    INSERT INTO tbEndereco(CEP, Logradouro, BairroId, CidadeId, UfId)
    VALUES (vCEP, vLogradouro, vBairroId, vCidadeId, vUfId);

END $$
DELIMITER ;

CALL spInsertEndereco(12345050, 'Rua da Federal', 'Lapa', 'São Paulo', 'SP');
CALL spInsertEndereco(12345051, 'Av Brasil', 'Lapa', 'Campinas', 'SP');
CALL spInsertEndereco(12345052, 'Rua Liberdade', 'Consolação', 'São Paulo', 'SP');
CALL spInsertEndereco(12345053, 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
CALL spInsertEndereco(12345054, 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
CALL spInsertEndereco(12345055, 'Rua Piu XI', 'Penha', 'Campinas', 'SP');
CALL spInsertEndereco(12345056, 'Rua Chocolate', 'Aclimação', 'Barra Mansa', 'RJ');
CALL spInsertEndereco(12345057, 'Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa', 'RS');


-- exercicio 7

INSERT INTO tbEstado (UfId, UF) VALUES 
(4, 'MT'),  
(5, 'PE');

INSERT INTO tbCidade (CidadeId, Cidade) VALUES 
(11, 'Cuiabá'),
(12, 'Recife');  

INSERT INTO tbBairro (BairroId, Bairro) VALUES
(9, 'Jardim Santa Isabel'),
(10, 'Sei Lá');

CALL spInsertEndereco(12345059, 'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT');
CALL spInsertEndereco(12345058, 'Av Nova', 'Jardim Santa Isabel', 'Cuiabá', 'MT'); 
CALL spInsertEndereco(12345060, 'Rua dos Amores', 'Sei Lá', 'Recife', 'PE');

DELIMITER $$

DELIMITER $$

CREATE PROCEDURE spInsertClientePF(
    vNome VARCHAR(200),
    vNumEnd INT,
    vComp VARCHAR(50),
    vCEP DECIMAL(8,0),
    vCPF DECIMAL(11,0),
    vRG DECIMAL(9,0),
    vRGdig CHAR(1),
    vNasc DATE,
    vLogradouro VARCHAR(200),
    vBairro VARCHAR(200),
    vCidade VARCHAR(200),
    vUF CHAR(2)
)
BEGIN
    DECLARE vBairroId INT;
    DECLARE vCidadeId INT;
    DECLARE vUfId INT;

    SELECT BairroId INTO vBairroId FROM tbBairro WHERE Bairro = vBairro LIMIT 1;
    SELECT CidadeId INTO vCidadeId FROM tbCidade WHERE Cidade = vCidade LIMIT 1;
    SELECT UfId INTO vUfId FROM tbEstado WHERE UF = vUF LIMIT 1;

    IF vUfId = 1 THEN SET vUF = 'SP';
    ELSEIF vUfId = 2 THEN SET vUF = 'RJ';
    ELSEIF vUfId = 3 THEN SET vUF = 'RS';
    ELSEIF vUfId = 4 THEN SET vUF = 'MT';
    ELSEIF vUfId = 5 THEN SET vUF = 'PE';
    END IF;

    IF vCidadeId = 1 THEN
        SET vCidade = 'Rio de Janeiro';
    ELSEIF vCidadeId = 2 THEN
        SET vCidade = 'São Carlos';
    ELSEIF vCidadeId = 3 THEN
        SET vCidade = 'Campinas';
    ELSEIF vCidadeId = 4 THEN
        SET vCidade = 'Franco da Rocha';
    ELSEIF vCidadeId = 5 THEN
        SET vCidade = 'Osasco';
	ELSEIF vCidadeId = 6 THEN
        SET vCidade = 'Pirituba';
	ELSEIF vCidadeId = 7 THEN
        SET vCidade = 'Lapa';
	ELSEIF vCidadeId = 8 THEN
        SET vCidade = 'Ponta Grossa';
	ELSEIF vCidadeId = 9 THEN
        SET vCidade = 'São Paulo';
	ELSEIF vCidadeId = 10 THEN
        SET vCidade = 'Barra Mansa';
    ELSEIF vCidadeId = 11 THEN 
		SET vCidade = 'Cuiabá';
    ELSEIF vCidadeId = 12 THEN 
		SET vCidade = 'Recife';
    END IF;

    IF vBairroId = 1 THEN
        SET vBairro = 'Aclimação';
    ELSEIF vBairroId = 2 THEN
        SET vBairro = 'Capão Redondo';
    ELSEIF vBairroId = 3 THEN
        SET vBairro = 'Pirituba';
    ELSEIF vBairroId = 4 THEN
        SET vBairro = 'Liberdade';
    ELSEIF vBairroId = 5 THEN
        SET vBairro = 'Barra Funda';
	ELSEIF vBairroId = 6 THEN
        SET vBairro = 'Consolação';
	ELSEIF vBairroId = 7 THEN
        SET vBairro = 'Penha';
	ELSEIF vBairroId = 8 THEN
        SET vBairro = 'Lapa';
    ELSEIF vBairroId = 9 THEN 
		SET vBairro = 'Jardim Santa Isabel';
    ELSEIF vBairroId = 10 THEN 
		SET vBairro = 'Vila Nova';
    ELSEIF vBairroId = 11 THEN 
		SET vBairro = 'Sei Lá';
    END IF;

    INSERT INTO tbCliente (NomeCli, NumEnd, CompEnd, CepCli)
    VALUES (vNome, vNumEnd, vComp, vCEP);

    INSERT INTO tbCliente_PF (CPF, RG, RG_Dig, Nasc, Id)
    VALUES (vCPF, vRG, vRGdig, vNasc, LAST_INSERT_ID());

END $$
DELIMITER ;

CALL spInsertClientePF(
    'Pimpão', 325, NULL, 12345051,
    12345678911, 12345678, '0', '2000-10-12',
    'Av Brasil', 'Lapa', 'Campinas', 'SP'
);

CALL spInsertClientePF(
    'Disney Chaplin', 89, 'Ap. 12', 12345053,
    12345678912, 12345679, '0', '2001-11-21',
    'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ'
);

CALL spInsertClientePF(
    'Marciano', 744, NULL, 12345054,
    12345678913, 12345680, '0', '2001-06-01',
    'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ'
);

CALL spInsertClientePF(
    'Lança Perfume', 128, NULL, 12345059,
    12345678914, 12345681, 'X', '2004-04-05',
    'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT'
);

CALL spInsertClientePF(
    'Remédio Amargo', 2585, NULL, 12345058,
    12345678915, 12345682, '0', '2002-07-15',
    'Av Nova', 'Jardim Santa Isabel', 'Cuiabá', 'MT'
);

-- Exercicio 8

DELIMITER $$

CREATE PROCEDURE spInsertClientePJ(
    vNome VARCHAR(200),
    vCNPJ DECIMAL(14,0),
    vIE DECIMAL(11,0),
    vCEP DECIMAL(8,0),
    vLogradouro VARCHAR(200),
    vNumEnd INT,
    vComp VARCHAR(50),
    vBairro VARCHAR(200),
    vCidade VARCHAR(200),
    vUF CHAR(2)
)
BEGIN
    DECLARE vBairroId INT;
    DECLARE vCidadeId INT;
    DECLARE vUfId INT;

    SELECT BairroId INTO vBairroId FROM tbBairro WHERE Bairro = vBairro LIMIT 1;
    SELECT CidadeId INTO vCidadeId FROM tbCidade WHERE Cidade = vCidade LIMIT 1;
    SELECT UfId INTO vUfId FROM tbEstado WHERE UF = vUF LIMIT 1;

    IF vUfId = 1 THEN SET vUF = 'SP';
    ELSEIF vUfId = 2 THEN SET vUF = 'RJ';
    ELSEIF vUfId = 3 THEN SET vUF = 'RS';
    ELSEIF vUfId = 4 THEN SET vUF = 'MT';
    ELSEIF vUfId = 5 THEN SET vUF = 'PE';
    END IF;

   IF vCidadeId = 1 THEN
        SET vCidade = 'Rio de Janeiro';
    ELSEIF vCidadeId = 2 THEN
        SET vCidade = 'São Carlos';
    ELSEIF vCidadeId = 3 THEN
        SET vCidade = 'Campinas';
    ELSEIF vCidadeId = 4 THEN
        SET vCidade = 'Franco da Rocha';
    ELSEIF vCidadeId = 5 THEN
        SET vCidade = 'Osasco';
	ELSEIF vCidadeId = 6 THEN
        SET vCidade = 'Pirituba';
	ELSEIF vCidadeId = 7 THEN
        SET vCidade = 'Lapa';
	ELSEIF vCidadeId = 8 THEN
        SET vCidade = 'Ponta Grossa';
	ELSEIF vCidadeId = 9 THEN
        SET vCidade = 'São Paulo';
	ELSEIF vCidadeId = 10 THEN
        SET vCidade = 'Barra Mansa';
    ELSEIF vCidadeId = 11 THEN 
		SET vCidade = 'Cuiabá';
    ELSEIF vCidadeId = 12 THEN 
		SET vCidade = 'Recife';
    END IF;

    IF vBairroId = 1 THEN
        SET vBairro = 'Aclimação';
    ELSEIF vBairroId = 2 THEN
        SET vBairro = 'Capão Redondo';
    ELSEIF vBairroId = 3 THEN
        SET vBairro = 'Pirituba';
    ELSEIF vBairroId = 4 THEN
        SET vBairro = 'Liberdade';
    ELSEIF vBairroId = 5 THEN
        SET vBairro = 'Barra Funda';
	ELSEIF vBairroId = 6 THEN
        SET vBairro = 'Consolação';
	ELSEIF vBairroId = 7 THEN
        SET vBairro = 'Penha';
	ELSEIF vBairroId = 8 THEN
        SET vBairro = 'Lapa';
    ELSEIF vBairroId = 9 THEN 
		SET vBairro = 'Jardim Santa Isabel';
    ELSEIF vBairroId = 10 THEN 
		SET vBairro = 'Vila Nova';
    ELSEIF vBairroId = 11 THEN 
		SET vBairro = 'Sei Lá';
    END IF;

    INSERT INTO tbCliente (NomeCli, NumEnd, CompEnd, CepCli)
    VALUES (vNome, vNumEnd, vComp, vCEP);

    INSERT INTO tbCliente_PJ (CNPJ, IE, Id)
    VALUES (vCNPJ, vIE, LAST_INSERT_ID());
END $$

DELIMITER ;

CALL spInsertClientePJ(
    'Paganada', 12345678912345, 98765432198,
    12345051, 'Av Brasil', 159, NULL,
    'Lapa', 'Campinas', 'SP'
);

CALL spInsertClientePJ(
    'Caloteando', 12345678912346, 98765432199,
    12345053, 'Av Paulista', 69, NULL,
    'Penha', 'Rio de Janeiro', 'RJ'
);

CALL spInsertClientePJ(
    'Semgrana', 12345678912347, 98765432100,
    12345060, 'Rua dos Amores', 189, NULL,
    'Sei Lá', 'Recife', 'PE'
);

CALL spInsertClientePJ(
    'Cemreais', 12345678912348, 98765432101,
    12345060, 'Rua dos Amores', 5024, 'Sala 23',
    'Sei Lá', 'Recife', 'PE'
);

CALL spInsertClientePJ(
    'Durango', 12345678912349, 98765432102,
    12345060, 'Rua dos Amores', 1254, NULL,
    'Sei Lá', 'Recife', 'PE'
);

-- exercicio 9

DELIMITER $$

CREATE PROCEDURE spInsertCompra(
    vNotaFiscal INT,
    vFornecedor VARCHAR(200),
    vDataCompra VARCHAR(10),
    vCodigoBarras DECIMAL(14,0),
    vValorItem DECIMAL(8,2),
    vQtd INT,
    vQtdTotal INT,
    vValorTotal DECIMAL(10,2)
)
BEGIN
    DECLARE vCodForn INT;
    DECLARE vData DATE;

    -- Busca o código do fornecedor
    SELECT Codigo INTO vCodForn
    FROM tbFornecedor
    WHERE Nome = vFornecedor
    LIMIT 1;

    SET vData = STR_TO_DATE(vDataCompra, '%d/%m/%Y');

    -- Insere na tbcompra apenas se a nota fiscal ainda não existir
    IF NOT EXISTS (SELECT 1 FROM tbCompra WHERE NotaFiscal = vNotaFiscal) THEN
        INSERT INTO tbCompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, Codigo)
        VALUES (vNotaFiscal, vData, vValorTotal, vQtdTotal, vCodForn);
    END IF;

    -- Insere o item na tbitemcompra
    INSERT INTO tbItemCompra(NotaFiscal, CodigoBarras, ValorItem, Qtd)
    VALUES (vNotaFiscal, vCodigoBarras, vValorItem, vQtd);

END $$

DELIMITER ;

CALL spInsertCompra(8459, 'Amoroso e Doce', '01/05/2018', 12345678910111, 22.22, 200, 700, 21944.00);
CALL spInsertCompra(8459, 'Amoroso e Doce', '01/05/2018', 12345678910114, 35.00, 500, 700, 21944.00);
CALL spInsertCompra(2482, 'Revenda Chico Loco', '22/04/2020', 12345678910112, 40.50, 180, 180, 7290.00);
CALL spInsertCompra(21563, 'Marcelo Dedal', '12/07/2020', 12345678910113, 3.00, 300, 300, 900.00);
CALL spInsertCompra(156354, 'Revenda Chico Loco', '23/11/2021', 12345678910115, 54.00, 350, 350, 18900.00);

-- exercicio 10

DELIMITER $$

CREATE PROCEDURE spInsertVenda(
    vNumeroVenda INT,
    vNomeCliente VARCHAR(200),
    vCodigoBarras DECIMAL(14,0),
    vQtd INT
)
BEGIN
    DECLARE vIdCli INT;
    DECLARE vValorItem DECIMAL(8,2);
    DECLARE vTotal DECIMAL(10,2);

    SELECT Id INTO vIdCli
    FROM tbCliente
    WHERE NomeCli = vNomeCliente
    LIMIT 1;


    SELECT ValorUnitario INTO vValorItem
    FROM tbProduto
    WHERE CodigoBarras = vCodigoBarras
    LIMIT 1;


    SET vTotal = vValorItem * vQtd;

    INSERT INTO tbVenda(NumeroVenda, DataVenda, TotalVenda, IdCli)
    VALUES (vNumeroVenda, CURDATE(), vTotal, vIdCli);
    
    INSERT INTO tbItemVenda(NumeroVenda, CodigoBarras, ValorItem, Qtd)
    VALUES (vNumeroVenda, vCodigoBarras, vValorItem, vQtd);

END $$

DELIMITER ;
CALL spInsertVenda(1, 'Pimpão',        12345678910111, 1);
CALL spInsertVenda(2, 'Lança Perfume', 12345678910112, 2);
CALL spInsertVenda(3, 'Pimpão',        12345678910113, 1);


-- exercicio 11

DELIMITER $$

CREATE PROCEDURE spEmitirNotaFiscal(
    vNF INT,
    vNomeCliente VARCHAR(200)
)
BEGIN
    DECLARE vIdCli INT;
    DECLARE vTotal DECIMAL(10,2);

    SELECT Id INTO vIdCli
    FROM tbCliente
    WHERE NomeCli = vNomeCliente
    LIMIT 1;
    
    SELECT SUM(TotalVenda) INTO vTotal
    FROM tbVenda
    WHERE IdCli = vIdCli;

    INSERT INTO tbNota_Fiscal(NF, TotalNota, DataEmissao)
    VALUES (vNF, vTotal, CURDATE());

    UPDATE tbVenda SET NF = vNF WHERE IdCli = vIdCli;

END $$

DELIMITER ;

CALL spEmitirNotaFiscal(359, 'Pimpão');
CALL spEmitirNotaFiscal(360, 'Lança Perfume');


-- exercicio 12

DELIMITER $$

CREATE PROCEDURE spInsertProdutoNovo(
    vCodigo DECIMAL(14,0),
    vNome VARCHAR(200),
    vValor DECIMAL(8,2),
    vQtd INT
)
BEGIN
    INSERT INTO tbProduto (CodigoBarras, Nome, ValorUnitario, Qtd)
    VALUES (vCodigo, vNome, vValor, vQtd);
END $$

DELIMITER ;

CALL spInsertProdutoNovo(12345678910130, 'Camiseta de Poliéster', 35.61, 100);
CALL spInsertProdutoNovo(12345678910131, 'Blusa Frio Moletom', 200.00, 100);
CALL spInsertProdutoNovo(12345678910132, 'Vestido Decote Redondo', 144.00, 50);

-- exercicio 13

DELIMITER $$

CREATE PROCEDURE spDeleteProduto(
    vCodigo DECIMAL(14,0)
)
BEGIN
    DELETE FROM tbProduto WHERE CodigoBarras = vCodigo;
END $$

DELIMITER ;

CALL spDeleteProduto(12345678910116);
CALL spDeleteProduto(12345678910117);

-- exercicio 14

DELIMITER $$

CREATE PROCEDURE spUpdateProduto(
    vCodigo DECIMAL(14,0),
    vNovoNome VARCHAR(200),
    vNovoValor DECIMAL(8,2)
)
BEGIN
    UPDATE tbProduto
    SET Nome = vNovoNome,
        ValorUnitario = vNovoValor
    WHERE CodigoBarras = vCodigo;
END $$

DELIMITER ;

CALL spUpdateProduto(12345678910111, 'Rei de Papel Mache', 64.50);
CALL spUpdateProduto(12345678910112, 'Bolinha de Sabão', 120.00);
CALL spUpdateProduto(12345678910113, 'Carro Bate Bate', 64.00);

-- exercicio 15

DELIMITER $$

CREATE PROCEDURE spMostrarProduto()
BEGIN
select * from tbproduto order by CodigoBarras;
END$$

DELIMITER ;

CALL spMostrarProduto();