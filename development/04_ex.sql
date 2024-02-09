-- TIPOS DE DADOS: https://www.sqlservertutorial.net/sql-server-basics/sql-server-data-types/


/************************************************************************************************************************
-- 1. Criar variáveis saldoInicial e saldoTotal, numéricas, de 2 bytes e com valores iniciais respectivamente 100 e 200.
*************************************************************************************************************************/
DECLARE @saldoInicial SMALLINT = 100,
		@saldoTotal SMALLINT = 200


/****************************************************************************************************************
-- 2. Criar variáveis dtAtual e dtFutura, de 3 bytes e armazenar com valores iniciais em 19-06-2015 e 25-08-2015.
*****************************************************************************************************************/
DECLARE @dtAtual DATE = '20150619',
		@dtFutura DATE = '20150825'


/****************************************************************************************************************
-- 3. Utilizando funções built-in, adicone ao saldoInicial a diferença em dias obtidas entre as datas anteriores.
*****************************************************************************************************************/
SET @saldoInicial = ABS(DATEDIFF(DAY, @dtAtual, @dtFutura))
SELECT @saldoInicial AS [Saldo Inicial]


/***********************************************************************************************************
-- 4. Da mesma forma que a instrução anterior, multiplique saldoTotal pela diferença em meses destas datas.
************************************************************************************************************/
SET @saldoTotal *= DATEDIFF(MONTH, @dtAtual, @dtFutura) 
SELECT @saldoTotal AS [Saldo Total]


/***********************************************************************************************
-- 5. Faça um controle de fluxo verificando se o saldoInicial é maior ou igual ao saldoTotal,
	  Se TRUE:
	  1. Escreva (SELECT) a seguinte mensagem:
		"Seu saldo em "+ dtAtual + espaço(1) + " é de" + saldoinicial + "."
	  2. Faça com que a dtAtual seja somada em 21 dias

-- 6. Se FALSE, escreva:
      "Seu saldo em "+dtFutura + espaço(1) + "é de " + saldoInicial + "."
*************************************************************************************************/
IF @saldoInicial >= @saldoTotal
BEGIN
	--SET @dtAtual = DATEADD(DAY, 21, @dtAtual)
	SELECT CONCAT('Seu Saldo em ', DATEADD(DAY, 21, @dtAtual), SPACE(1), 'é de ', @saldoInicial, '.') AS [Saldo]
END
ELSE
	SELECT CONCAT('Seu Saldo em ', @dtFutura, SPACE(1), 'é de ', @saldoTotal, '.') AS [Saldo]


/*******************************************************************************
-- 7. Gere a saída de todas as variáveis em uma unica linha, colocando um ALIAS 
      em cada coluna de forma que saibamos o que cada coluna representa
********************************************************************************/
SELECT @saldoInicial AS [Saldo Inicial],
	   @saldoTotal AS [Saldo Total],
	   CONVERT(CHAR, @dtAtual, 103) AS [Data Atual],
	   CONVERT(CHAR, @dtFutura, 103) AS [Data Futura]


/*******************************************************************************************
-- 8. Através de comandos ad hoc, descubra as quantidade de registros das seguintes tabelas
	  no banco de dados Temp: sys.objetcs, sys.tables, sys.columns
   -- Examine também o conteúdo da tabela sys.columns
********************************************************************************************/

-- Verificando a quantidade de registros da tabela sys.objects
SELECT COUNT(*) AS [Qtd. Registros sys.objects] FROM sys.objects 
SELECT * FROM sys.objects

-- Verificando a quantidade de registros da tabela sys.tables
SELECT COUNT(*) AS [Qtd. Registros sys.tables] FROM sys.tables
SELECT * FROM sys.tables

-- Verificando a quantidade de registros da tabela sys.columns
SELECT COUNT(*) AS [Qtd. Registros sys.columns]
SELECT * FROM sys.columns


/************************************************************************************************
-- 9. A partir da investigação anterior, crie um script com as seguintes características

   -- 1. Criar variáveis com os menores tipos de dados possíveis que armazenem:
       - a. As quantidades de dados das tabelas mencionadas.
       - b. Os Maiores e Menores valores dos seguintes campos da tabela sys.columns: Object_id,
	        name, system_type_id, user_type_id, is_nullable
	   - c. A média (com 2 casas decimais) do campo column_id da tabela sys.columns
*************************************************************************************************/
DECLARE @qtd_registros_objects TINYINT, 
	    @qtd_registros_tables  TINYINT, 
		@qtd_registros_columns SMALLINT,
		@maior_object_id       INT,
        @menor_object_id       INT,
		@maior_columns_name    VARCHAR(100),
        @menor_columns_name    VARCHAR(100), 
		@maior_system_type_id  TINYINT,
        @menor_system_type_id  TINYINT, 
		@maior_user_type_id    SMALLINT,
        @menor_user_type_id    SMALLINT, 
		@maior_is_nullable     BIT,
        @menor_is_nullable     BIT,  
		@media_column_id       DECIMAL(9,2)


-- SETANDO VALORES NAS VARIÁVEIS
SELECT	@qtd_registros_objects = COUNT(*) FROM sys.objects
SELECT	@qtd_registros_tables  = COUNT(*) FROM sys.tables
SELECT	@qtd_registros_columns = COUNT(*), 
		@maior_object_id       = MAX(Object_id), 
		@menor_object_id       = MIN(object_id), 
		@maior_columns_name    = (SELECT TOP 1 name FROM sys.columns ORDER BY LEN(name) DESC),
        @menor_columns_name    = (SELECT TOP 1 name FROM sys.columns ORDER BY LEN(name) ASC),
		@maior_system_type_id  = MAX(system_type_id), 
		@menor_system_type_id  = MIN(system_type_id), 
		@maior_user_type_id    = MAX(user_type_id),
		@menor_user_type_id    = MIN(user_type_id), 
		@maior_is_nullable     = MAX(CONVERT(TINYINT, is_nullable)), 
		@menor_is_nullable     = MIN(CONVERT(TINYINT, is_nullable)),
		@media_column_id       = AVG(column_id)		
FROM sys.columns

-- EXIBINDO OS VALORES
SELECT @qtd_registros_objects AS [qtd_registros_objects], 
	   @qtd_registros_tables  AS [qtd_registros_tables], 
	   @qtd_registros_columns AS [qtd_registros_columns],
	   @maior_object_id       AS [maior_object_id],
       @menor_object_id       AS [menor_object_id], 
	   @maior_columns_name    AS [maior_columns_name], 
       @menor_columns_name    AS [menor_columns_name],
	   @maior_system_type_id  AS [maior_system_type_id],
       @menor_system_type_id  AS [menor_system_type_id], 
	   @maior_user_type_id    AS [maior_user_type_id],
       @menor_user_type_id    AS [menor_user_type_id],
	   @maior_is_nullable     AS [maior_is_nullable],  
       @menor_is_nullable     AS [menor_is_nullable], 
	   @media_column_id       AS [media_column_id]

/**************************************************************************************************
-- 10. Após o armazenamento, construa o seguinte controle de fluxo:

    a. Caso o menor valor de system_type_id for menor ou igual ao menor valor de user_type_id,
       escreva um texto que mostre isso. Em seguida some 10 unidades em cada uma destas variáveis.
    b. Senão, escreva um texto que mostre que são divergentes.

    c. Caso o menor valor de object_id seja negativo, desvie o fluxo para um rótulo chamado
	   DESVIO_DE_FLUXO, nas últimas linhas do script. No rótulo mencionado gere um SELECT que
	   descreva este desvio, qual a variável e o valor responsável pelo desvio.
    d. Senão, verifique se os maiores valores em system_type_id e user_type_id são diferentes. Se
	   forem, escreva um texto que descreva isso, mostrando os 2 valores.

	e. Force o término do script antes de chegar no rótulo DESVIO_DE_FLUXO.(RETURN)
****************************************************************************************************/

-- a
IF @menor_system_type_id < @menor_user_type_id
BEGIN
	SELECT CONCAT(@menor_system_type_id, SPACE(1), 'menor que', SPACE(1), @menor_user_type_id, '.')
	SET @menor_system_type_id += 10
	SET @menor_user_type_id += 10
END

-- a
ELSE IF @menor_system_type_id = @menor_user_type_id
BEGIN
	SELECT CONCAT(@menor_system_type_id, SPACE(1), 'é igual a', SPACE(1), @menor_user_type_id, '.')
	SET @menor_system_type_id += 10
	SET @menor_user_type_id += 10
	
END
-- b
ELSE
	SELECT CONCAT(@menor_system_type_id, SPACE(1), 'é maior que', SPACE(1), @menor_user_type_id, '.')
-- c
IF @menor_object_id < 0
	GOTO DESVIO_FLUXO
ELSE IF @maior_system_type_id <> @maior_user_type_id
	SELECT CONCAT(@maior_system_type_id, ' é diferente de ', @maior_user_type_id)
-- d
RETURN

DESVIO_FLUXO:
	SELECT 'DESVIO DE FLUXO: O menor valor do object_id é negativo. ' 
