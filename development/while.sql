-- 1. Exibindo n�meros de 1 at� 10
DECLARE @num INT = 10,
	    @cont INT = 0

WHILE @cont < @num  
BEGIN
	SET @cont = @cont +1
	PRINT CONCAT('N�mero: ', CAST(@cont AS VARCHAR))
END
GO

--