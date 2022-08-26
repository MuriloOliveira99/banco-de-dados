USE m4_compras_mercearia
GO

/*****************************************
    Procedure para buscar um fornecedor 
******************************************/
CREATE PROCEDURE sp_buscar_fornecedor
    -- declarando a variável
    @nome_fornecedor VARCHAR(20)
AS 
    SET @nome_fornecedor =  @nome_fornecedor
 -- SET @nome_fornecedor = '%' + @nome_fornecedor + '%';
    SELECT nome
    FROM Fornecedor
    WHERE nome = @nome_fornecedor
GO

-- Executando a procedure
EXEC sp_buscar_fornecedor 'Ambev'
GO
SELECT * FROM Fornecedor
GO

/******************************************
    Procedure para inserir um fornecedor 
*******************************************/
CREATE PROCEDURE sp_inserir_novo_fornecedor
    @nome_fornecedor VARCHAR(20)
AS 
    SET @nome_fornecedor = @nome_fornecedor
    INSERT INTO Fornecedor(nome)
    VALUES(@nome_fornecedor)
GO 

-- Executando a procedure
EXEC sp_inserir_novo_fornecedor 'Brahma'
GO
SELECT * FROM Fornecedor
GO

/*******************************************
    Procedure para atualizar um fornecedor 
********************************************/
CREATE PROCEDURE sp_atualizar_fornecedor
    @nome_fornecedor_antigo VARCHAR(20),
    @nome_fornecedor_novo VARCHAR(20)
AS 
    SET @nome_fornecedor_antigo = @nome_fornecedor_antigo
    SET @nome_fornecedor_novo = @nome_fornecedor_novo
    
    UPDATE Fornecedor SET nome = @nome_fornecedor_novo
    WHERE nome = @nome_fornecedor_antigo
GO

EXEC sp_atualizar_fornecedor 'Brahma', 'Brahma_Atualizado'
GO
