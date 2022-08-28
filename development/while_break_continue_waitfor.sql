/***************************
-- CONTROLE DE FLUXO: WHILE
****************************/

-- Loop de 1 até 100
DECLARE @qtd TINYINT = 1 -- Variável contadora

WHILE @qtd <= 100
BEGIN
	PRINT CONCAT('qtd: ', @qtd)
	SET @qtd += 1 --Incrementa 1 até chegar no 100
END
GO

-- Quais números de 1 a 100 são ímmpar ou par?
DECLARE @cont TINYINT = 1,
		@num TINYINT = 100

WHILE @cont < @num 
BEGIN
	IF @cont % 2 = 0
	BEGIN
		PRINT CONCAT(@cont, ' é par.')
	END
	ELSE
	BEGIN
		PRINT CONCAT(@cont, ' é impar.')
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

-- Só é possível utilizar BREAK dentro do WHILE
-- Faz com que pare o loop imediatamente e passe o fluxo 
-- para a linha após o comando END.
*********************************************************/

DECLARE @qtd TINYINT = 1

WHILE @qtd <= 100
BEGIN
	PRINT CONCAT('QTD: ', @qtd)

	IF @qtd = 50
		BREAK

	SET @qtd += @qtd -- Não vai entrar no IF, pois não aparecerá o núm. 50
	-- SET @qtd+=1 -- Vai entrar no IF, pois aparecerá o núm. 50.
END
GO

/***************************************************
-- CONTROLE DE FLUXO: WHILE com CONTINUE

-- Só é possível utilizar CONTINUE dentro do WHILE
-- Faz com que volte a verificar a condição do WHILE 
-- seguindo o fluxo a partir dele.
****************************************************/

DECLARE @qtd TINYINT = 1

WHILE @qtd <= 100
BEGIN
	PRINT CONCAT('QTD: ', @qtd)
	
	IF @qtd = 8
		CONTINUE -- volta a verificar a condição do WHILE, tornando o laço infinito.

	SET @qtd += @qtd
END
GO

/**********************************************************************************
-- CONTROLE DE FLUXO: WAITFOR

-- Bloqueia a execução de um lote, procedimento armazenado ou transação até que
-- uma hora ou intervalo de tempo especificado seja alcançado ou que uma
-- instrução especifica modifique ou retorne pelo menos uma linha.

== WAITFOR DELAY 'Tempo a esperar'
   -- WAITFOR DELAY '00:00:05'

== WAIT FOR TIME 'horário que sairá do WAITFOR'
   -- WAITFOR TIME '17:15'
***********************************************************************************/

DECLARE @qtd TINYINT = 0,
		@msg VARCHAR(100),
		@dt1 DATETIME,
		@dt2 DATETIME

WHILE @qtd <= 100
BEGIN
	SET @qtd+=3
	SET @msg = CONCAT('O número ', @qtd)
	SET @dt1 = GETDATE()

	--verificando se é par ou ímpar
	IF @qtd % 2 = 0
		SET @msg += ' é par!'
	ELSE
	BEGIN
		SELECT @msg += ' é ímpar!'
		WAITFOR DELAY '00:00:00.200'
	END

	SET @dt2 = GETDATE()
	SET @msg += ' Diferença em milisegundos '
				+ CAST(DATEDIFF(MILLISECOND, @dt1, @dt2) AS VARCHAR)

	PRINT @msg
END

-- Quando sair do loop, rotina CONTINUA
SET @msg = CONCAT('O número ', @qtd, ' foi o limite que tornou a condição FALSE, ', 'forçando a saída do WHILE')
PRINT @msg
GO
-- OUTPUT
-- O número 3 é ímpar! Diferença em milisegundos 203
-- O número 6 é par! Diferença em milisegundos 0