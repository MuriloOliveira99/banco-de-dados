/*
    TRIGGERS É UM GATILHO QUE É DISPARADO AUTOMATICAMENTE
    ANTES(BEFORE) OU DEPOIS(AFTER)
    INSERT, UPDATE, DELETE
*/

USE exemplo_bulk_insert
CREATE TABLE produtos(
    id_produto INT IDENTITY,
    nome VARCHAR(50) NOT NULL,
    categoria VARCHAR(30) NOT NULL,
    preco NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY(id_produto),
    CONSTRAINT chk_preco CHECK(preco >= 0)
)
GO

CREATE TABLE historico(
    id_operacao INT IDENTITY,
    produto VARCHAR(50) NOT NULL,
    categoria VARCHAR(30) NOT NULL,
    preco_antigo NUMERIC(10, 2) NOT NULL,
    preco_novo NUMERIC(10, 2) NOT NULL,
    [DATE] DATETIME,
    usuario VARCHAR(30),
    mensagem VARCHAR(100),

    PRIMARY KEY(id_operacao),
    CONSTRAINT chk_precoAntigo CHECK(preco_antigo >= 0),
    CONSTRAINT chk_precoNovo CHECK(preco_novo >= 0)
)
GO 

-- INSERT INTO produtos
-- VALUES('Livro SQL Server', 'Livros', '98.00')

-- INSERT INTO produtos
-- VALUES('Livro Oracle', 'Livros', '50.00')

-- INSERT INTO produtos
-- VALUES('Licença PowerCenter', 'SOFTWARE', '450000.00')

-- INSERT INTO produtos
-- VALUES('Notebook I7', 'Computadores', '3150.00')

-- INSERT INTO produtos
-- VALUES('Livro Business Intelligence I7', 'Livros', '90.00')
-- GO

SELECT * FROM produtos 
SELECT * FROM historico

/* VERIFICANDO O USUÁRIO DO BANCO */
SELECT SUSER_NAME()
GO

/******************************************
             TRIGGERS DE DADOS
      DATA MANIPULATION LANGUAGE (DML)
*******************************************/
CREATE TRIGGER tgr_atualiza_preco -- criando a trigger
ON dbo.produtos -- nome da tabela 
FOR UPDATE AS -- A trigger vai disparar quando fizer um UPDATE
IF UPDATE(preco) -- Se o UPDATE for em preço...
BEGIN -- Faça... IF precisa do BEGIN

    -- DECLARANDO AS VARIÁVEIS
    DECLARE @id_produto INT 
    DECLARE @produto VARCHAR(30) 
    DECLARE @categoria VARCHAR(10)
    DECLARE @preco NUMERIC(10, 2)
    DECLARE @preco_novo NUMERIC(10, 2)
    DECLARE @data DATETIME 
    DECLARE @usuario VARCHAR(30)
    DECLARE @acao VARCHAR(100)

    /*
       - VALORES VINDOS DE TABELAS SÃO INSERIDOS COM O COMANDO 'SELECT'
       - VALORES VINDOS DE FUNÇÔES OU VALORES LITERAIS DEVEM SER 
        ATRIBUIDOS COM O COMANDO SET
    */
    -- Setando valores nas variáveis   
    SELECT @id_produto = id_produto FROM inserted
    SELECT @produto = nome FROM inserted
    SELECT @categoria = categoria FROM inserted
    SELECT @preco = preco FROM deleted -- preço antigo
    SELECT @preco_novo = preco FROM inserted

    -- Setando as variáveis que nãoe estão na tabela produtos
    SET @data = GETDATE()
    SET @usuario = SUSER_NAME()
    SET @acao = 'Valor inserido pela TRIGGER tgr_atualiza_preco'

    /* INSERINDO NA TABELA HISTORICO */
    INSERT INTO historico(produto, categoria, preco_antigo, preco_novo, [date], usuario, mensagem)        
    VALUES(@produto, @categoria, @preco, @preco_novo, @data, @usuario, @acao)

    PRINT 'TRIGGER EXECUTADA COM SUCESSO!!!'
END
GO

/* EXECUTANDO A TRIGGER */
UPDATE produtos SET preco = 300.00
WHERE id_produto = 2
GO

UPDATE produtos SET nome = 'Livro JAVA'
WHERE id_produto = 2
GO

SELECT * FROM historico

