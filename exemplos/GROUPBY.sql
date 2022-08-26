/* 
	GROUP BY 
	SELECT coluna1, coluna2, funcaoAgregacao(coluna3)
	FROM nomeTabela
	GROUP BY coluna1, coluna2
*/
SELECT *
FROM Sales.SalesOrderDetail

SELECT specialOfferID, COUNT(specialOfferID) AS 'NUM. OFERTA', SUM(UnitPrice) AS 'SOMA'
FROM sales.SalesOrderDetail
GROUP BY SpecialOfferID
ORDER BY SOMA DESC
GO

/* Quantos cada produto foi vendido at� hoje */
SELECT TOP 10 productID, COUNT(productID) 'Qtd de Produto'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY 'Qtd de Produto' DESC
SELECT * FROM Production.Product
GO

/* Quantos nomes de cada nome temos cadastrado em nosso banco */
SELECT FirstName, COUNT(FirstName) AS 'Qtd. Nome'
FROM Person.Person 
GROUP BY FirstName
ORDER BY 'Qtd. Nome' DESC
GO


/* M�dia dos Produtos por COR? */
SELECT color, 
	   ROUND(AVG(ListPrice), 2) AS 'M�dia dos Produtos por Cor'
FROM Production.Product
GROUP BY color
ORDER BY AVG(Listprice) DESC
GO

/* M�dia da cor SILVER dos produtos? */
SELECT color AS 'Cor', 
	   ROUND(AVG(ListPrice), 2) AS 'M�dia dos Produtos Prata'
FROM Production.Product
WHERE Color = 'Silver'
GROUP BY color
ORDER BY 'M�dia dos Produtos Prata' DESC
GO

/* Quantas pessoas tem o MiddleName? */
SELECT MiddleName, 
	   COUNT(MiddleName) AS 'Contagem MiddleName'
FROM Person.person
WHERE MiddleName IS NOT NULL
GROUP BY MiddleName
ORDER BY 'Contagem MiddleName' DESC
GO

/* Em m�dia, qual � a quantidade que cada 
   produto � vendido na loja?
*/
SELECT TOP 10 sod.ProductID, 
           pp.[Name], 
		   AVG(sod.OrderQty) AS 'M�dia de Cada Produto'
FROM Sales.SalesOrderDetail AS sod
	INNER JOIN Production.Product AS pp
		ON sod.ProductID = pp.ProductID
GROUP BY sod.productID, pp.[Name]
ORDER BY 'M�dia de Cada Produto' DESC
GO

/*  Quais foram as 10 vendas que no total tiveram
	os maiores valores de venda(lineTotal) por produto 
	do maior valor para o menor?
*/
SELECT TOP 10 sod.ProductID, 
			pp.[Name],
			ROUND(SUM(LineTotal), 2) AS 'Maior Valor de Venda'  
FROM Sales.SalesOrderDetail AS sod
	INNER JOIN Production.Product AS pp
		ON sod.ProductID = pp.ProductID
GROUP BY sod.ProductID, pp.[Name]
ORDER BY 'Maior Valor de Venda' DESC
GO

/*
	Quantos produtos e qual a quantidade m�dia de produtos temos 
	cadastrados nas nossas ordem de servi�o(WorkOder) por ProductId
*/
SELECT wo.productId,
	   pp.[Name],
	   COUNT(wo.productID) AS 'Quantidade de Produtos', 
	   AVG(wo.OrderQty) AS 'Quantidade M�dia dos Produtos'
FROM Production.WorkOrder AS wo
	INNER JOIN Production.Product AS pp
		ON wo.ProductID = pp.ProductID
GROUP BY wo.ProductID, pp.[Name]
ORDER BY 'Quantidade de Produtos' DESC
GO

/* ---------------- GROUP BY COM HAVING ---------------- */

/* 
	Quais produtos que no total de vendas
	est�o entre 162000 a 500000 mil?
*/
SELECT ProductID, 
	   SUM(LineTotal) AS 'Total Vendas' 
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) 
BETWEEN 162000 AND 500000
ORDER BY ProductID 
GO

/* 
	Quais nomes no sistema tem uma ocorrencia 
	maior que 10 vezes, porem somente onde o t�tulo � 'Mr.'
*/
SELECT FirstName, 
	   COUNT(FirstName) AS 'Quantidade de Nomes'
FROM Person.person
WHERE title = 'Mr.'
GROUP BY FirstName
	HAVING COUNT(FirstName) > 10
ORDER BY COUNT(FirstName) DESC
GO

/*
	Estamos querendo identificar as provincias(stateProvinceID)
	com o maior n�mero de cadastros no nosso sistema,
	ent�o � preciso encontrar quais prov�ncias est�o
	registradas no banco de dados mais que 1000 vezes
*/
SELECT COUNT(StateProvinceID) AS 'Provincias'
	FROM Person.[Address]
GROUP BY StateProvinceID
	HAVING COUNT(StateProvinceID) > 1000
ORDER BY COUNT(StateProvinceID)
GO

/*
	Quais produtos(productID) n�o est�o trazendo em m�dia
	no m�nimo 1 milhao em total de vendas(lineTotal)
*/
SELECT productID, AVG(LineTotal) AS 'Total Vendas'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(LineTotal) < 1000000

/*
	Quantos tipos de pessoas existem e qual a quantidade?
*/
SELECT personType AS [Tipos de Pessoa], 
	   COUNT(PersonType) AS [Quantidade]
FROM Person.person
GROUP BY PersonType


/*
	Quantas cidades existem e a quantidade de endere�os de cada uma
*/
SELECT [City] AS 'Cidades', 
	   COUNT(city) AS 'Qtd. Endere�os'
FROM Person.[Address]
GROUP BY [City]
ORDER BY COUNT([city]) DESC

/*
	
*/
SELECT sod.CarrierTrackingNumber AS 'N�mero de Rastreamento', 
	   COUNT(sod.CarrierTrackingNumber) AS 'Quantidade',
	   ROUND(SUM(UnitPrice), 2) AS 'Valor Total',
	   ROUND(AVG(UnitPrice), 2) AS 'M�dia do Pre�o'	
FROM Sales.SalesOrderDetail AS sod
GROUP BY sod.CarrierTrackingNumber
ORDER BY COUNT(sod.CarrierTrackingNumber) DESC
SELECT * FROM Sales.SalesOrderDetail







