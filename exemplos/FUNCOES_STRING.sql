/****************************************
			FUN��ES STRING
*****************************************/


/*********************************************
			      LTRIM()  
Remove os espa�os que estejam livres a ESQUERDA
***********************************************/
SELECT '        Murilo' AS 'SEM LTRIM'
SELECT LTRIM('        Murilo') AS 'COM LTRIM'


/*********************************************
			      RTRIM()  
Remove os espa�os que estejam livres a DIREITA
***********************************************/
SELECT 'Murilo         ' AS 'SEM RTRIM'
SELECT LTRIM('Murilo         ') AS 'COM RTRIM'


/************************************************************
			      PATINDEX()  
Retorna a posi��o inicial da primeira ocorr�ncia de um padr�o
*************************************************************/
SELECT PATINDEX('%tro%', 'Alessandro Trovato') --12
SELECT PATINDEX('%a', 'Ter�a') --5
SELECT PATINDEX('a%', 'Trovato') --0 pq n come�a com 'a'
SELECT PATINDEX('a%', 'Alessandro') --1
SELECT PATINDEX('%at%', 'Alessandro Trovato') --16
SELECT PATINDEX('%dro_trov%', 'Alessandro Trovato') --8


/***************************************
			      REPLACE()  
		Substitui caracter em um campo
		1� Parametro = Palavra/letra
		2� Parametro = Caracter que desejo substituir do palavra/letra
		3� Parametro = Substituir o caracter pelo oq? 
****************************************/
SELECT REPLACE('Alessandro Trovato', 'a', 'x')
SELECT REPLACE(REPLACE('Alessandro Trovato', 'a', 'x'), 'o', '?')

-- CPF
SELECT '111.222.333-44' AS 'CPF FORMATADO'

-- Trocando os . - do cpf por vazio
SELECT REPLACE(REPLACE('111.222.333-44', '.', ''), '-', '') AS 'CPF N�O FORMATADO'


/*******************************************
			      REPLICATE()  
		 Serve para replicar um argumento
********************************************/
SELECT REPLICATE('x', 20) --xxxxxxxxxxxxxxxxxxxx = 20X

-- Tamanho de coluna fixo em 50 posi��es
-- passo 1
USE AC3_M3_consultorio
SELECT LEN(nome) FROM Paciente

-- Acrescenta X at� completar 50 caracteres
-- FUNCAO LEN N�O CONTA ESPA�OS A ESQUERDA
SELECT nome + replicate('x', 50 - len(nome))
FROM paciente


/*******************************************
			        REVERSE()  
			Serve para reverter uma string
				    sql -> lqs
********************************************/
SELECT REVERSE('MURILO OLIVEIRA ROCHA') AS 'REVERSO'


/*******************************************
			       SPACE()  
   Serve para inserir espa�os em uma string
********************************************/
SELECT 'Murilo' + SPACE(25)
SELECT 'Murilo' + SPACE(25) + 'x'


/******************************************************************************
			     SUBSTRING()  
	    - Retira parte de uma STRING
		- 1� Parametro - STRING
		- 2� Parametro - Indice da posicao inicial que desejo extrair
		- 3� Parametro - Indice da posi��o final da posi��o que desejo extrair
*******************************************************************************/
SELECT SUBSTRING('Murilo Oliveira', 1, 10) AS 'NOME SUBSTRING'

