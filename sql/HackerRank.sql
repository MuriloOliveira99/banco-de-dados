/********************************
-- EXERCICIOS SQL - HackerRank 
********************************/

/*
-- 1. Selecione todas as colunas de todas as cidades americanas na tabela CITY 
   com popula��es maiores que 100.000. O CountryCode para America eh USA.
*/
SELECT * 
FROM city
WHERE countryCode = 'USA'
AND [population] > 100000
GO

/*
-- 2. Selecione o campo NAME para todas as cidades americanas na tabela CITY 
   com popula��es maiores que 120.000. O CountryCode para a Am�rica eh USA.
*/
SELECT [name]
FROM city
WHERE countryCode = 'USA'
AND [population] > 120000
GO

/*
-- 3. Selecione uma lista de nomes de CIDADES de ESTACAO para cidades que tenham um n�mero de identifica��o par. 
   Imprima os resultados em qualquer ordem, mas exclua duplicatas da resposta.
*/
SELECT DISTINCT city 
FROM station 
WHERE (id % 2) = 0
GO

/*
-- 4. Encontre a diferen�a entre o n�mero total de entradas CITY na tabela e o n�mero de entradas CITY distintas na tabela.
*/
SELECT COUNT(city) - COUNT(DISTINCT city)
FROM station
GO

/*
-- 5. Consulte as duas cidades em STATION com os nomes de CITY mais curtos e mais longos, 
   bem como seus respectivos comprimentos (ou seja: n�mero de caracteres no nome). 
   Se houver mais de uma cidade menor ou maior, escolha a que vem primeiro quando ordenada alfabeticamente.
*/
SELECT TOP 1 city, LEN(city) FROM station ORDER BY len(city), city
GO
SELECT TOP 1 city ,LEN(city) FROM station ORDER BY len(city) DESC, city
GO

/*
-- 6. Consulte a lista de nomes de CIDADE come�ando com vogais (ou seja, a, e, i, o ou u) de STATION. 
   Seu resultado n�o pode conter duplicatas.
*/
SELECT DISTINCT city 
FROM city
WHERE city LIKE'[a, e, i, o, u]%'
GO

/*
-- 7. Consulte a lista de nomes de CIDADE terminando com vogais (ou seja, a, e, i, o ou u) de STATION. 
   Seu resultado n�o pode conter duplicatas.
*/
SELECT DISTINCT city 
FROM city
WHERE city LIKE '%[a, e, i, o, u]' -- not like
GO

/*
-- 8. Consultar o nome de qualquer aluno em ALUNOS que obteve pontua��o superior a 75 pontos. 
   Ordene sua sa�da pelos �ltimos tr�s caracteres de cada nome. Se dois ou mais alunos 
   tiverem nomes que terminam nos mesmos tr�s �ltimos caracteres (ou seja: Bobby, Robby, etc.), 
   classifique-os de forma secund�ria por ID crescente.
*/
SELECT [name] 
FROM students 
WHERE marks > 75
ORDER BY RIGHT([name], 3), id 
GO

/*
-- 9. Dadas as tabelas CITY e COUNTRY, consulte a soma das popula��es 
   de todas as cidades onde o CONTINENTE � '�sia'.
*/
SELECT SUM(ct.population)
FROM city AS ct
INNER JOIN country AS co
    ON ct.countryCode = co.code
WHERE co.continent = 'Asia'
GO

/*
-- 10. Dadas as tabelas CITY e COUNTRY, consulte os nomes de todas 
   as cidades onde o CONTINENTE � '�frica'.
*/
SELECT ct.[name]
FROM city AS ct
INNER JOIN country AS co
	ON ct.countryCode = co.code
WHERE co.continent = 'Africa'
GO

/*
-- 11. Dadas as tabelas CITY e COUNTRY, consulte os nomes de todos os continentes (COUNTRY.Continent) 
    e suas respectivas popula��es m�dias da cidade (CITY.Population) 
	arredondados para o n�mero inteiro mais pr�ximo.
*/
SELECT co.continent,
	   AVG(ct.population)
FROM city AS ct
INNER JOIN country AS co
	ON ct.countryCode = co.code
GROUP BY continent 
GO

/*
-- 12a. Consultar uma lista ordenada alfabeticamente de todos os nomes em OCUPA��ES, 
   imediatamente seguida pela primeira letra de cada profiss�o entre par�nteses
*/
SELECT CONCAT([name],'(', UPPER(LEFT(occupation, 1)), ')')
FROM Occupations 
ORDER BY [name]

-- Exibir There area a total of 2 doctors.
SELECT CONCAT('There are a total of ', COUNT(occupation), ' ', LOWER(Occupation), 's.')
FROM occupations
GROUP BY occupation
ORDER BY COUNT(occupation)
GO
