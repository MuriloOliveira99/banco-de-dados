USE AdventureWorks2017

/* SUBSELECT */

/*
	Relatório de todos os produtos cadastrados 
	que tem o preço de venda acima da média
*/

SELECT [Name] AS 'Nome do Produto', 
	   [ProductNumber] AS 'Número do Produto',
	   [ListPrice] AS 'Valor do Produto'
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product)
ORDER BY 1

/*
	Eu quero saber o nome dos meus funcionários
	que tem o cargo de Design Engineer
*/

SELECT * 
FROM Person.Person
WHERE BusinessEntityID 
IN(SELECT BusinessEntityID FROM HumanResources.Employee WHERE JobTitle = 'Design Engineer')


/*
	Todos os endereços que estão no estado de Alberta,
	pode trazer todas as informações
	person.address e person.stateprovince
*/

SELECT * 
FROM Person.[Address]
WHERE StateProvinceID 
IN(
	SELECT StateProvinceID 
	FROM Person.StateProvince
	WHERE [name] = 'Alberta'
) 





