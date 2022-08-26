CREATE DATABASE database_development
GO

USE database_development
GO

/************* EXERCÍCIO 1 *************

-- Elaborar uma Variável Table referente a Cliente, com os menores tipos de
   dados possíveis para armazenar as seguintes colunas:

– nroCliente (100 clientes, numérico de geração automática, primary key)
– nome (character até 60, unique)
– dataNascimento (data, domínio: 18 a 50 anos)
– cpf (11 caracteres fixos, obrigatório os 11 dígitos e entre 0 e 9)
– sexo (domínio textual: Masculino ou Feminino)
– estadoCivil (domínio: Solteiro (a), Casado (a) , Divorciado (a) , Viúvo (a), – Default: Solteiro (a))
– nroFilhos (domínio: 0 a 20, Default: 0)

	CONSTRAINT PK_Cliente PRIMARY KEY(nroCliente),
	CONSTRAINT UQ_ClienteNome UNIQUE(nome),
	CONSTRAINT CK_ClienteDtNascimento CHECK(YEAR(GETDATE()) - YEAR(dataNascimento) BETWEEN 18 AND 50),
	CONSTRAINT CK_ClienteCPF CHECK(cpf LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CONSTRAINT CK_ClienteSexo CHECK(sexo IN('Masculino', 'Feminino')),
	CONSTRAINT CK_ClienteEstadoCivil CHECK(estadoCivil IN('Solteiro(a)', 'Casado(a)', 'Divorciado(a)', 'Viúvo(a)')),
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
	estadoCivil VARCHAR(10) CHECK(estadoCivil IN('Solteiro', 'Casado', 'Divorciado', 'Viúvo')) DEFAULT 'Solteiro',
	nroFilhos TINYINT CHECK(nroFilhos BETWEEN 0 AND 20) DEFAULT 0
)
-----------------------------------------------------------------------------------------------------------------------------------------------

/************* EXERCÍCIO 2 *************

-- Teste de Restrições: 
   Realizar 1 exemplo de inserção para cada domínio, provando que
   a tabela mantém a integridade definida nas regras de negócios.


-- RESTRIÇÃO: nome (character até 60, unique)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Murilo João Silva Oliveira Maria Murilo João Silva Oliveira M', '19990607', '12345678901', 'Masculino', 'Solteiro', 2) -- 61 caracteres	 

-- RESTRIÇÃO: dataNascimento (data, domínio: 18 a 50 anos)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES ('Oliveira', '19710410', '09876543211', 'Feminino', 'Casado', 0), -- idade: 51 anos 
	  ('João', '20050206', '65432178901', 'Masculino', DEFAULT, 20) -- idade: 17 anos

-- RESTRIÇÃO: cpf (11 caracteres fixos, obrigatório os 11 dígitos e entre 0 e 9)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Rafael', '20010903', '1234567890', 'Masculino', 'Divorciado', 2) -- CPF: 1234567890 (10 caracteres)	 

-- RESTRIÇÃO: sexo (domínio textual: Masculino ou Feminino)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Marcos', '1980414', '99988877765', 'Outro', 'Viúvo', 2) -- sexo: Outro	 

-- RESTRIÇÃO: estadoCivil (domínio: Solteiro (a), Casado (a) , Divorciado (a) , Viúvo (a), – Default: Solteiro (a)) 
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Weverton', '19941127', '09735913858', 'Masculino', 'Separado', 2), -- Estado Civil: Separado
	  ('Matheus', '20020620', '13858097359', 'Masculino', DEFAULT, 2) -- Estado Civil: DEFAULT

-- RESTRIÇÃO: nroFilhos (domínio: 0 a 20, Default: 0)
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Sabrina', '19881202', '13035859978', 'Feminino', 'Solteiro', 22), -- nroFilhos: 22
	  ('Ana', '20020620', '13858097359', 'Masculino', 'Divorciado', DEFAULT) -- nroFilhos: DEFAULT
*/
/************* EXERCÍCIO 3 *************

-- Popular e testar a variável com os dados abaixo, listando o resultado (SELECT) :

– Amadeu Abrantes (21 anos, data referente a idade, cpf(aleatório), Solteiro (a), 0 filhos)
– Juliana Batista (36 anos, data referente a idade, cpf(aleatório), Casado (a), 2 filhos)
– Sérgio Silva (47 anos , data referente a idade, cpf(aleatório), Viúvo (a), 4 filhos)

*/
-- INSERTS NA VARIÁVEL DO TIPO TABLE
INSERT @tbl_cliente(nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
VALUES('Amadeu Abrantes', REPLACE(CAST(GETDATE() AS DATE), LEFT(CAST(GETDATE() AS DATE), 4), YEAR(GETDATE()) - 21), '10293847561', 'Masculino', 'Solteiro', 0),
	  ('Juliana Batista', REPLACE(CAST(GETDATE() AS DATE), LEFT(CAST(GETDATE() AS DATE), 4), YEAR(GETDATE()) - 36), '90876512437', 'Feminino', 'Casado', 2),
	  ('Sérgio Silva', REPLACE(CAST(GETDATE() AS DATE), LEFT(CAST(GETDATE() AS DATE), 4), YEAR(GETDATE()) - 47), '65432109873', 'Masculino', 'Viúvo', 4)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/************* EXERCÍCIO 4 *************

-- Query: Recuperar as seguintes informações
-- 1a. coluna: Label: Sobrenome e Nome Info: Sobrenome, Nome
-- 2a. coluna: Label: Idade Info: cálculo aproximado (apenas a diferença em anos
-- entre a data de nascimento e a atual – utilizar a função datediff)
-- 3a. coluna: Label: CPF Info: cpf (colocar no formato 999.999.999-99)
-- 4a. coluna: Label: Gênero Info: sexo
-- 5a. coluna: Label: Estado Civil Info: estadoCivil
-- 6a. coluna: Label: Filhos Info: nroFilhos
*/

SELECT CONCAT(SUBSTRING(nome, CHARINDEX(' ', nome)+1, 60), SPACE(1), SUBSTRING(nome, 1, CHARINDEX(' ', nome)-1)) AS [Sobrenome e Nome],
	   DATEDIFF(YEAR, GETDATE(), dataNascimento) AS [Idade],
	   CONCAT(LEFT(cpf, 3), '.', SUBSTRING(cpf, 4, 3), '.', SUBSTRING(cpf, 7, 3), '-', RIGHT(cpf, 2)) AS [CPF],
	   sexo AS [Gênero],
	   CONCAT(estadoCivil,'(a)') AS [Estado Civil],
	   nroFilhos AS [Filhos]
FROM @tbl_cliente
