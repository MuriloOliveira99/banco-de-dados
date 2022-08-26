-- 1. Exibindo números de 1 até 10
DECLARE @num INT = 10,
	    @cont INT = 0

WHILE @cont < @num  
BEGIN
	SET @cont = @cont +1
	PRINT CONCAT('Número: ', CAST(@cont AS VARCHAR))
END
GO

--