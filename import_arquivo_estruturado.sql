USE AdventureWorks2017

/* 
    CHARINDEX - Retorna um Inteiro
    0 -> Não existe

    1º Paramêtro: O que estou procurando?
    2º Paramêtro: De onde estou procurando?
    3º Paramêtro: A partir de? Não é obrigatório. DEFAULT inicia em 1
*/

/* Procurando a letra 'E' na coluna FirstName
   Passando somente o 1º e 2º paramêtro
   O 3º paramêtro é opcional, quando não passamos ele inicia em 1
*/
SELECT TOP 10 
       FirstName,
       CHARINDEX('E', FirstName) AS INDICE
FROM Person.Person
GO


/* Procurando a letra 'E' na coluna FirstName
   a partir do indice 6
   Passando  o 1º, 2º e 3º paramêtro
*/
SELECT TOP 10 
       FirstName,
       CHARINDEX('E', FirstName, 6) AS INDICE
FROM Person.Person
GO

/* 
    BULK INSERT - IMPORTAR ARQUIVOS
    CREATE DATABASE exemplo_bulk_insert
*/

USE exemplo_bulk_insert
GO

-- Primeiro criamos uma tabela
-- CREATE TABLE lancamento_contabil(
--     conta INT,
--     valor INT,
--     deb_cred CHAR(1)
-- )
-- GO

/*
    ESTRUTURA DO MEU ARQUIVO.TXT

    CONTA   VALOR   TIPO
    1       1234    D
*/
BULK INSERT lancamento_contabil -- qual tabela vamos inserir o arquivo?
FROM 'C:\BULK_INSERT\CONTAS.txt' -- onde está o arquivo?
WITH (
    FIRSTROW = 2, --começa a partir da linha 2, pq a linha 1 é cabeçalho (conta|valor|tipo)
    DATAFILETYPE = 'CHAR', -- Tipo de arquivo
    FIELDTERMINATOR = '\t', -- Delimitador = \t = TAB
    ROWTERMINATOR = '\n' -- Terminador de linha = \n = ENTER
)
GO


/******************************
DESAFIO - SALDO
Teazer o número da conta e o saldo dela
******************************/
SELECT conta,
       valor,
       deb_cred,
CHARINDEX('D', deb_cred) AS [Débito],
CHARINDEX('C', deb_cred) AS [Crédito],
CHARINDEX('C', deb_cred) * 2 - 1 AS [Multiplicador]
FROM lancamento_contabil
GO

SELECT conta,
       SUM(valor * (CHARINDEX('C', deb_cred) * 2 - 1)) AS [Saldo]
FROM lancamento_contabil
GROUP BY conta 
GO
