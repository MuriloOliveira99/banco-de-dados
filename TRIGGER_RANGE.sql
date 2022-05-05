
USE exemplo_bulk_insert
CREATE TABLE salario_range(
    salario_minimo MONEY,
    salario_maximo MONEY
)
GO 
INSERT INTO salario_range 
VALUES(2000.00, 6000.00)
GO

/* TRIGGER */
CREATE TRIGGER tgr_range
ON dbo.empregado 
FOR INSERT, UPDATE
AS 
    DECLARE 
        @minsal MONEY, -- Salário Minímo
        @maxsal MONEY, -- Salário Máximo
        @atualsal MONEY -- Salário Atual
    SELECT @minsal = salario_minimo, 
           @maxsal = salario_maximo
    FROM salario_range

    SELECT @atualsal = i.salario
    FROM inserted i

    IF(@atualsal < @minsal)
    BEGIN 
        RAISERROR('SALÁRIO MENOR QUE O PISO', 16, 1)-- função que exibe uma msg de erro
        ROLLBACK TRANSACTION
    END 

    IF(@atualsal > @maxsal)
    BEGIN 
        RAISERROR('SALÁRIO MAIOR QUE O TETO', 16, 1)-- função que exibe uma msg de erro
        ROLLBACK TRANSACTION
    END 
GO

UPDATE empregado 
SET salario = 9000.00
WHERE id_empregado = 1
GO 

/* VERIFICANDO O TEXTO DE UMA TRIGGER */
sp_helptext tgr_range
GO