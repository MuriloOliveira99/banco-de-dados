USE AdventureWorks2017
GO
--  SELECT coluna(s) FROM tabela


SELECT * FROM person.person
GO

-- Select no título
SELECT title from person.Person GO

-- Select na tabela de email
SELECT * FROM person.EmailAddress 
GO

-- Select na tabela pessoa
SELECT * FROM person.person 
GO

-- Nome e Sobrenome das pessoas
SELECT FirstName, LastName FROM person.Person 
GO

-- DISTINCT -> Retorna somente dados únicos, omitindo os dados repetidos
SELECT DISTINCT FirstName FROM Person.Person 
GO

-- SELECT no LastName da tabela Pessoa
SELECT DISTINCT LastName FROM Person.Person 
GO

-- WHERE -> filtro de condição
-- Selecionando a pessoa que tem o primeiro nome 'anna' e o sobrenome 'miller'
SELECT * FROM person.Person WHERE FirstName = 'anna' AND LastName = 'miller' 
GO

-- SELECT na tabela de produtos
SELECT * FROM Production.Product
GO

-- SELECT onde a cor do produto é azul ou preto
SELECT * FROM Production.Product WHERE color = 'blue' or color = 'black'
GO

-- SELECT ONDE TODOS OS PRODUTOS CUSTAM MAIS DE 1500 E MENOS DE 1500
SELECT * FROM Production.Product WHERE ListPrice > 1500 AND ListPrice < 5000
GO

-- SELECT ONDE OS PRODUTOS SEJAM DIFERENTES DA COR VERMELHA
SELECT * FROM Production.Product WHERE color <> 'Red'
GO

-- DESAFIO 1: A equipe de produção de produtos precisa do nome 
-- de todas as peças que pesam mais de 500kg mas não mais que 700kg para inspeção
-- weight
SELECT * 
FROM Production.Product 
WHERE [Weight] > 500 AND [Weight] <= 700
GO

-- DESAFIO 2: Foi pedido pelo marketing uma relação de todos os empregados(employees)
-- que são casados (single=solteiro, married=casado) e são asalariados(salaried)
SELECT *
FROM HumanResources.Employee 
WHERE MaritalStatus = 'M' and SalariedFlag = 1
GO

-- DESAFIO 3: Um usuário chamado Peter Krebs está devendo um pagamento, consiga o email
-- dele para enviar uma cobrança!
-- BusinnesEntityId
-- Tabela person.person e tabela person.emailaddress
SELECT * 
FROM Person.Person 
WHERE FirstName = 'Peter' AND LastName = 'Krebs'
GO

SELECT * 
FROM Person.EmailAddress 
WHERE BusinessEntityID = 26
GO

-- ############### COUNT ###############
-- Retorna a quantidade de linhas 

-- COUNT -> Retorna a quantidade de linhas
SELECT COUNT(*) FROM Person.Person
GO

-- COUNT na tabela Title para ver quantas pessoas tem title diferentes
SELECT COUNT(DISTINCT title) 
FROM person.Person
GO
/*
	DESAFIO 1: 
	Quantos produtos temos cadastrados em nossa tabela
	de produtos (production.product)?
*/
SELECT * 
FROM Production.Product
GO

SELECT COUNT(*) 
FROM Production.Product
GO

/*
	DESAFIO 2:
	Quantos tamanhos de produtos temos cadastradoo
	em nossa tabela (production.product)?
*/
SELECT * FROM Production.Product
GO

SELECT COUNT(size) FROM Production.Product
GO

/*
	DESAFIO 3:
	Quantos tamanhos diferentes de produtos tem cadastrado
	na tabela produtos?
*/
SELECT COUNT(DISTINCT size) FROM Production.Product
GO

-- ############### TOP ###############
-- Retorna uma qtd especifica de dados 

SELECT TOP 10 * 
FROM Person.Person
GO
-- ############### ORDER BY - Ordena coluna em ordem cresc. ou desc. ###############
-- ASC = Crescente | DESC = Decrescente

SELECT * 
FROM Person.Person ORDER BY FirstName ASC, LastName DESC
Go

SELECT FirstName, LastName, MiddleName
FROM Person.Person 
ORDER BY MiddleName ASC
GO

/*
	DESAFIO 1:
	Obter o ProductId dos 10 produtos mais caros cadastrados
	no sistema, listando do mais caro para o mais barato
*/

SELECT * 
FROM Production.Product
GO

SELECT TOP 10 ProductID
FROM Production.Product
ORDER BY ListPrice DESC
GO

/*	
	DESAFIO 2:
	Obter o nome e número do produto dos produtos que tem o productID entre 1~4
*/
SELECT * FROM Production.Product
GO

SELECT TOP 4 [Name], ProductNumber 
FROM Production.Product ORDER BY ProductID ASC
GO

-- ############### BETWEEN ###############
-- Usado para encontrar valor entre um valor mínimo e um valor máximo 

-- Produtos que estão entre 1000 e 1500
SELECT * 
FROM Production.Product
WHERE ListPrice BETWEEN 1000 and 1500
GO

-- Produtos que não estão entre 1000 e 1500
SELECT * 
FROM Production.Product
WHERE ListPrice NOT BETWEEN 1000 and 1500
GO

-- Pessoas que foram contratadas entre o ano de 2009 e 2010
SELECT *
FROM HumanResources.Employee
WHERE HireDate BETWEEN '2009/01/01' AND '2010/12/31'
ORDER BY HireDate
GO

-- ############### IN ###############
-- IN é utilizado junto do WHERE para verificar se um valor correspondem 
-- com qualquer valor passado na lista de valores

SELECT * 
FROM person.Person
WHERE BusinessEntityID IN (2, 7, 13)
GO

-- ############### LIKE ###############
-- O operador LIKE é utilizado para buscar por uma determinada 
-- string dentro de um campo com valores textuais
/*
Sinal de porcentagem “%”: utilizado para indicar zero, um ou múltiplos 
caracteres antes ou depois do termo pesquisado;

Caractere de sublinhado “_” : usado para representar um único caractere antes ou após o termo procurado.

Palavra-chave ESCAPE: utilizada para que seja possível incluir os caracteres curingas (% e _ )
ao realizar uma busca.
*/

-- Nome começa com 'ovi%' e termina com qualquer coisa
SELECT * 
FROM person.Person
WHERE FirstName LIKE 'ovi%'
GO

-- Nome termina com '%to' e começa com qualquer coisa
SELECT * 
FROM person.Person
WHERE FirstName LIKE '%to'
GO

-- Nome onde no meio tenha '%essa%
SELECT * 
FROM person.Person
WHERE FirstName LIKE '%essa%'
GO

-- Retorna um caracter após '%ro_'
SELECT * 
FROM person.Person
WHERE FirstName LIKE '%ro_'
GO

/*
	DESAFIO 1: 
	Quantos produtos temos cadastrado no sistema
	que custam mais de 1500 dolares
*/

SELECT count(listprice)
FROM Production.Product
WHERE ListPrice > 1500
GO

/*
	DESAFIO 2:
	Quantas pessoas temos com o sobrenome que inicia com a letra P?
*/

SELECT * FROM person.Person
GO

SELECT COUNT(LastName)
FROM Person.Person
WHERE LastName LIKE 'p%'
GO

/*
	DESAFIO 3:
	Em quantas cidade únicas estão cadastrados nossos clientes?
*/
SELECT * FROM person.[Address]
GO

SELECT COUNT(DISTINCT City) 
FROM person.[Address]
GO

/*
	DESAFIO 4:
	Quais são as cidades únicas que estão cadastradas em nosso sistema?
*/
SELECT * FROM person.[Address]
GO

SELECT DISTINCT City 
FROM person.[Address]
GO

/*
	DESAFIO 5:
	Quantos produtos vermelhos tem preço entre 500 e 1000 dolares
*/

SELECT * FROM Production.Product;
GO

SELECT COUNT(*)
FROM Production.Product
WHERE Color = 'Red' 
AND ListPrice BETWEEN 500 and 1000
GO

/*
	DESAFIO 6:
	Quantos produtos cadastrados tem a palavra
	'road' no nome dele?
*/
SELECT * FROM Production.Product
GO

SELECT COUNT(*)
FROM Production.Product
WHERE [Name] LIKE '%road%'
GO

-- ############### MIN, MAX, SUM, AVG ###############

-- SUM() -> Retorna a soma de todos os valores de uma coluna
SELECT TOP 10 SUM(LineTotal) AS 'Soma da Coluna LineTotal'
FROM Sales.SalesOrderDetail 
GO

-- MIN() -> Retorna o menor valor de uma coluna
SELECT TOP 10 MIN(LineTotal) AS 'Menor valor da coluna LineTotal'
FROM Sales.SalesOrderDetail 
GO

-- MAX() -> Retorna o maior valor de uma coluna
SELECT TOP 10 MAX(LineTotal) AS 'Maior valor da coluna LineTotal'
FROM Sales.SalesOrderDetail 
GO

--AVG() -> Retorna a média de uma coluna
SELECT TOP 10 AVG(LineTotal) AS 'Média da coluna LineTotal'
FROM Sales.SalesOrderDetail 
GO

-- ############### GROUPBY ###############
-- basicamente divide o resultado da sua pesquisa em grupo
-- para cada grupo voce pode aplicar uma funcao de agregação
-- Calcular a soma de itens
-- contar o número de itens daquele grupo

SELECT *
FROM Sales.SalesOrderDetail
GO

SELECT SpecialOfferID, SUM(UnitPrice) AS "SOMA"
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
GO

-- Quantos produtos foram vendidos até hoje?
SELECT *
FROM Sales.SalesOrderDetail

SELECT ProductId, COUNT(ProductID) AS "CONTAGEM"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
GO

-- Quantos nomes de cada nome temos cadastrado
-- em nosso banco de dados?
SELECT FirstName, COUNT(FirstName) AS "CONTAGEM"
FROM Person.Person
GROUP BY FirstName ORDER BY CONTAGEM DESC
GO

-- A média de preço para os produtos pratas(silver)?
SELECT * 
FROM Production.Product 
GO

SELECT color, AVG(ListPrice) AS "Média Produtos Pratas" 
FROM Production.Product
WHERE Color = 'Silver'
GROUP BY Color
GO

/*
	DESAFIO 1:
	Preciso saber quantas pessoas tem o mesmo MiddleName 
	agrupadas pelo MiddleName
*/

SELECT * FROM Person.Person
GO

SELECT MiddleName, COUNT(MiddleName) AS "Numero de vs do Nome"
FROM Person.Person
GROUP BY MiddleName
ORDER BY COUNT(MiddleName) DESC
GO

/*
	DESAFIO 2:
	Em média qual é a quantidade que cada produto
	é vendido na loja
*/
SELECT * FROM sales.SalesOrderDetail
GO

SELECT ProductId, AVG(OrderQty) AS "Média"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
GO

-- ############### HAVING ###############
-- É usado junto com GROUP BY para 
-- filtrar resultado de um agrupamento
-- HAVING x WHERE
-- O GROUP BY é aplicado dps que os dados já foram agrupados
-- WHERE é aplicado antes dos dados serem agrupados

-- Quais nomes no sistema tem uma ocorrencia maior que 10 vezes?
SELECT FirstName, COUNT(FirstName) as "Quantidade"
FROM person.Person
GROUP BY FirstName
HAVING COUNT(FirstName) > 10
GO

-- Quais produtos que no total de vendase stão entre 162k a 500k
SELECT productID, SUM(Linetotal) AS "TOTAL"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(linetotal) BETWEEN 162000 AND 500000
GO

-- Quais nomes no sistema tem uma ocorrencia maior que 10 vezes,
-- porem somente onde o título é 'Mr.'
SELECT FirstName, COUNT(FirstName) as "Quantidade"
FROM person.Person
WHERE Title = 'Mr.'
GROUP BY FirstName
HAVING COUNT(FirstName) > 10
GO

/*
	DESAFIO 1:
	Estamos querendo identificar as provincias(stateProvinceId)
	com o maior número de cadastros no nosso sistema, então
	é preciso encontrar quais províncias(stateProvinceID)
	estão registradas no banco de dados mais que 1000 vezes
*/
SELECT COUNT(StateProvinceID) AS "Quantidade"
FROM person.[address]
GROUP BY StateProvinceID
HAVING COUNT(StateProvinceID) > 1000
GO

/*
	DESAFIO 2:
	Quais produtos(productID) não estão trazendo em média no minímo
	1 milhão em em total de vendas (lineTotal)
*/

SELECT * FROM Sales.SalesOrderDetail;

SELECT ProductID, AVG(LineTotal) AS "Média" --COUNT(LineTotal) AS "Quantidade"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(linetotal) < 1000000
GO

-- ############### AS ###############
-- Serve para renomear colunas

SELECT TOP 10 FirstName AS "Primeiro Nome",
	   LastName AS "Último Nome"
FROM Person.Person
GO

SELECT TOP 10 ProductNumber AS "Número do Produto"
FROM Production.product 
GO

SELECT TOP 10 unitPrice AS "Preço Unitário"
FROM sales.SalesOrderDetail
GO

-- ############### INNERJOIN ###############
-- INNER JOIN, OUTER JOIN E SELF-JOIN

SELECT TOP 10 *
FROM person.Person
GO

SELECT TOP 10 *
FROM person.EmailAddress
GO

-- INNERJOIN Pessoa e Email
SELECT p.BusinessEntityID,
	   p.FirstName,
	   p.LastName,
	   pe.EmailAddress 
FROM Person.Person as P
INNER JOIN Person.EmailAddress AS PE 
ON p.BusinessEntityID = pe.BusinessEntityID
GO

-- Nomes dos produtos e as informações de suas subcategorias
SELECT * FROM Production.Product
SELECT * FROM Production.ProductSubcategory
GO

SELECT pr.ListPrice, 
	   pr.[Name],
	   psc.[Name]
FROM Production.Product AS pr
INNER JOIN Production.ProductSubcategory AS psc
ON pr.ProductSubcategoryID = psc.ProductSubcategoryID
GO

-- Juntando todas as colunas da tabela
-- BusinessEntityAddress
-- Address
SELECT TOP 10 * 
FROM Person.BusinessEntityAddress
GO

SELECT TOP 10 *
FROM Person.[Address]
GO

SELECT TOP 10 *
FROM Person.BusinessEntityAddress AS ba
INNER JOIN Person.[Address] AS pa
ON ba.AddressID = pa.AddressID
GO
/*
	DESAFIO 1:
	INNER JOIN nas tabelas person.PhoneNumberType e person.PersonPhone
	BusinessEntityID, Name, PhoneNumberTypeID, PhoneNumber
*/
SELECT TOP 10 * FROM person.PersonPhone
SELECT TOP 10 * FROM person.PhoneNumberType 
GO

SELECT pp.BusinessEntityID,
	   pn.[Name],
	   pn.PhoneNumberTypeID,
	   pp.PhoneNumber
FROM person.PersonPhone AS pp
INNER JOIN person.PhoneNumberType AS pn
ON pp.PhoneNumberTypeID = pn.PhoneNumberTypeID	   
GO
/*
	DESAFIO 2:
	INNER JOIN nas tabelas person.stateprovince, person.address
	AddressId, City, StateProvinceId, nome do estado
*/

SELECT TOP 10 *
FROM person.StateProvince
GO

SELECT TOP 10 *
FROM person.[Address]
GO

SELECT TOP 10 
	   pa.AddressID,
	   pa.City,
	   ps.StateProvinceID,
	   ps.[Name]
FROM person.[Address] AS pa
INNER JOIN person.StateProvince AS ps
ON pa.StateProvinceID = ps.StateProvinceID

-- ############### LEFT JOIN ###############

/* Quais pessoas tem um cartão de credito registrado? */
-- 
SELECT *
FROM Person.Person as PP
LEFT JOIN Sales.PersonCreditCard as PC
ON PP.BusinessEntityID = PC.BusinessEntityID
WHERE PC.BusinessEntityID IS NULL
-- INNER JOIN: 19.118 Linhas
-- LEFT JOIN: 19972


-- ############### SELF JOIN ###############
--SELECT NOME_COLUNA 
--FROM TABELA_A, TABELA_B(APELIDO)
--WHERE CONDICAO 

/* Todos os clientes que moram na mesma região */
USE Northwind
SELECT A.ContactName, A.Region, B.Region, B.ContactName
FROM Customers A, Customers B
WHERE A.Region = B.Region

/* Encontrar nome e data de contratacao de todos 
   os funcionários que foram contratados no mesmo ano
*/

SELECT * FROM Employees

SELECT EMP1.FirstName, 
	   EMP1.LastName, 
	   EMP1.HireDate,
	   EMP2.HireDate
FROM Employees AS EMP1, Employees AS EMP2
WHERE DATEPART(YEAR, EMP1.HireDate) = DATEPART(YEAR, EMP2.HireDate) 
--WHERE YEAR(EMP1.HireDate) = YEAR(EMP2.HireDate)

/* DESAFIOS */

/*
	Quais produtos tem o mesmo percentual de desconto.(OrderDetails)
*/
SELECT odA.ProductID AS 'Produto - Tabela A',
	   odA.Discount AS 'Desconto - Tabela A'
	   --odB.ProductID AS 'Produto - Tabeal B',
	   --odB.Discount AS 'Desconto - Tabeala B'
FROM [Order Details] AS odA, 
	 [Order Details] AS odB
WHERE odA.Discount = odB.Discount



/*
	
*/


/*
	
*/

