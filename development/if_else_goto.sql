/*************************************************** 
-- EXEMPLO 1
***************************************************/

-- Declarando as variaveis
DECLARE @numero INT,
	    @texto VARCHAR(10)

-- Setando valor para as variaveis
SET @numero = 20
SET @texto = 'Murilo'

IF @numero = 20 
	SELECT 'Numero correto!!!'

-- Quando ouver mais de uma instrucao no if/else.
-- utilizar BEGIN/END para agrupar os comandos
IF @texto = 'Murilo'
	BEGIN 
		SET @numero = 30
		SELECT @numero
	END
ELSE
	BEGIN
		SET @numero = 40
		SELECT 'Numero incorreto!'
	END
GO

/***************************************************
-- EXEMPLO 2 - com tabelas do banco
***************************************************/

-- Criação do banco para testes
CREATE DATABASE escola
go

drop table tbl_alunos
go

CREATE TABLE tbl_alunos (
	id INT NOT NULL IDENTITY(1, 1),
	nome_aluno VARCHAR(30),
	nota1 NUMERIC(4, 2),
	nota2 NUMERIC(4, 2),
	nota3 NUMERIC(4, 2),
	nota4 NUMERIC(4, 2),
	CONSTRAINT PK_Aluno PRIMARY KEY(id)
)
GO

-- inserindo dados na tabela 'tbl_alunos'
INSERT INTO tbl_alunos(nome_aluno, nota1, nota2, nota3, nota4)
VALUES ('Murilo', 10.0, 10.0, 10.0, 9.0),
	   ('Joao', 4.0, 4.0, 3.0, 6.0),
	   ('Maria', 8.5, 4.5, 5.0, 9.0),
	   ('Marcos', 10.0, 10.0, 8.0, 7.0)
GO

-- Declarando as variaveis
DECLARE @nome VARCHAR(30),
		@media NUMERIC(3, 2),
		@resultado VARCHAR(10)
SELECT 
	@nome = nome_aluno,
	@media = (nota1 + nota2 + nota3 + nota4) / 4.0
FROM tbl_alunos
WHERE nome_aluno = 'Joao'
	IF @media >=7.0
		BEGIN
			SELECT @resultado = 'APROVADO'	
		END
	ELSE
		BEGIN
			SELECT @resultado = 'REPROVADO'
		END
	SELECT CONCAT('O aluno ', @nome, ' esta ', @resultado, ' com media ', CAST(@media AS VARCHAR))
GO

/***************************************************
-- EXEMPLO 3 - Verificando se o numero eh par/impar
****************************************************/
DECLARE @num TINYINT = 6

IF @num % 2 = 0
	BEGIN
		SELECT CONCAT('O numero ', CAST(@num AS VARCHAR), ' é par.')
	END
ELSE
	BEGIN
		SELECT CONCAT('O numero ', CAST(@num AS VARCHAR), ' é impar.')
	END
GO

/***************************************************
-- EXEMPLO 3 - Bom dia/Boa tarde/Boa noite
****************************************************/
--SELECT CONCAT(DATEPART(hour, GETDATE()), DATEPART(minute, GETDATE()))
DECLARE @hora_atual VARCHAR(5)
SET @hora_atual = FORMAT(GETDATE(),'hh')
--SELECT @hora_atual

IF @hora_atual > 5 AND @hora_atual < 12
	BEGIN
		SELECT CONCAT('Bom dia! ', 'Agora são exatamente ', CAST(FORMAT(GETDATE(), 'hh:mm:ss') AS VARCHAR))
	END
ELSE IF @hora_atual > 11 AND @hora_atual < 18
	BEGIN
		SELECT CONCAT('Bom tarde! ', 'Agora são exatamente ', CAST(FORMAT(GETDATE(), 'hh:mm:ss') AS VARCHAR))
	END
ELSE 
	BEGIN
		SELECT CONCAT('Bom noite! ', 'Agora são exatamente ', CAST(FORMAT(GETDATE(), 'hh:mm:ss') AS VARCHAR))
	END
GO

