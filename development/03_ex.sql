CREATE DATABASE database_development
GO

USE database_development
GO

/************* EXERC�CIO 1 *************

-- Elaborar uma Vari�vel Table referente a Cliente, com os menores tipos de
   dados poss�veis para armazenar as seguintes colunas:

� nroCliente (100 clientes, num�rico de gera��o autom�tica, primary key)
� nome (character at� 60, unique)
� dataNascimento (data, dom�nio: 18 a 50 anos)
� cpf (11 caracteres fixos, obrigat�rio os 11 d�gitos e entre 0 e 9)
� sexo (dom�nio textual: Masculino ou Feminino)
� estadoCivil (dom�nio: Solteiro (a), Casado (a) , Divorciado (a) , Vi�vo (a), � Default: Solteiro (a))
� nroFilhos (dom�nio: 0 a 20, Default: 0)

	CONSTRAINT PK_Cliente PRIMARY KEY(nroCliente),
	CONSTRAINT UQ_ClienteNome UNIQUE(nome),
	CONSTRAINT CK_ClienteDtNascimento CHECK(YEAR(GETDATE()) - YEAR(dataNascimento) BETWEEN 18 AND 50),
	CONSTRAINT CK_ClienteCPF CHECK(cpf LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CONSTRAINT CK_ClienteSexo CHECK(sexo IN('Masculino', 'Feminino')),
	CONSTRAINT CK_ClienteEstadoCivil CHECK(estadoCivil IN('Solteiro(a)', 'Casado(a)', 'Divorciado(a)', 'Vi�vo(a)')),
	CONSTRAINT DF_ClienteEstadoCivil DEFAULT 'Solteiro(a)' FOR estadoCivil,
	CONSTRAINT CK_ClienteNroFilhos CHECK(nroFilhos BETWEEN 0 AND 20),
	CONSTRAINT DF_ClienteNroFilhos DEFAULT 0 FOR nroFilhos

*/

-- Criando/dropando um SEQUENCE
DROP SEQUENCE seq_nroCliente
GO

CREATE SEQUENCE seq_nroCliente
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 100
GO

-- Verificando todos os SEQUENCES criados
SELECT * FROM sys.sequences 
GO

DECLARE @tbl_cliente TABLE
(
	nroCliente TINYINT NOT NULL PRIMARY KEY DEFAULT (NEXT VALUE FOR seq_nroCliente),
	nome VARCHAR(60) NOT NULL UNIQUE,
	dataNascimento DATE NOT NULL CHECK(YEAR(GETDATE()) - YEAR(dataNascimento) BETWEEN 18 AND 50),
	cpf CHAR(11) NOT NULL CHECK(cpf LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	sexo VARCHAR(9) NOT NULL CHECK(sexo IN('Masculino', 'Feminino')),
	estadoCivil VARCHAR(10) CHECK(estadoCivil IN('Solteiro', 'Casado', 'Divorciado', 'Vi�vo')) DEFAULT 'Solteiro',
	nroFilhos TINYINT CHECK(nroFilhos BETWEEN 0 AND 20) DEFAULT 0
)
-----------------------------------------------------------------------------------------------------------------------------------------------

/************* EXERC�CIO 2 *************

-- Teste de Restri��es: 
   Realizar 1 exemplo de inser��o para cada dom�nio, provando que
   a tabela mant�m a integridade definida nas regras de neg�cios.


-- RESTRI��O: nome (character at� 60, unique)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Murilo Jo�o Silva Oliveira Maria Murilo Jo�o Silva Oliveira M', '19990607', '12345678901', 'Masculino', 'Solteiro', 2) -- 61 caracteres	 

-- RESTRI��O: dataNascimento (data, dom�nio: 18 a 50 anos)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES ('Oliveira', '19710410', '09876543211', 'Feminino', 'Casado', 0), -- idade: 51 anos 
	  ('Jo�o', '20050206', '65432178901', 'Masculino', DEFAULT, 20) -- idade: 17 anos

-- RESTRI��O: cpf (11 caracteres fixos, obrigat�rio os 11 d�gitos e entre 0 e 9)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Rafael', '20010903', '1234567890', 'Masculino', 'Divorciado', 2) -- CPF: 1234567890 (10 caracteres)	 

-- RESTRI��O: sexo (dom�nio textual: Masculino ou Feminino)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Marcos', '1980414', '99988877765', 'Outro', 'Vi�vo', 2) -- sexo: Outro	 

-- RESTRI��O: estadoCivil (dom�nio: Solteiro (a), Casado (a) , Divorciado (a) , Vi�vo (a), � Default: Solteiro (a)) 
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Weverton', '19941127', '09735913858', 'Masculino', 'Separado', 2), -- Estado Civil: Separado
	  ('Matheus', '20020620', '13858097359', 'Masculino', DEFAULT, 2) -- Estado Civil: DEFAULT

-- RESTRI��O: nroFilhos (dom�nio: 0 a 20, Default: 0)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Sabrina', '19881202', '13035859978', 'Feminino', 'Solteiro', 22), -- nroFilhos: 22
	  ('Ana', '20020620', '13858097359', 'Masculino', 'Divorciado', DEFAULT) -- nroFilhos: DEFAULT
*/
/************* EXERC�CIO 3 *************

-- Popular e testar a vari�vel com os dados abaixo, listando o resultado (SELECT) :

� Amadeu Abrantes (21 anos, data referente a idade, cpf(aleat�rio), Solteiro (a), 0 filhos)
� Juliana Batista (36 anos, data referente a idade, cpf(aleat�rio), Casado (a), 2 filhos)
� S�rgio Silva (47 anos , data referente a idade, cpf(aleat�rio), Vi�vo (a), 4 filhos)

*/
-- INSERTS NA VARI�VEL DO TIPO TABLE
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Amadeu Abrantes', REPLACE(CAST(GETDATE() AS DATE), LEFT(CAST(GETDATE() AS DATE), 4), YEAR(GETDATE()) - 21), '10293847561', 'Masculino', 'Solteiro', 0),
	  ('Juliana Batista', REPLACE(CAST(GETDATE() AS DATE), LEFT(CAST(GETDATE() AS DATE), 4), YEAR(GETDATE()) - 36), '90876512437', 'Feminino', 'Casado', 2),
	  ('S�rgio Silva', REPLACE(CAST(GETDATE() AS DATE), LEFT(CAST(GETDATE() AS DATE), 4), YEAR(GETDATE()) - 47), '65432109873', 'Masculino', 'Vi�vo', 4)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/************* EXERC�CIO 4 *************

-- Query: Recuperar as seguintes informa��es
-- 1a. coluna: Label: Sobrenome e Nome Info: Sobrenome, Nome
-- 2a. coluna: Label: Idade Info: c�lculo aproximado (apenas a diferen�a em anos
-- entre a data de nascimento e a atual � utilizar a fun��o datediff)
-- 3a. coluna: Label: CPF Info: cpf (colocar no formato 999.999.999-99)
-- 4a. coluna: Label: G�nero Info: sexo
-- 5a. coluna: Label: Estado Civil Info: estadoCivil
-- 6a. coluna: Label: Filhos Info: nroFilhos
*/

SELECT CONCAT(SUBSTRING(nome, CHARINDEX(' ', nome)+1, 60), SPACE(1), SUBSTRING(nome, 1, CHARINDEX(' ', nome)-1)) AS [Sobrenome e Nome],
	   DATEDIFF(YEAR, GETDATE(), dataNascimento) AS [Idade],
	   CONCAT(LEFT(cpf, 3), '.', SUBSTRING(cpf, 4, 3), '.', SUBSTRING(cpf, 7, 3), '-', RIGHT(cpf, 2)) AS [CPF],
	   sexo AS [G�nero],
	   CONCAT(estadoCivil,'(a)') AS [Estado Civil],
	   nroFilhos AS [Filhos]
FROM @tbl_cliente
