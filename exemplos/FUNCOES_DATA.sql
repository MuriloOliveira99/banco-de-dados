/*******************************************************************
		GETDATE()
		Retorna a data, hora, minutos, segundos e milissegundos
*********************************************************************/

-- 2022-04-23 11:38:54.603
SELECT GETDATE()

-- Pegando o apenas o ano do GETDATE()
-- 2022
SELECT YEAR(GETDATE()) AS 'ano'

-- Pegando o apenas o dia do GETDATE()
-- 23
SELECT DAY(GETDATE()) AS 'dia'

-- Pegando o apenas o m�s do GETDATE()
-- 04
SELECT MONTH(GETDATE()) AS 'mes'

-- Pegando o ano, dia, mes de uma data
SELECT YEAR('07/06/1999') AS 'ano' 
SELECT MONTH('07/06/1999') AS 'mes' 
SELECT DAY('07/06/1999') AS 'dia' 

/*******************************************************************
		      USANDO A FUN��O CONVERT() COM GETDATE()
Documenta��o: docs.microsoft.com/pt-br/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15#j-using-convert-with-datetime-data-in-different-formats
*********************************************************************/
--Tabela ANSI SQL

-- Retorna a data no formato d/m/yyyy
-- 23/04/2022
SELECT CONVERT(CHAR, GETDATE(), 103)

-- Retorna a data no formato yyyy.mm.dd
-- 2022.04.23
SELECT CONVERT(CHAR, GETDATE(), 102)

-- Retorna a data no formato mm/dd/aa
-- 04/23/22                      
SELECT CONVERT(CHAR, GETDATE(), 1)

-- Retorna a data no formato aa.mm.dd
-- 23.04.22                                           
SELECT CONVERT(CHAR, GETDATE(), 2)

-- Retorna a data no formato aa/mm/dd
-- 23/04/22                                           
SELECT CONVERT(CHAR, GETDATE(), 3) 
-- ENTRE OUTROS FORMATOS DISPON�VEIS NA TABELA ANSI SQL

/*******************************************************************
							 DATEPART()
					  RETORNA PARTE DE UMA DATA
					  RECEBE 2 PARAM�TROS
*********************************************************************/

-- Retorna o ANO do GETDATE()
SELECT DATEPART(YEAR, GETDATE()) AS 'ANO com DATEPART'

-- Retorna o M�S do GETDATE()
SELECT DATEPART(MONTH, GETDATE()) AS 'M�S com DATEPART'

-- Retorna o DIA do GETDATE()
SELECT DATEPART(DAY, GETDATE()) AS 'DIA com DATEPART'

-- Retorna o ANO, M�S, DIA de uma data espec�fica
SELECT DATEPART(YEAR, '07/06/1999') AS 'ANO com DATEPART'
SELECT DATEPART(MONTH, '07/06/1999') AS 'M�S com DATEPART'
SELECT DATEPART(DAY, '07/06/1999') AS 'DIA com DATEPART'


USE AC3_M3_consultorio
-- Retorna o ANO de uma coluna
-- DISTINCT para retornar os anos sem repeti��o
SELECT DISTINCT DATEPART(YEAR, dataHora) AS 'ANO' FROM Consulta 

-- Retorna o M�S de uma coluna
--DISTINCT para retornar os meses sem repeti��o
SELECT DATEPART(MONTH, dataHora) AS 'M�S' FROM Consulta

-- Retorna o DIA de uma coluna
-- DISTINCT para retornar os dias sem repeti��o
SELECT DATEPART(DAY, dataHora) AS 'DIA' FROM Consulta

/*******************************************************************
							  DATEADD()
					 ADICIONAR ALGO A MINHA DATA
*********************************************************************/

-- Subtrai 2 anos da data atual(DATETIME)
-- 2022-2 = 2020
SELECT DATEADD(YEAR, -2, GETDATE())

-- Subtrai 2 meses da data atual(DATETIME)
-- 4-2 = 2
SELECT DATEADD(MONTH, -2, GETDATE())

-- Subtrai 2 dias da data atual(DATETIME)
-- 23-2 = 21
SELECT DATEADD(DAY, -2, GETDATE())

-- Adiciona +5 anos da data atual(DATETIME)
-- 2022+5 = 2027
SELECT DATEADD(YEAR, 5, GETDATE())

-- Converte o (DATETIME) para o DATE sem as horas, minutos, segundos e milissegundos
SELECT CONVERT(DATE, DATEADD(DAY, -2, GETDATE())) 

-- Adiciona +3 horas da hora atual
SELECT DATEADD(hour, 3, GETDATE())

-- Retorna SMALLDATETIME(sem os milissegundos)
SELECT CONVERT(SMALLDATETIME, DATEADD(hour, 3, GETDATE()))

/*******************************************************************
							  DATEDIFF()
						DIFEREN�A ENTRE DATAS
*********************************************************************/
-- Retorna a diferen�a do meu ano atual (2022) com o de 2027
SELECT DATEDIFF(YEAR, GETDATE(), DATEADD(YEAR, 5, GETDATE())) AS 'MESES'

-- Retorna a diferen�a de meses do ano atual at� o ano de 2024
SELECT DATEDIFF(MONTH, GETDATE(), DATEADD(YEAR, 2, GETDATE())) AS 'ANOS'

-- Retorna a diferen�a de dias do ano atual at� o ano de 2025
SELECT DATEDIFF(DAY, GETDATE(), DATEADD(YEAR, 3, GETDATE()))

-- Retorna a quantidade de horas de vida
SELECT DATEDIFF(hour, '07/06/1999', GETDATE()) AS 'Horas de Vida'

-- Retorna a quantidade de minutos de vida
SELECT DATEDIFF(minute, '07/06/1999', GETDATE()) AS 'Minutos de Vida'

-- Retorna a quantidade de segundos de vida
SELECT DATEDIFF(second, '07/06/1999', GETDATE()) AS 'Segundos de Vida'
