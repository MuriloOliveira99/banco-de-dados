USE exemplo_bulk_insert
GO 

CREATE TABLE resultado(
    id_resultado INT IDENTITY,
    resultado INT,
    PRIMARY KEY(id_resultado)
)
GO

INSERT INTO resultado(resultado)
VALUES((SELECT 10 + 10))
GO

SELECT * FROM resultado
GO 

/* ATRIBUINDO SELECTS A VARIÁVEIS */

-- declarando a variável
DECLARE 
        @resultado INT 
        SET @resultado = (SELECT 50 + 50) -- Atribua a variável @resultado, o resultado do SELECT(10 + 10)
        INSERT INTO resultado values(@resultado)
        PRINT 'VALOR INSERIDO NA TABELA: ' + CAST(@resultado AS VARCHAR)
        GO

/* CRIAÇÃO DA TABELA */
CREATE TABLE empregado(
    id_empregado INT IDENTITY,
    nome VARCHAR(30), 
    salario MONEY,
    id_gerente INT
    PRIMARY KEY(id_empregado)
)
GO

ALTER TABLE empregado 
ADD CONSTRAINT fk_gerente
FOREIGN KEY(id_gerente)
REFERENCES empregado(id_empregado)
GO

INSERT INTO empregado VALUES('Clara', 5000.00, NULL)
INSERT INTO empregado VALUES('Celia', 4000.00, 1)
INSERT INTO empregado VALUES('João', 4000.00, 1)
GO

CREATE TABLE historico_salario(
    id_empregado INT,
    salario_antigo MONEY,
    salario_novo MONEY,
    [data] DATETIME
)
GO

/* CRIANDO A TRIGGER */
CREATE TRIGGER tgr_salario
ON dbo.empregado
FOR UPDATE AS 
IF UPDATE(salario)
BEGIN 
    INSERT INTO historico_salario (id_empregado, salario_antigo, salario_novo, [data])
    SELECT d.id_empregado, d.salario, i.salario, GETDATE() 
    FROM deleted AS d, inserted AS i 
    WHERE d.id_empregado = i.id_empregado
    PRINT 'TRIGGER EXECUTADA COM SUCESSO!!!'
END
GO

SELECT * FROM empregado
GO 

/* aumento de 10% no salário */
UPDATE empregado 
SET salario = salario * 1.1
GO

SELECT * FROM empregado
SELECT * FROM historico_salario
GO

