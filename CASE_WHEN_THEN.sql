-- Declarando uma variável
DECLARE @mes VARCHAR(15)

-- Setando valor a essa variável
SET @mes = 10 --DATEPART(MONTH, GETDATE())

-- CASE com os meses
SELECT @mes AS [Mês],
    CASE 
        WHEN @mes = 1 THEN 'Janeiro'
        WHEN @mes = 2 THEN 'Fevereiro'
        WHEN @mes = 3 THEN 'Março'
        WHEN @mes = 4 THEN 'Abril'
        WHEN @mes = 5 THEN 'Maio'
        WHEN @mes = 6 THEN 'Junho'
        WHEN @mes = 7 THEN 'Julho'
        WHEN @mes = 8 THEN 'Agosto'
        WHEN @mes = 9 THEN 'Setembro'
        WHEN @mes = 10 THEN 'Outubro'
        WHEN @mes = 11 THEN 'Novembro'
        WHEN @mes = 12 THEN 'Dezembro'
    END AS [Nome]
