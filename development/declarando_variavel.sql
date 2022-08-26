/*
- A variavel eh criada com a instrução DECLARE 

- Comeca com @. ex: @variavel

- Opcional, define um valor.

- Se nao definir valor, sera assumido NULL.

- Ela existira somente no contexto de execução do codigo ou do lote

- SET para atribuir valor a variavel
- SELECT para atribuir valor a variavel 
  - Declarando direto valor na variavel
  - Carregando os dados do resultado de uma consulta
*/

/**********************
- DECLARANDO VARIAVEIS
***********************/

-- Definindo uma única variavel
DECLARE @cNome VARCHAR(200)

-- Definindo varias varíaveis com um DECLARE
DECLARE @nSaldo INT, @nValor NUMERIC(10)

-- Definindo variavel do tipo XML
DECLARE @xPedidoExportar XML

-- Definindo variavel com valor DEFAULT
DECLARE @cNome2 VARCHAR(200) = 'Jose da Silva'

-- Definindo varias variaveis com valor DEFAULT com um DECLARE
DECLARE @nSaldo2 INT = 100,
	    @nValor2 NUMERIC(10) = 1500.0

GO

/******************************
- ATRIBUINDO VALOR A VARIAVEL
*******************************/

-- Atribuindo valor escalar(unico) direto no DECLARE
DECLARE @nome VARCHAR(200) = 'Jose da Silva'
SELECT @nome 
GO

-- Atribuindo valor escalar(unico) com SET
DECLARE @nome VARCHAR(200)
SET @nome = 'Jose da Silva'
PRINT @nome
GO

-- Atribuindo valor escalar(unico) com SELECT
DECLARE @nome VARCHAR(200)
SELECT @nome = 'Jose da Silva'
PRINT @nome
GO

/****************************************************
- ATRIBUINDO VALOR A PARTIR DE FUNÇÕES DO SQL SERVER
*****************************************************/
DECLARE @diaHoje DATETIME = GETDATE() -- Retorna a data e hora de hoje
PRINT @diaHoje
GO

DECLARE @diaHoje DATETIME
SET @diaHoje = GETDATE() -- Retorna a data e hora de hoje
SELECT @diaHoje
GO

DECLARE @nomeBanco SYSNAME
SET @nomeBanco = db_name() -- Retorna o nome do banco de dados
PRINT @nomeBanco
--SELECT @nomeBanco
GO