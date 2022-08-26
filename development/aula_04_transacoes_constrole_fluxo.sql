--------------------------------------------------------------------------------------
-- Aula 04 - Transações e Controle de Fluxo I
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

-- Declarando Variáveis e Ajustando valores Iniciais
declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

-- Aplicação das taxas
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

-- Declarando Variáveis e Ajustando valores Iniciais
declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

-- Aplicação das taxas
if @qtd * @taxa > 20
begin
	set @qtd += @qtd * 0.1 -- Aumentar em 10 %
	set @taxa *= 2 -- Duplicar a taxa
end
else  -- Reduzir em 15 % e Duplicar a taxa
	select @qtd -= @qtd * 0.15, @taxa *= 2 

select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'







-- Exemplo 3: RETURN

-- Declarando Variáveis e Ajustando valores Iniciais
declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

-- Verificando valores
if @qtd * @taxa >= 10
begin
	select 'Valor da Quantidade x Taxa = ' + cast(@qtd * @taxa as varchar) + ' !'
	return 
end

select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'








-- Exemplo 4: GOTO

-- Declarando Variáveis e Ajustando valores Iniciais
declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

goto MarcacaoDeUmRotulo -- Salta diretamente para este rótulo

set @qtd = @qtd + 100
set @taxa = @taxa + 1

MarcacaoDeUmRotulo: -- Definição do Rótulo
	select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'















-- Mais Exemplos 1

-- Verificando o número de objetos na base de dados atual
if (select count(*) from sys.objects) > 50
	goto Objetos_Maior_50 -- Forçar desvio de Fluxo
else
	select 'Quantidade de OBJETOS menor que 50 !'

return

Objetos_Maior_50: -- Desvio para o número de sys.objects
	select count(*) as 'Quantidade de Objetos encontrados !' from sys.objects





-- Mais Exemplos 2

-- Declarando variável já com valor inicial de objetos
-- de sistema e usuários
declare @qtd int = (select count(*) from sys.objects)

-- Verificando o número de objetos na base de dados atual
if @qtd > 50
	goto Objetos_Maior_50 -- Forçar desvio de Fluxo

return -- Forçar a saída imediata do script

/*
	Como o número de objetos é maior que 50,
	só chegará a este ponto do Batch se houver 
	algum outro desvio de fluxo
*/
Desvio_Nao_Estruturado:
	-- Pegar o número de tabelas de usuários
	select @qtd = count(*) from sys.tables 
	select	'Quantidade de TABELAS =  '
			+ cast(@qtd as varchar) + ' ! '
			as 'Select no Desvio_Nao_Estruturado:'

return -- Forçar a saída imediata do script

-- Só consegue chegar neste ponto do Batch por desvio de fluxo
Objetos_Maior_50: -- Desvio para o número de sys.objects
	select concat(	'Quantidade de OBJETOS = '
					, cast(@qtd as varchar), ' ! ')
			as 'Select no Objetos_Maior_50:'
	-- Desvio pode ser para qualquer ponto do BATCH
	goto Desvio_Nao_Estruturado 



						