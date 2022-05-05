USE AdventureWorks2017

/* 
295 LINHAS 
TRAZ TODOS OS PRODUTOS, MESMO QUE NÃO TENHA 
MODELO, CATEGORIA E SUBCATEGORIA
*/
SELECT p.[name] AS 'Produto',
	   pm.[name] AS 'Modelo',
	   pc.[name] AS 'Categoria',
	   psc.[name] AS 'Subcategoria'
	   
FROM production.Product AS p
	LEFT JOIN production.ProductSubcategory AS psc
		ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	LEFT JOIN production.ProductModel AS pm
		ON p.ProductModelID = pm.ProductModelID
	LEFT JOIN production.ProductCategory AS pc
		ON psc.ProductCategoryID = pc.ProductCategoryID
GO


/* Exibir nome, modelo, categoria e subcategoria do produto 

TRAZ TODOS OS PRODUTOS QUE POSSUEM 
MODELO, CATEGORIA E SUBCATEGORIA
*/
SELECT p.[name] AS 'Nome do Produto',
	   pm.[name] AS 'Modelo do Produto',
	   pc.[name] AS 'Categoria do Produto',
	   psc.[name] AS 'Subcategoria do Produto'
FROM Production.Product AS p
INNER JOIN Production.ProductModel AS pm
	ON p.ProductModelID = pm.ProductModelID
INNER JOIN Production.ProductSubcategory AS psc 
	ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS pc 
	ON psc.ProductCategoryID = pc.ProductCategoryID
GO




