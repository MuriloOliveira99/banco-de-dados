USE AdventureWorks2017
GO

/* Produtos Black ou Blue */

-- Usando WHERE
SELECT * 
FROM Production.Product
WHERE color = 'Black' OR
	  color = 'Blue'
GO

-- Usando IN
SELECT * 
FROM Production.Product
WHERE color IN ('Black', 'Blue')
GO

/* Quantos produtos temos cadastrados em nossa tabela de produtos (product) */
SELECT COUNT([Name]) AS [Qtd. Produtos] 
FROM Production.Product
GO

/* Quantos tamanhos de produtos temos cadastrados em nossa tabela (product) */
SELECT COUNT(size) AS [Qtd. Tamanho Produtos]
FROM Production.Product
GO

/* Quantos tamanhos diferentes de produtos temos cadastrados em nossa tabela */
SELECT COUNT(distinct(size)) AS [Qtd. Tamanho Produtos]
FROM Production.Product
GO

/* Os 10 primeiros produtos */
SELECT TOP 10 *
FROM Production.Product
ORDER BY ProductID ASC
GO

/* Todos produtos entre 1000 e 1500 */
SELECT *
FROM Production.Product
WHERE ListPrice BETWEEN 1000 AND 1500
GO

/* Nome das pessoas que terminam com TO */
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%to'  -- Termina com TO
-- WHERE FirstName LIKE 'to%'  -- Começa com TO
-- WHERE FirstName LIKE '%to%' -- Meio tem TO
GO

/* Total de todas as vendas */
SELECT SUM(LineTotal) AS [Total de Vendas]
FROM Sales.SalesOrderDetail
GO

/* Menor valor do total de vendas */
SELECT MIN(LineTotal) AS [Menor valor]
FROM sales.SalesOrderDetail
GO

/* Maior valor do total de vendas */
SELECT MAX(LineTotal) AS [Maior valor]
FROM sales.SalesOrderDetail
GO

/* Média valor total de vendas */
SELECT AVG(LineTotal) AS [Media Valor]
FROM sales.SalesOrderDetail
GO

/*************** 
-- GROUP BY 
****************/

-- Soma total das vendas por ID
SELECT SpecialOfferID,
	   SUM(UnitPrice) AS [Soma]
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
ORDER BY SUM(UnitPrice) DESC
GO

-- Quantos produtos foram vendidos até hoje?
SELECT ProductID, 
	   COUNT(ProductID) AS [Contagem]
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY COUNT(ProductID)
GO

-- Quantos nomes de cada nome temos cadastrado em nosso banco de dados
SELECT FirstName, 
	   COUNT(FirstName) AS [Qtd. Nomes]
FROM Person.Person
GROUP BY FirstName 
ORDER BY COUNT(FirstName) DESC
GO

-- Média de preço para cada cor dos produtos(production.product) 
SELECT Color, 
	   ROUND(AVG(ListPrice), 2) AS [Média cor dos produtos]
FROM Production.Product
GROUP BY Color
ORDER BY AVG(ListPrice) DESC
GO

-- Média de preço para os produtos(production.product) que são pratas(Silver)
SELECT Color, 
	   AVG(ListPrice) AS [Média Produtos Silver]
FROM Production.Product
WHERE Color = 'Silver'
GROUP BY Color
GO

-- Quantas pessoas tem o mesmo MiddleName agrupadas pelo MiddleName
SELECT MiddleName,
	   COUNT(MiddleName) AS [Qtd. MiddleName]
FROM Person.Person
GROUP BY MiddleName
ORDER BY COUNT(MiddleName) DESC
GO

-- Em média, qual é a quantidade(OrderQty) que cada produto é vendido na loja
SELECT pp.[Name],
	   so.ProductID, 
	   AVG(so.OrderQty) AS [Média]
FROM Sales.SalesOrderDetail AS so
INNER JOIN Production.Product AS pp
	ON so.ProductID = pp.ProductID
GROUP BY so.ProductID, pp.[Name]
ORDER BY AVG(so.OrderQty) DESC
GO

-- Qual foram as 10 vendas que no total tiveram os maiores valor de venda(lineTotal) por produto do maior valor para o menor
SELECT TOP 10
	   so.productID, 
	   pp.[name],
	   ROUND(SUM(so.LineTotal), 2)
FROM sales.SalesOrderDetail AS so
INNER JOIN Production.Product AS pp
	ON so.ProductID = pp.ProductID
GROUP BY so.ProductID, 
		 pp.[Name]
ORDER BY SUM(so.LineTotal) DESC
GO

-- Quantos produtos e qual a quantidade média de produtos temos cadastrados
-- nas nossas ordem de serviço(WorkOrder)
-- Agrupados por productID

SELECT COUNT(ProductID) AS [Qtd. Produtos],
	   AVG(OrderQty) AS [Qtd. Média]
FROM production.workOrder
GROUP BY ProductID
ORDER BY AVG(OrderQty) DESC
GO

/****************
-- INNER JOIN
****************/

SELECT TOP 10
	   pp.FirstName,
	   pp.LastName,
	   pe.EmailAddress
FROM person.Person AS pp
INNER JOIN Person.EmailAddress AS pe
	ON pp.BusinessEntityID = pe.BusinessEntityID
GO

-- Nome dos produtos e a subcategoria
SELECT TOP 1 *
FROM Production.Product 
WHERE ProductID = 680

SELECT TOP 1 *
FROM Production.ProductCategory
WHERE ProductCategoryId = 2

SELECT TOP 1 *
FROM Production.ProductSubCategory
WHERE ProductSubcategoryID = 14
GO

SELECT p.[Name] AS [Produto],
	   c.[name] AS [Categoria],
	   s.[name] AS [Subcategoria]  
FROM Production.Product AS p
INNER JOIN Production.ProductSubcategory AS s
	ON p.ProductSubcategoryID = s.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS c
	ON s.ProductCategoryID = c.ProductCategoryID
GO