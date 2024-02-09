--------------------------------------------------------------------------------------
-- Aula 04 - Transa��es e Controle de Fluxo I
--------------------------------------------------------------------------------------
-- Exemplo 0: IF ... ELSE

if 1 = 1
	print 'Verdadeiro'
else
	print 'Falso ou Desconhecido'



if 1 <> 1
	select 'Verdadeiro'
else
	select 'Falso ou Desconhecido'


if 1 = null
	print 'Verdadeiro'
else
	print 'Falso ou Desconhecido'



-- Exemplo 1: IF ... ELSE

-- Declarando Vari�veis e Ajustando valores Iniciais
declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

-- Aplica��o das taxas
if @qtd * @taxa > 20
begin
	set @qtd += @qtd * 0.1 -- Aumentar em 10 %
	set @taxa *= 2 -- Duplicar a taxa
end
else
begin
	set @qtd -= @qtd * 0.15 -- Reduzir em 15 %
	set @taxa *= 2 -- Duplicar a taxa
end

select @qtd as 'Valor Final da Quantidade', @taxa as 'Valor Final da Taxa'















-- Exemplo 2: IF ... ELSE

-- Declarando Vari�veis e Ajustando valores Iniciais
declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

-- Aplica��o das taxas
if @qtd * @taxa > 20
begin
	set @qtd += @qtd * 0.1 -- Aumentar em 10 %
	set @taxa *= 2 -- Duplicar a taxa
end
else  -- Reduzir em 15 % e Duplicar a taxa
	select @qtd -= @qtd * 0.15, @taxa *= 2 

select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'







-- Exemplo 3: RETURN

-- Declarando Vari�veis e Ajustando valores Iniciais
declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

-- Verificando valores
if @qtd * @taxa >= 10
begin
	select 'Valor da Quantidade x Taxa = ' + cast(@qtd * @taxa as varchar) + ' !'
	return 
end

select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'








-- Exemplo 4: GOTO

-- Declarando Vari�veis e Ajustando valores Iniciais
declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

goto MarcacaoDeUmRotulo -- Salta diretamente para este r�tulo

set @qtd = @qtd + 100
set @taxa = @taxa + 1

MarcacaoDeUmRotulo: -- Defini��o do R�tulo
	select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'















-- Mais Exemplos 1

-- Verificando o n�mero de objetos na base de dados atual
if (select count(*) from sys.objects) > 50
	goto Objetos_Maior_50 -- For�ar desvio de Fluxo
else
	select 'Quantidade de OBJETOS menor que 50 !'

return

Objetos_Maior_50: -- Desvio para o n�mero de sys.objects
	select count(*) as 'Quantidade de Objetos encontrados !' from sys.objects





-- Mais Exemplos 2

-- Declarando vari�vel j� com valor inicial de objetos
-- de sistema e usu�rios
declare @qtd int = (select count(*) from sys.objects)

-- Verificando o n�mero de objetos na base de dados atual
if @qtd > 50
	goto Objetos_Maior_50 -- For�ar desvio de Fluxo

return -- For�ar a sa�da imediata do script

/*
	Como o n�mero de objetos � maior que 50,
	s� chegar� a este ponto do Batch se houver 
	algum outro desvio de fluxo
*/
Desvio_Nao_Estruturado:
	-- Pegar o n�mero de tabelas de usu�rios
	select @qtd = count(*) from sys.tables 
	select	'Quantidade de TABELAS =  '
			+ cast(@qtd as varchar) + ' ! '
			as 'Select no Desvio_Nao_Estruturado:'

return -- For�ar a sa�da imediata do script

-- S� consegue chegar neste ponto do Batch por desvio de fluxo
Objetos_Maior_50: -- Desvio para o n�mero de sys.objects
	select concat(	'Quantidade de OBJETOS = '
					, cast(@qtd as varchar), ' ! ')
			as 'Select no Objetos_Maior_50:'
	-- Desvio pode ser para qualquer ponto do BATCH
	goto Desvio_Nao_Estruturado 



						