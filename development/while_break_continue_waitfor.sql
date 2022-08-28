/***************************
-- CONTROLE DE FLUXO: WHILE
****************************/

-- Loop de 1 at� 100
DECLARE @qtd TINYINT = 1 -- Vari�vel contadora

WHILE @qtd <= 100
BEGIN
	PRINT CONCAT('qtd: ', @qtd)
	SET @qtd += 1 --Incrementa 1 at� chegar no 100
END
GO

-- Quais n�meros de 1 a 100 s�o �mmpar ou par?
DECLARE @cont TINYINT = 1,
		@num TINYINT = 100

WHILE @cont < @num 
BEGIN
	IF @cont % 2 = 0
	BEGIN
		PRINT CONCAT(@cont, ' � par.')
	END
	ELSE
	BEGIN
		PRINT CONCAT(@cont, ' � impar.')
	END
	SET @cont+=1
END
GO

USE tempDB
GO

-- Percorrendo uma tabela
DECLARE @oid INT = -2147483648

WHILE EXISTS(SELECT * FROM tempdb.sys.tables WHERE object_id > @oid)
BEGIN
	SELECT @oid = MIN(object_id) FROM tempdb.sys.tables WHERE object_id > @oid 
	SELECT @oid, 'Tabela ' + object_name(@oid)
END
GO

/*******************************************************
-- CONTROLE DE FLUXO: WHILE com BREAK

-- S� � poss�vel utilizar BREAK dentro do WHILE
-- Faz com que pare o loop imediatamente e passe o fluxo 
-- para a linha ap�s o comando END.
*********************************************************/

DECLARE @qtd TINYINT = 1

WHILE @qtd <= 100
BEGIN
	PRINT CONCAT('QTD: ', @qtd)

	IF @qtd = 50
		BREAK

	SET @qtd += @qtd -- N�o vai entrar no IF, pois n�o aparecer� o n�m. 50
	-- SET @qtd+=1 -- Vai entrar no IF, pois aparecer� o n�m. 50.
END
GO

/***************************************************
-- CONTROLE DE FLUXO: WHILE com CONTINUE

-- S� � poss�vel utilizar CONTINUE dentro do WHILE
-- Faz com que volte a verificar a condi��o do WHILE 
-- seguindo o fluxo a partir dele.
****************************************************/

DECLARE @qtd TINYINT = 1

WHILE @qtd <= 100
BEGIN
	PRINT CONCAT('QTD: ', @qtd)
	
	IF @qtd = 8
		CONTINUE -- volta a verificar a condi��o do WHILE, tornando o la�o infinito.

	SET @qtd += @qtd
END
GO

/**********************************************************************************
-- CONTROLE DE FLUXO: WAITFOR

-- Bloqueia a execu��o de um lote, procedimento armazenado ou transa��o at� que
-- uma hora ou intervalo de tempo especificado seja alcan�ado ou que uma
-- instru��o especifica modifique ou retorne pelo menos uma linha.

== WAITFOR DELAY 'Tempo a esperar'
   -- WAITFOR DELAY '00:00:05'

== WAIT FOR TIME 'hor�rio que sair� do WAITFOR'
   -- WAITFOR TIME '17:15'
***********************************************************************************/

DECLARE @qtd TINYINT = 0,
		@msg VARCHAR(100),
		@dt1 DATETIME,
		@dt2 DATETIME

WHILE @qtd <= 100
BEGIN
	SET @qtd+=3
	SET @msg = CONCAT('O n�mero ', @qtd)
	SET @dt1 = GETDATE()

	--verificando se � par ou �mpar
	IF @qtd % 2 = 0
		SET @msg += ' � par!'
	ELSE
	BEGIN
		SELECT @msg += ' � �mpar!'
		WAITFOR DELAY '00:00:00.200'
	END

	SET @dt2 = GETDATE()
	SET @msg += ' Diferen�a em milisegundos '
				+ CAST(DATEDIFF(MILLISECOND, @dt1, @dt2) AS VARCHAR)

	PRINT @msg
END

-- Quando sair do loop, rotina CONTINUA
SET @msg = CONCAT('O n�mero ', @qtd, ' foi o limite que tornou a condi��o FALSE, ', 'for�ando a sa�da do WHILE')
PRINT @msg
GO
-- OUTPUT
-- O n�mero 3 � �mpar! Diferen�a em milisegundos 203
-- O n�mero 6 � par! Diferen�a em milisegundos 0