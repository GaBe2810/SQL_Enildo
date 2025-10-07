-- Usar a database dbbanco
-- exercicio 1
delete from tbtelefone_cliente where Cpf=12345678911;

-- exercicio 2
update tbconta set TipoConta = 2 where NumeroConta = 9879;

-- exercicio 3
update tbcliente set email = 'Astro@Escola.com' where Nome = 'Monica';

-- exercicio 4
update tbconta set Saldo = Saldo + Saldo*0.10 where NumeroConta = 9876;

-- exercicio 5
select Nome, email, Endereco from tbcliente where Nome='Monica';

-- exercicio 6
update tbcliente set Nome = 'Enildo Candido', email = 'enildo@escola.com' where Nome = 'Enildo';

-- exercicio 7
update tbconta set Saldo = Saldo - 30;

-- exercicio 8
delete from tbhistorico where NumeroConta = 9878;
delete from tbconta where NumeroConta = 9878;

-- Nesse exercicio só é possivel apagar o usuario 9878 excluindo seu registro da tbconta caso apague seu registro na tbhistorico.


select * from tbconta;
select * from tbcliente;
select * from tbtelefone_cliente;