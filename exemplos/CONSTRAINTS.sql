/*
    ALTER TABLE table_name
    WITH CHECK CHECK CONSTRAINT constraint_name;

    NOT NULL
	Campo não pode ser nulo

    NULL
	Campo pode ser nulo

    IDENTITY(inicio, incremento)
	Gera valores inteiros que são auto-incrementais   

    DBCC Checkident( nome_tabela, reseed, 0)
	Reseta o auto-increment

    exec sp_help nome_tabela
		É uma procedure para exibir o detalhe de uma tabela
*/

CREATE DATABASE tbl_constraints
GO

USE tbl_constraints
GO

CREATE TABLE cliente (
   id INT IDENTITY(1, 1) NOT NULL,
   idade TINYINT NOT NULL, 
   cpf VARCHAR(15) NOT NULL,
   salario MONEY NOT NULL,
   id_endereco INT NOT NULL 
)
GO

CREATE TABLE endereco (
    id INT IDENTITY(1, 1) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero TINYINT NOT NULL 
    PRIMARY KEY(id)
)
GO 

/**************************************
            CHECK - CONSTRAINT
   tabelas->nome_da_tabela->restricoes
***************************************/

-- ADICIONAR UMA CHECK CONSTRAINT 
ALTER TABLE cliente -- nome da tabela
ADD CONSTRAINT chk_clienteIdade -- nome da constraint 
CHECK (idade > 0 AND idade <= 100) -- check constraint
GO
-- OU DIRETO NO CREATE TABLE
-- ADD CONSTRAINT chk_clienteIdade 
-- CHECK (idade > 0 AND idade <= 100)

-- EXCLUIR UMA CHECK CONSTRAINT
ALTER TABLE cliente -- nome da tabela
DROP CONSTRAINT chk_clienteIdade -- nome da check constraint
GO

-- RENOMEAR UMA CHECK CONSTRAINT
-- Cuidado: a alteração de qualquer parte de um nome de objeto pode interromper scripts e procedimentos armazenados.
exec sp_rename 'chk_clienteIdade', -- nome antigo da check constraint
          'chk_cliente_idade' -- novo nome da check constraint
GO
-- VISUALIZAR TODAS CONSTRAINT DE UMA TABELA?


/**************************************
         PRIMARY KEY - CONSTRAINT
   tabelas->nome_da_tabela->chaves/indices
***************************************/

-- ADIDCIONAR UMA PRIMARY KEY
ALTER TABLE cliente -- nome da tabela 
ADD CONSTRAINT pk_cliente -- nome da constraint
PRIMARY KEY(id) -- primary key constraint
-- OU DIRETO NO CREATE TABLE
-- ADD CONSTRAINT pk_cliente 
-- PRIMARY KEY(id)

-- EXCLUIR UMA PRIMARY KEY
ALTER TABLE cliente -- nome da tabela
DROP CONSTRAINT pk_cliente -- nome da primary key constraint

-- RENOMEAR UMA PRIMARY KEY CONSTRAINT
exec sp_rename 'pk_cliente', -- nome antigo da pk constraint
          'pk_nova_cliente' -- novo nome da pk constraint
GO


/*****************************************
         FOREIGN KEY - CONSTRAINT
   tabelas->nome_da_tabela->chaves/indices
******************************************/

-- ADICIONAR UMA FOREIGN KEY 
ALTER TABLE cliente -- nome da tabela
ADD CONSTRAINT fk_clienteEndereco -- nome da fk
FOREIGN KEY(id_endereco) -- foreign key
REFERENCES endereco(id) -- de onde vem a foreign key

-- EXCLUIR UMA FOREIGN KEY
ALTER TABLE cliente
DROP CONSTRAINT fk_clienteEndereco

-- RENOMEAR UMA FOREIGN KEY
exec sp_rename 'fk_clienteEndereco', -- nome antigo da fk constraint
          'pk_cliente_endereco' -- novo nome da fk constraint
GO


/*****************************************
                 COLUNA
******************************************/

-- ADICIONAR UMA NOVA COLUNA
ALTER TABLE cliente -- nome da tabela
ADD nova_coluna CHAR(5) NOT NULL, -- nome, tipo e restrição nova coluna
    nova_coluna2 VARCHAR(10) -- nome, tipo e restrição nova coluna

-- EXCLUIR UMA COLUNA
ALTER TABLE cliente -- nome da tabela
DROP COLUMN nova_coluna2-- nome da coluna

-- RENOMEAR UMA COLUNA
EXEC sp_rename 'cliente.nova_coluna', -- nome antigo da coluna
               'nova_coluna_renomeada', -- nome novo da coluna
               'COLUMN' -- qual objeto renomear

-- ALTERANDO O TIPO DA COLUNA
ALTER TABLE cliente -- nome da tabela
ALTER COLUMN nova_coluna_renomeada VARCHAR(100)


/*****************************************
                  TABELA
******************************************/

-- RENOMEAR O NOME DO BANCO
-- EX1
ALTER DATABASE tbl_constraints
MODIFY NAME = db_rename_exemplo1;

-- EX2
EXEC sp_renamedb 'db_rename_exemplo1', -- nome antigo do banco
                 'zdb_rename_exemplo2' -- novo nome do banco


