/****************************************
			FUNÇÔES STRING
*****************************************/


/*********************************************
			      LTRIM()  
Remove os espaços que estejam livres a ESQUERDA
***********************************************/
SELECT '        Murilo' AS 'SEM LTRIM'
SELECT LTRIM('        Murilo') AS 'COM LTRIM'


/*********************************************
			      RTRIM()  
Remove os espaços que estejam livres a DIREITA
***********************************************/
SELECT 'Murilo         ' AS 'SEM RTRIM'
SELECT LTRIM('Murilo         ') AS 'COM RTRIM'


/************************************************************
			      PATINDEX()  
Retorna a posição inicial da primeira ocorrência de um padrão
*************************************************************/
SELECT PATINDEX('%tro%', 'Alessandro Trovato') --12
SELECT PATINDEX('%a', 'Terça') --5
SELECT PATINDEX('a%', 'Trovato') --0 pq n começa com 'a'
SELECT PATINDEX('a%', 'Alessandro') --1
SELECT PATINDEX('%at%', 'Alessandro Trovato') --16
SELECT PATINDEX('%dro_trov%', 'Alessandro Trovato') --8


/***************************************
			      REPLACE()  
		Substitui caracter em um campo
		1º Parametro = Palavra/letra
		2º Parametro = Caracter que desejo substituir do palavra/letra
		3º Parametro = Substituir o caracter pelo oq? 
****************************************/
SELECT REPLACE('Alessandro Trovato', 'a', 'x')
SELECT REPLACE(REPLACE('Alessandro Trovato', 'a', 'x'), 'o', '?')

-- CPF
SELECT '111.222.333-44' AS 'CPF FORMATADO'

-- Trocando os . - do cpf por vazio
SELECT REPLACE(REPLACE('111.222.333-44', '.', ''), '-', '') AS 'CPF NÃO FORMATADO'


/*******************************************
			      REPLICATE()  
		 Serve para replicar um argumento
********************************************/
SELECT REPLICATE('x', 20) --xxxxxxxxxxxxxxxxxxxx = 20X

-- Tamanho de coluna fixo em 50 posições
-- passo 1
USE AC3_M3_consultorio
SELECT LEN(nome) FROM Paciente

-- Acrescenta X até completar 50 caracteres
-- FUNCAO LEN NÃO CONTA ESPAÇOS A ESQUERDA
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
   Serve para inserir espaços em uma string
********************************************/
SELECT 'Murilo' + SPACE(25)
SELECT 'Murilo' + SPACE(25) + 'x'


/******************************************************************************
			     SUBSTRING()  
	    - Retira parte de uma STRING
		- 1º Parametro - STRING
		- 2º Parametro - Indice da posicao inicial que desejo extrair
		- 3º Parametro - Indice da posição final da posição que desejo extrair
*******************************************************************************/
SELECT SUBSTRING('Murilo Oliveira', 1, 10) AS 'NOME SUBSTRING'

