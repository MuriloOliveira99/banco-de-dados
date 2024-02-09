SELECT * FROM 
/***************
-- EXERCICIOS
***************/

/*
-- Faça um SELECT cujo algoritmo traga o 1o. e último dia do mês
atual ?
*/
SELECT DATEADD(DAY, 1, EOMONTH(GETDATE(), -1)) AS [Primeiro dia do mês],
       EOMONTH(GETDATE()) AS [Último dia do mês]
GO

/*
- Faça um SELECT que retorne apenas a data de ontem, sem hora,
minuto, segundo ou milissegundo.
*/
SELECT CONVERT(DATE, DATEADD(DAY, -1, GETDATE())) 
GO

/*
- Faça um SELECT que retorne a data de ontem juntamente com a
última hora, minuto, segundo e milissegundo.
*/
SELECT DATEADD(DAY, -1, CAST(GETDATE() AS DATETIME))--************
GO

/********************************************************************************
-- 1. DESENVOLVA T-SQL QUE RESOLVA COM PRECISÃO DE NÚMEROS DECIMAIS OS CÁLCULOS
ABAIXO:
********************************************************************************/
-- a. 456/14
DECLARE @dividendo INT = 456,
		@divisor INT = 5

SELECT cast(@dividendo AS FLOAT) / cast(@divisor AS FLOAT)
-- SELECT cast(456 AS FLOAT) / cast(5 AS FLOAT) 
GO

-- b. 782,23 x 82,07
SELECT CAST(CAST(replace('782,23', ',', '.') AS NUMERIC(7,2)) * CAST(replace('82,07', ',', '.') AS NUMERIC(7,2)) AS NUMERIC(7, 2))
GO

-- c. 5^2 + 3^3
SELECT CAST(POWER(5, 2) AS NUMERIC(4, 2)) + CAST(POWER(3, 3) AS NUMERIC(4, 2))
GO

-- d. Raiz Quadrada de 25
SELECT CAST(SQRT(125) AS NUMERIC(4, 2))
GO

-- e. (((42 + 18) / (54 / 9) - 2) / 4) - 2
SELECT (((42 + 18) / (54 / 9) - 2) / 4) - 2
GO

/********************************************************************************
-- 2. ATRAVÉS DE FUNÇÕES BUILT-IN OU T-SQL, REALIZE AS OPERAÇÕES ABAIXO:
*********************************************************************************/

-- a. “Maria” e 5 espaços e “Antônia”
SELECT CONCAT('Maria', SPACE(5), 'Antônia')
GO

-- b. Trocar a letra “a” por “e” na palavra “Tarara”
SELECT REPLACE('Tarara', 'a', 'e')
GO

-- c. Recuperar as 3 primeiras letras do texto “Mongaguá”
SELECT LEFT('Mongaguá', 3)
GO

--SELECT SUBSTRING('Mongaguá', 0, 4)

-- d. Recuperar do caracter 6 ao 9 da palavra “Paralelepípido”
SELECT SUBSTRING('Paralelepípido', 6, 9)
GO

-- e. Recuperar as 2 últimas letras de “Inverno”
SELECT RIGHT('Inverno', 2)
GO

/*******************************************************************************************
-- 3. Com a tabela DEVDB criada com os nomes de alunos, gere um ÚNICO SELECT
	  que retorne apenas o Nome e o Sobrenome de TODOS alunos. No Result Set,
	  o Nome do aluno deverá ter a 1a letra maiúscula, já o Sobrenome deve estar
	  totalmente em maiúsculas. O nome da coluna deverá ser apelidada de Nome e Sobrenome.

	  Saída: Abilio SOARES
			 Beatriz RIBEIRO
			 José SILVA
			 Marcela ALVES
********************************************************************************************/

CREATE DATABASE ex3
GO

USE ex3 
GO

CREATE TABLE DEVDB(
	id INT NOT NULL IDENTITY(1, 1),
	nome VARCHAR(100) NOT NULL
)
GO

INSERT INTO DEVDB
VALUES('abílio soares dos santos'), 
	  ('beatriz ribeiro'), 
	  ('JOSÉ ANDRADE SILVA'), 
	  ('MARCELA J. ALVES')
GO

SELECT * FROM DEVDB
GO

/*
Saída: 
Abilio SOARES DOS SANTOS
Beatriz RIBEIRO
José SILVA
Marcela ALVES

*/

SELECT CONCAT(UPPER(SUBSTRING(nome, 1, 1)), SUBSTRING(LOWER(nome), 2, CHARINDEX(' ', nome)-1), UPPER(SUBSTRING(nome, CHARINDEX(' ', nome)+1, 100)))
FROM DEVDB
GO

/***************************************************************************************
-- 4. Em T-SQL, declare as variáveis, obrigatoriamente com os menores tipos
	  possíveis que comportem o valor inicial e final, execute alguma operação para
      obter o valor final solicitado.

	  Variavel    Valor Inicial    Valor Final
	  --------    -------------    -----------
	  mes		  5				   12
	  ano		  2013			   2100
	  graus		  -10			   32
	  id		  5				   60.000
	  placa       XPT-9563		   XPT-9245
	  modelo      Cruze			   Cruze LS
	  endereco	  Av. Brasil	   Av. Juscelino Kubitschek, 1000
*****************************************************************************************/

DECLARE @mes       TINYINT = 5,		
		@ano       SMALLINT = 2013,
		@graus     SMALLINT = -10,
		@id        INT = 5,
		@placa     CHAR(8) = 'XPT-9563',     
		@modelo    VARCHAR(8) = 'Cruze',          
		@endereco  VARCHAR(30) = 'Av. Brasil'      

SET @mes = 12
SET @ano = 2100   
SET @graus = 32 
SET @id = 60000  
SET @placa = 'XPT-9245'   
SET @modelo = 'Cruze LS'    
SET @endereco = 'Av. Juscelino Kubitschek, 1000'


/********************************************************************************
5. Com os valores finais do exercício anterior e ainda em variáveis, faça as
transformações solicitadas, se atentando a cálculos numéricos que devem ter
o número de casas decimais apropriado:
**********************************************************************************/

-- a. Id / Ano
SELECT @id  / CAST(@ano AS INT) AS [ID / Ano]

-- b. Palavra “Mês” e 1 espaço e variável Mes
SELECT CONCAT('Mês', SPACE(1), @mes) AS [Palavra 'Mês' e 1 espaço e variável Mes]

-- c. Ano e texto “ Mongaguá”
SELECT CONCAT(@ano, space(1), 'Mongaguá') AS [Ano e texto 'Mongaguá']

-- d. (id / graus) – (Ano * Mês)
SELECT (@id / CAST(@graus AS SMALLINT)) - (CAST(@ano AS INT) * @mes) AS [(id / graus) – (Ano * Mês)]

-- e. Modelo, hífen e placa
SELECT CONCAT(@modelo, ' - ', @placa)

-- f. Substituir o número atual no endereço e colocar os 4 últimos dígitos da placa
SELECT REPLACE(@endereco, '1000', SUBSTRING(@placa, CHARINDEX('-', @placa)+1, 4))

/*******************************************************************************
6. Você terá que deixar o script abaixo pronto para ser executado
   automaticamente através de um job. Faça as alterações suficientes para que
   seja executado de uma única vez (F5) e totalmente sem erros:
*******************************************************************************/

USE ex3

CREATE TABLE Teste_mo(
	id TINYINT PRIMARY KEY, nome VARCHAR(20)
);

INSERT Teste_mo VALUES (1, 'Ana'), (2, 'Marcelo'), (3, 'Fábio'), (4, 'Paula');

CREATE VIEW vwTeste_mo
AS
SELECT nome FROM Teste_mo;

SELECT * FROM vwTeste_mo;