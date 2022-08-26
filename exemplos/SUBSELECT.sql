USE AdventureWorks2017

/* SUBSELECT */

/*
	Relat�rio de todos os produtos cadastrados 
	que tem o pre�o de venda acima da m�dia
*/

SELECT [Name] AS 'Nome do Produto', 
	   [ProductNumber] AS 'N�mero do Produto',
	   [ListPrice] AS 'Valor do Produto'
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product)
ORDER BY 1

/*
	Eu quero saber o nome dos meus funcion�rios
	que tem o cargo de Design Engineer
*/

SELECT * 
FROM Person.Person
WHERE BusinessEntityID 
IN(SELECT BusinessEntityID FROM HumanResources.Employee WHERE JobTitle = 'Design Engineer')


/*
	Todos os endere�os que est�o no estado de Alberta,
	pode trazer todas as informa��es
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





