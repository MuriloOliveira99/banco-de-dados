 ---------------------------------------------------------------------------
-- CONSTRAINTS: PRIMARY KEY (PK)
---------------------------------------------------------------------------
/*
Torna a(s) coluna(s) com preenchimento obrigatório e atômico 
Não aceita duplicação de valores, não aceita NULL
Permitido somente uma PK por tabela
No SQL Server, dependendo de como for criada, gera a criação de Constraint e de Índice CLUSTERED
*/

-- 1. Criando PRIMARY KEY da forma mais simples
if exists(select * from sys.tables where name = 'TBTeste05')
	drop table TBTeste05
go

create table TBTeste05
(
	id			tinyint primary key, 
	nome		varchar(20), 
)

sp_help TBTeste05

insert TBTeste05 (id, nome) values (1, 'Cadeira'), (2, 'Mesa')
insert TBTeste05 values (3, 'Janela')

select * from TBTeste05



-- 2. Nomeando uma PRIMARY KEY COMPOSTA
if exists(select * from sys.tables where name = 'TBTeste05')
	drop table TBTeste05
go

create table TBTeste05
(
	id			tinyint, 
	nome		varchar(20), 
	constraint pkTBTeste05 primary key (id, nome)
)	

sp_help TBTeste05

insert TBTeste05 (id, nome) values (1, 'Cadeira'), (2, 'Mesa')
insert TBTeste05 values (2, 'Janela')
insert TBTeste05 values (3, 'Cadeira')
insert TBTeste05 values (2, 'Mesa')

select * from TBTeste05



-- 3. Nomeando uma PRIMARY KEY SIMPLES
if exists(select * from sys.tables where name = 'TBTeste05')
	drop table TBTeste05
go

create table TBTeste05
(
	id			tinyint identity(1,1) constraint pkTBTeste05 primary key, 
	nome		varchar(20)
)	

sp_help TBTeste05

insert TBTeste05 (nome) values ('Cadeira'), ('Mesa')
insert TBTeste05 values ('Janela')
insert TBTeste05 values ('Cadeira')
insert TBTeste05 values (2, 'Copo')

select * from TBTeste05


-- 4. DROP e ADD PRIMARY KEY em tabelas existentes
-- Clustered e Unique (padrão)
alter table TBTeste05 drop constraint pkTBTeste05 

sp_help TBTeste05
-- adicionando uma primary key em tabelas existentes
alter table TBTeste05 add constraint pkTBTeste05 primary key (id)

-- nonClustered e Unique
alter table TBTeste05 drop constraint pkTBTeste05 

sp_help TBTeste05

alter table TBTeste05 add constraint pkTBTeste05 primary key nonclustered (id)

-- nonClustered na coluna NOME
alter table TBTeste05 drop constraint pkTBTeste05 

sp_help TBTeste05

alter table TBTeste05 add constraint pkTBTeste05 primary key nonclustered (nome) -- Falha

-- Ajuste de coluna
alter table TBTeste05 alter column nome varchar(20) not null 

alter table TBTeste05 add constraint pkTBTeste05 primary key nonclustered (nome) -- Falha

select * from TBTeste05
update TBTeste05 set nome = 'Garrafa' where id = 4

alter table TBTeste05 add constraint pkTBTeste05 primary key nonclustered (nome) -- Falha
sp_help TBTeste05
---------------------------------------------------------------------------











---------------------------------------------------------------------------
-- CONSTRAINTS: UNIQUE (UQ)
---------------------------------------------------------------------------
/*
Torna a(s) coluna(s) com preenchimento único
Não aceita duplicação de valores, aceita NULL
Permitido várias UQ por tabela
No SQL Server, dependendo de como for criada, gera a criação de Constraint e de Índice CLUSTERED
Permitido somente uma PK por tabela
No SQL Server, dependendo de como for criada, gera a criação de Constraint e de Índice
*/


-- 1. Criando UNIQUE
if exists(select * from sys.tables where name = 'TBTeste06')
	drop table TBTeste06
go

create table TBTeste06
(
	id		tinyint identity (5, 2) constraint pkTBTeste06 primary key, 
	rg		int unique, 
	cpf		int, 
	constraint uqTBTeste06_cpf unique (cpf)
)
go
sp_help TBTeste06

insert TBTeste06 values (15745678, 215468455)
insert TBTeste06 values (846575465, 754654215)

insert TBTeste06 values (15745678, 456452156)
insert TBTeste06 values (456452156, 215468455)

select * from TBTeste06

delete TBTeste06 -- menos rapido que o truncate e não zera o identity
truncate table TBTeste06 -- mais rapido que o delete e zera o identity


-- 2. Recriando UNIQUE
alter table TBTeste06 drop constraint uqTBTeste06_cpf
alter table TBTeste06 add constraint uqTBTeste06_cpf unique (cpf)

sp_help TBTeste06
---------------------------------------------------------------------------













---------------------------------------------------------------------------
-- CONSTRAINTS: FOREIGN KEY
---------------------------------------------------------------------------
/*
Torna a(s) coluna(s) com preenchimento relacionado a PK ou UQ de outra tabela
Valores na coluna devem necessariamente EXISTIR na tabela referência
Permite NULL
Permitido várias FKs por tabela
No SQL Server, gera a criação de Constraint mas NÃO cria índice
*/

-- 1. FOREIGN KEY Padrão
if exists(select * from sys.tables where name = 'Compra')
	drop table Compra
	
if exists(select * from sys.tables where name = 'Setor')
	drop table Setor

-- Estrutura
create table Setor
(
	idSetor		tinyint identity(1,1) constraint pkSetor primary key 
	, descricao	varchar(10)
)

create table Compra
(
	idCompra	smallint identity(-32768, 1)
	, produto		varchar(20) 
	, idRefSetor		tinyint
	,constraint pkCompra primary key (idCompra)
	,constraint fkCompra_idRefSetor foreign key (idRefSetor) references Setor (idSetor)
)	

sp_help Setor
sp_help Compra

-- Inserindo SETOR
insert Setor values ('Roupas')
insert Setor values ('Alimentos')
insert Setor values ('Limpeza')

select * from Setor


-- Inserindo Compra
insert Compra Values ('Camisa', 1), ('Calça', 1), ('Sapato', 1)
insert Compra Values ('Biscoito', 2), ('Extrato de Tomate', 2)
insert Compra Values ('Álcool', 3), ('Detergente', 3), ('Desinfetante', 3), ('Sabão', 3)

select * from Compra

delete Setor where IDSetor = 1
delete Compra

select *, object_name(parent_object_id) from sys.objects where name = 'fkCompra_idRefSetor'



-- 2. FOREIGN KEY com CASCADE
if exists(select * from sys.tables where name = 'Compra')
	drop table Compra
	
if exists(select * from sys.tables where name = 'Setor')
	drop table Setor

-- Estrutura
create table Setor
(
	idSetor		tinyint constraint pkSetor primary key 
	, descricao	varchar(10)
)

create table Compra
(
	idCompra		smallint identity(-32768, 1)
	, produto		varchar(20) 
	, idRefSetor	tinyint
	,constraint pkCompra primary key (idCompra)
	,constraint fkCompra_idRefSetor foreign key (idRefSetor) references Setor (idSetor)
						on delete cascade -- no action / on delete cascade / on delete set null / on delete set default
						on update cascade -- no action / on update cascade / on update set null / on update set default
)	

sp_help Setor
sp_help Compra

-- Inserindo SETOR e Compra
insert Setor values (1, 'Roupas')
insert Setor values (2, 'Alimentos')
insert Setor values (3, 'Limpeza')
insert Compra Values ('Camisa', 1), ('Calça', 1), ('Sapato', 1)
insert Compra Values ('Biscoito', 2), ('Extrato de Tomate', 2)
insert Compra Values ('Álcool', 3), ('Detergente', 3), ('Desinfetante', 3), ('Sabão', 3)

select * from Setor
select * from Compra

-- CASCADE no UPDATE
update Setor set idSetor = 120 where idSetor = 1
select * from Setor
select * from Compra

-- CASCADE no SELECT
delete Setor where IDSetor = 2
select * from Setor
select * from Compra
---------------------------------------------


























---------------------------------------------------------------------------
-- CONSTRAINTS: DEFAULT (DF)
---------------------------------------------------------------------------
/*
Torna o preenchimento da coluna AUTOMÁTICO, caso não forneçamos nenhum valor
Atua somente na cláusula INSERT
Não pode ser aplicado em coluna com IDENTITY
Permite NULL, valor constante ou função escalar
Os valores DEVEM ser compatíveis com o tipo de dados da coluna
Permitido somente um DEFAULT por coluna da tabela
*/


-- 1. Criando DEFAULT da forma mais simples
if exists(select * from sys.tables where name = 'TBTeste07')
	drop table TBTeste07
go


create table TBTeste07
(
	id			 tinyint identity(1,1) 
	, dataCompra datetime default getdate() 
)

sp_help TBTeste07

insert TBTeste07 values(default)
insert TBTeste07 values(getdate())

select * from TBTeste07



-- 2. Nomeando DEFAULT 
if exists(select * from sys.tables where name = 'TBTeste07')
	drop table TBTeste07
go

create table TBTeste07
(
	id				tinyint identity(1,1) 
	, dataCompra	date constraint dfTBTeste07_dataCompra Default '20071231'
	, nota			varchar(20)
)

sp_help TBTeste07

insert TBTeste07 (nota) values ('Observar Inserção')

select * from TBTeste07


-- 3. Adicionando / Retirando DEFAULT da forma mais simples
if exists(select * from sys.tables where name = 'TBTeste07')
	drop table TBTeste07
go

create table TBTeste07
(
	id				tinyint 
	, dataCompra	datetime 
)

alter table TBTeste07 add constraint dfTBTeste07_id default 1 for ID 

insert 	TBTeste07 (id) values (default)
insert 	TBTeste07 (dataCompra) values (getdate())

select * from TBTeste07

alter table TBTeste07 drop constraint dfTBTeste07_id 


-- 4. Default com WITH VALUES popula NULLs com valor default
if exists(select * from sys.tables where name = 'TBTeste07')
	drop table TBTeste07
go

create table TBTeste07
(
	id	tinyint
)


insert TBTeste07 values (1)
insert TBTeste07 values (2)
insert TBTeste07 values (3)

select * from TBTeste07

-- Adicionando DATACOMPRA já com DEFAULT - Com NULL para dados já existentes
alter table TBTeste07 add dataCompra datetime null constraint dfTBTeste07_DataCompra default getdate()
select * from TBTeste07

-- Retirando DEFAULT e DATACOMPRA
alter table TBTeste07 drop constraint dfTBTeste07_DataCompra 
alter table TBTeste07 drop column dataCompra

-- Adicionando DATACOMPRA já com DEFAULT - Preenchendo valores já existentes
alter table TBTeste07 add dataCompra datetime null constraint dfTBTeste07_DataCompra default getdate() with values	
select * from TBTeste07
---------------------------------------------

















---------------------------------------------------------------------------
-- CONSTRAINTS: CHECK (CK)
---------------------------------------------------------------------------
/*
Impõe restrição no preenchimento da coluna
Atua nas cláusulas INSERT e UPDATE
Permite NULL, valor constante, intervalo de valores e máscaras de preenchimento
Permitido vários CHECK por coluna da tabela
*/

-- 1. Criando CHECK da forma mais simples
if exists(select * from sys.tables where name = 'TBTeste08')
	drop table TBTeste08
go

create table TBTeste08
(
	idade tinyint check (Idade >= 18 and Idade <= 130)
)

sp_help TBTeste08

insert TBTeste08 (idade) values (18), (35), (86), (130)

select * from TBTeste08

insert TBTeste08 (idade) values (17)



-- 2. Nomeando o CHECK / inserindo máscara de preenchimento 
if exists(select * from sys.tables where name = 'TBTeste08')
	drop table TBTeste08
go

create table TBTeste08
(
	id			smallint identity(-32768, 1) constraint pkTBTeste08 primary key
	, telefone	varchar(15) constraint ckTBTeste08_telefone check	(
																telefone like '[0-9][0-9][0-9] - [0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' 
																or
																telefone like '([0-9][0-9][0-9]) [0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
	, dataEntrada datetime constraint dfTBTeste08_dataEntrada default getdate()
	, Idade		tinyint not null constraint ckTBTeste08_idade check (Idade between 16 and 130)
	, constraint ckTBTeste08_Tabela  check ((Idade > 18) or year(dataEntrada) >= 2008) -- Em 2008 autorizaram idade entre 16 e 18
)

-------------------------------------------------------------------------------------------------------------------------------------------------
-- Entendimento da Constraint da Tabela: Se Idade > 18, qualquer Ano da data permitirá o INSERT/UPDATE
--										 Caso contrário (Idade = 16, 17, 18) Ano da data tem que ser >=	2008, aí também, permite INSERT/UPDATE
-------------------------------------------------------------------------------------------------------------------------------------------------

sp_help TBTeste08

insert TBTeste08 values ('011 - 9123-4567', default, 21)
insert TBTeste08 values ('(011) 9123-4567', default, 19)

select * from TBTeste08

insert TBTeste08 values ('(011) 9823-9876', default, 131) -- Violando Check Idade
insert TBTeste08 values ('(011) 91234567', '20180228', 25) -- Violando Check Telefone
insert TBTeste08 values ('(011) 9823-9876', '20071231', 17) -- Violando Check Tabela

-- Prova do Check da tabela
insert TBTeste08 values ('(011) 9123-4567', '20180228', 25) -- ok
insert TBTeste08 values ('(011) 9123-4567', '20180228', 18) -- ok
insert TBTeste08 values ('(011) 9123-4567', '20180228', 16) -- ok

insert TBTeste08 values ('(011) 9123-4567', '20070228', 18) -- CHECK constraint "ckTBTeste08_Tabela
insert TBTeste08 values ('(011) 9123-4567', '20020228', 21) -- ok
insert TBTeste08 values ('(011) 9123-4567', '20020228', 16) -- CHECK constraint "ckTBTeste08_Tabela"



-- 3. Desligando / Ligando CHECK momentaneamente (Otimização de Processos de Carga) 
alter table TBTeste08 nocheck constraint ckTBTeste08_idade 

sp_help TBTeste08 -- status_enabled = Disabled

insert TBTeste08 values ('(011) 9823-9876', default, 131) -- Violando Check Idade
select * from TBTeste08

-- Ligar SEM VERIFICAR DADOS
alter table TBTeste08 check constraint ckTBTeste08_idade

-- Ligar COM VERIFICAÇÃO DE DADOS
alter table TBTeste08 with check check constraint ckTBTeste08_idade 
delete TBTeste08 where idade > 130
alter table TBTeste08 with check check constraint ckTBTeste08_idade 
---------------------------------------------------------------------------








--------------------------------------------------------------------------------------------
-- IDENTITY
--------------------------------------------------------------------------------------------
if exists(select * from sys.tables where name = 'TBTeste09')
	drop table TBTeste09, TBTeste10
go

create table TBTeste09
(
	id smallint identity(10, 1) constraint pkTBTeste09 primary key
	, nome	varchar(15) constraint uqTBTeste09_nome unique
)

-- INSERT
insert TBTeste09 (nome) values ('Rafa') 
select * from TBTeste09

-- Sem apontamento direto para coluna
insert TBTeste09 (id, nome) values (10, 'Rafa') -- INSERT ou UPDATE não podem DEVEM modificar a coluna
update TBTeste09 set id = 11 where id = 10 -- INSERT ou UPDATE não podem DEVEM modificar a coluna

-- UPDATE
update TBTeste09 set nome = 'Fernanda' where id = 10 -- INSERT ou UPDATE não podem DEVEM modificar a coluna
select * from TBTeste09


-----------------------------------------------------------------------
-- SCOPE_IDENTITY(): Retorno último IDENTITY gerado no ESCOPO do batch
-- @@IDENTITY: Retorno do último IDENTITY gerado em qualquer tabela
-----------------------------------------------------------------------
create table TBTeste10
(
	id smallint identity(199, -3) constraint pkTBTeste10 primary key
	, nome	varchar(15)
)

create trigger tgi  
on TBTeste09  
for insert as   
begin  
   insert TBTeste10 values ('')  
end 

select * from TBTeste09 order by id
select * from TBTeste10 order by id

insert TBTeste09 (nome) values ('Jennifer') 
select SCOPE_IDENTITY(), @@IDENTITY



-----------------------------------------------------------------------
-- SET IDENTITY_INSERT ON (restrito a manutenções)
-----------------------------------------------------------------------
select * from TBTeste09 order by id

set identity_insert TBTeste09 on 
	insert TBTeste09 (id, nome) values (146, 'Felipe') 
set identity_insert TBTeste09 off 

select * from TBTeste09 order by id
insert TBTeste09 (nome) values ('Bruna') 

-- 	drop table TBTeste09, TBTeste10
-----------------------------------------------------------------------





-----------------------------------------------------------------------
-- IDENTITY x SEQUENCE
-----------------------------------------------------------------------

if exists(select * from sys.tables where name = 'Motocicleta')
	drop table Motocicleta, Automovel
go

-- IDENTITY
create table Motocicleta
( 
  idMotocicleta smallint not null identity(1,1)
  , Placa char(7) not null
  , dtAluguel datetime not null
)

create table Automovel
( 
  idAutomovel smallint not null identity(1,1)
  , Placa char(7) not null
  , dtAluguel datetime not null
)

insert into Motocicleta (Placa, dtAluguel)
values ('BEE4R22', getdate()),
       ('BEF5FMI', getdate());

insert into Automovel (Placa, dtAluguel)
values ('XZZ9CCR', getdate()),
       ('WZF0CRF', getdate());

select * from Motocicleta
select * from Automovel


-- SEQUENCE
if exists(select * from sys.tables where name = 'Motocicleta')
	drop table Motocicleta, Automovel
go

create sequence dbo.idVeiculo as smallint
  start with 15
  increment by 3;
go

create table Motocicleta
( 
  idMotocicleta int not null constraint dfIdMotocicleta default (next value for dbo.idVeiculo)
  , Placa char(7) not null
  , dtAluguel datetime not null
)

create table Automovel
( 
  idAutomovel int not null constraint dfIdAutomovel default (next value for dbo.idVeiculo)
  , Placa char(7) not null
  , dtAluguel datetime not null
)

insert into Motocicleta (Placa, dtAluguel)
values ('BEE4R22', getdate()),
       ('BEF5FMI', getdate());

insert into Automovel (Placa, dtAluguel)
values ('XZZ9CCR', getdate()),
       ('WZF0CRF', getdate());

select * from Motocicleta
select * from Automovel
-------------------------------------------------------------------------


















---------------------------------------------------------------------------
-- COMPUTED COLUMN
---------------------------------------------------------------------------
/*
Coluna Computada é uma expressão de outras colunas da tabela.

A expressão pde ser uma coluna não computada, função ou qualquer combinação com um ou mais operadores.

A expressão não pode ser uma subquery.

Pode ser usada em cláusulas SELECT, WHERE e ORDER BY ou qualquer lugar onde expressões regulares possam ser usadas

Não podem ser alvos de declarações INSERT ou UPDATE  

Exemplo: Uma coluna de TOTAL pode ter sua definição como: Total as Qtd * Valor
*/



-- COMPUTED COLUMN
-- Exemplo 1
create table TBTeste03(c1 smallint, c2 smallint, Total as c1+c2)

sp_help TBTeste03

select * from sys.computed_columns 


insert TBTeste03 (c1, c2) values (1, 2), (15, 25), (30, 45)

select * from TBTeste03
select * from TBTeste03 where Total >= 40 order by Total desc


-- Exemplo 2
create table TBTeste04(c1 tinyint, c2 tinyint, c3 tinyint, Total as ((c1 + c2 ) * c3))

insert TBTeste04 (c1, c2, c3) values (20, 50, 6), (15, 25, 35), (30, 45, 21)

select c1, c2, c3 from TBTeste04
select * from TBTeste04 -- Total Arithmetic overflow error converting expression to data type tinyint.

-- Recriando
drop table TBTeste04
create table TBTeste04(c1 tinyint, c2 tinyint, c3 tinyint, Total as ((cast(c1 as smallint) + cast(c2 as smallint)) * cast(c3 as smallint)))

sp_help TBTeste04
select * from sys.computed_columns 

insert TBTeste04 (c1, c2, c3) values (20, 50, 6), (15, 25, 35), (30, 45, 21)
select * from TBTeste04
---------------------------------------------------------------------------

















---------------------------------------------------------------------------
-- TYPE
---------------------------------------------------------------------------
/*
É possível a criação de um tipo de dados ALIAS definido pelo usuário
Baseado em um tipo de dados nativo do SQL Server
Podemos criar outros tipos de dados por CLR (Common Language Runtime)
*/


-- 1. Criando TYPE
create type Moeda from decimal(9, 2) not null
go

-- Utilizando UDF TYPE
if exists(select * from sys.tables where name = 'TBTeste12')
	drop table TBTeste12
go

create table TBTeste12
(	
	id smallint identity(-32768, 1)
	, nome varchar (20)
	, valor Moeda
)

sp_help TBTeste12

insert TBTeste12 (nome, valor) values ('Mouse', 35.42)

select * from TBTeste12


-- Dropando TYPE
drop type Moeda 
drop table TBTeste12; drop type Moeda; 
---------------------------------------------------------------------------









---------------------------------------------------------------------------
-- VARIABLE TABLE
---------------------------------------------------------------------------
/*
Declaração de Variável com comportamento de tabela
Permite aplicação de constraints (PK, UQ, DF e CK) sem nomeação
Como qualquer variável, seu escopo é local ao batch
Só existe no momento RUNTIME
Localizada na memória, parcimônia na inserção de registros 
*/


declare  @TBTeste table (id tinyint identity, UF varchar(2) not null)
insert @TBTeste values ('SP'), ('RJ'), ('MG')
select * from @TBTeste

declare  @TBTeste table (id smallint identity(-32768, 1) primary key, nota varchar(100) unique)
insert @TBTeste values ('Apenas Teste de variable table em um batch')
insert @TBTeste values ('Apenas Teste de variable table em um batch')
select * from @TBTeste
---------------------------------------------------------------------------





---------------------------------------------------------------------------
-- TYPE e VARIABLE TABLE
---------------------------------------------------------------------------
/*
Podemos criar uma TYPE mais elaborada quando baseada em Variable Table
Permite que objeto possa ser passado como parâmetro de procedures
Favorece a padronização de códigos e/ou objetos do banco
*/

if exists (select * from sys.types where name = 'Moeda')
	drop type Moeda 
go
if exists (select * from sys.types where name = 'UF')
	drop type UF 
go

create type Moeda from decimal(9, 2) not null
go
create type UF from char(2) not null
go


-- Variavel Table com TYPE
declare  @TBTeste table 
(
	id smallint identity (32767, -1) primary key (id)
	, produto varchar(20) not null unique
	, estadoProdutor UF check (estadoProdutor in ('SP', 'RJ', 'MG'))
	, valor Moeda check (Valor between 10 and 1000)
	, dataCompra datetime default getdate()
)

insert @TBTeste (produto, estadoProdutor, valor) 
values ('Caderno', 'SP', 15.5)
select * from @TBTeste


-- TYPE como VARIABLE TABLE
if exists (select * from sys.types where name = 'PadraoProduto')
	drop type PadraoProduto 
go

create type PadraoProduto as table 
(
	id smallint identity (32767, -1) primary key (id)
	, produto varchar(20) not null unique
	, estadoProdutor UF check (estadoProdutor in ('SP', 'RJ', 'MG')) default ('SP') 
	, valor Moeda check (Valor between 10 and 1000)
	, dataCompra datetime default getdate()
)


-- Declarando Variável Table do TYPE criado
declare @TB PadraoProduto
insert @TB (produto, valor) values ('Caderno', 15.5)
select * from @TB
---------------------------------------------------------------------------

/*
– nroCliente (100 clientes, numérico de geração automática, primary key)
– nome (character até 60, unique)
– dataNascimento (data, domínio: 18 a 50 anos)
– cpf (11 caracteres fixos, obrigatório os 11 dígitos e entre 0 e 9)
– sexo (domínio textual: Masculino ou Feminino)
– estadoCivil (domínio: Solteiro (a), Casado (a) , Divorciado (a), 
			  Viúvo (a), – Default: Solteiro (a))
– nroFilhos (domínio: 0 a 20, Default: 0)
*/