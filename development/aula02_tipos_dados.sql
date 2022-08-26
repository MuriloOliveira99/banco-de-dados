---------------------------------------------------------------------------
-- DATA TYPES INTERNALS: SMALLDATETIME
---------------------------------------------------------------------------
/*
- Armazenamento em 4 Bytes
- Armazenamento de Data e/ou Hora
- Precisão de MINUTOS (aproximação dos segundos, final 0)
- Domínio de Data: 1º de janeiro de 1900 a 6 de junho de 2079 
- Domínio de Hora: 00:00:00 a 23:59:59
- Valor Padrão: 1900-01-01 00:00:00
*/

USE BD3AN
GO


-- drop table TBTeste01
CREATE TABLE TBTeste01(
 id TINYINT IDENTITY,
 dt SMALLDATETIME
)


SP_HELP TBTeste01



-- INSERTS
insert into TBTeste01 values (null);
insert into TBTeste01 (dt) values (getdate());

select * from TBTeste01 

select getdate(), cast(getdate() as smalldatetime), cast(getdate() as date)
select '2022-08-03', ' é o mesmo que ', '20220803 00:00:00'

-- Armazenando somente DATA
insert into TBTeste01 (dt) values ('20220803'); -- FORMATO ISO YYYYMMDD
insert into TBTeste01 values (cast(getdate() as date));

select * from TBTeste01 
select *, convert(varchar, dt, 103) as 'Data Padrão (Britânico/Francês = Português)' from TBTeste01 



-- Armazenando somente Hora
insert into TBTeste01 values ('13:15');
insert into TBTeste01 values ('21:09');

select * from TBTeste01 

select '12' + ':' + '30' + ':' + '30'

-- Apresentação de segundos sempre ZERADOS (aproximacao de segundos)
insert TBTeste01 values ('20180113 12:30:59')
insert TBTeste01 values ('12' + ':' + '30' + ':' + '30')
insert TBTeste01 values ('20571231 12:30:29')
insert TBTeste01 values ('20571231 12:30:01')
insert TBTeste01 values ('20171231 23:59:30')

select * from TBTeste01 

select * from TBTeste01 where dt > '20571231 12:29:31'
select * from TBTeste01 where dt >= '20571231 12:29:31'
select * from TBTeste01 where dt >= '20571231 12:30'

drop table TBTeste01
---------------------------------------------------------------------------



---------------------------------------------------------------------------
-- DATA TYPES INTERNALS: DATETIME
---------------------------------------------------------------------------
/*
- Armazenamento em 8 Bytes
- Armazenamento de Data e/ou Hora
- Precisão aproximada, 3 MILISSEGUNDOS (aproximação dos milissegundos, finais 0, 3, 7)
- Domínio de Data: Janeiro 1, 1753, a dezembro 31, 9999 
- Domínio de Hora: 00:00:00.000 a 23:59:59.997
- Valor Padrão (default): 1900-01-01 00:00:00.000
*/

-- drop table TBTeste02 
create table TBTeste02
(
id tinyint identity
, dt datetime not null
)

sp_help TBTeste02


-- INSERTS
insert into TBTeste02 (dt) values (null);
insert into TBTeste02 values (getdate());
insert into TBTeste02 (dt) values ('20220803 09:59');

select * from TBTeste02 
select cast(getdate() as date)

-- Armazenando somente DATA
insert into TBTeste02 (dt) values ('20220803'); -- FORMATO ISO YYYYMMDD
insert into TBTeste02 values (cast(getdate() as date));

select * from TBTeste02 


-- Armazenando somente Hora
insert into TBTeste02 values ('13:15:29.663');
insert into TBTeste02 values ('21:09:38.777');

select * from TBTeste02 

-- Apresentação de MILISSEGUNDOS com finais 0, 3, 7 (aproximacao de milissegundos - precisao aproximada de 003 milissegundos)
insert TBTeste02 values('20180228 23:59:59:989'), ('20180228 23:59:59:990'), ('20180228 23:59:59:991') -- 9, 0, 1 --> 0


insert TBTeste02 values('20180228 23:59:59:992'), ('20180228 23:59:59:993'), ('20180228 23:59:59:994') -- 2, 3, 4 --> 3

insert TBTeste02 values	('20180228 23:59:59:995'), ('20180228 23:59:59:996')
						, ('20180228 23:59:59:997'), ('20180228 23:59:59:998') -- 5, 6, 7, 8 --> 7


insert TBTeste02 values('20180228 23:59:59:999') -- 2018-03-01 00:00:00.000

select * from TBTeste02 order by id desc

select * from TBTeste02 where dt < '20180227' -- '20180227 00:00:00.000'
select * from TBTeste02 where dt <= '20180227' 
select * from TBTeste02 where dt < '20180228'-- '20180228 00:00:00.000'
select * from TBTeste02 where dt < '20180229'
select * from TBTeste02 where dt < '20180301'
select * from TBTeste02 where dt between '20180228 00:00:00.000' and '20180228 23:59:59'
select * from TBTeste02 where dt between '20180228 23:59:59' and '20180228 23:59:59.999' -- '20180301 00:00:00.000'
select * from TBTeste02 where dt between '20180228 23:59:59' and '20180228 23:59:59.995'

select * from TBTeste02 where dt between '20180228' and '20180229' -- '20180301 00:00:00.000'

select * from TBTeste02 where dt >= '20180228' and dt <= '20180228 23:59:59.997'

select *, convert(varchar, dt, 112) as 'Data ISO' from TBTeste02 

select *, convert(varchar(6), dt, 112) as 'Ano e Mês ISO' from TBTeste02 

drop table TBTeste02 
---------------------------------------------------------------------------



---------------------------------------------------------------------------
-- DATA TIME FUNCTIONS
---------------------------------------------------------------------------
-- Verifica se a data eh valida
SELECT ISDATE('20180228') AS 'Data Válida',  -- Data valida
	   ISDATE('20180229') AS 'Data Inválida' -- Data nao valida

SELECT	YEAR('20180228') AS 'ano',
		MONTH('20180228') AS 'mes',
		DAY('20180228') AS 'dia'

SELECT	GETDATE() AS 'data atual do servidor',
		YEAR(GETDATE()) AS 'ano',
		MONTH(GETDATE()) AS 'mes',
		DAY(GETDATE()) AS 'dia'

SELECT	DATEPART(YEAR, GETDATE()) AS 'ano',
		DATEPART(mm, GETDATE()) AS 'mes',
		DATEPART(d, GETDATE()) AS 'dia'

SELECT	DATEPART(QUARTER, GETDATE()) AS 'Trimestre',
		DATEPART(DAYOFYEAR, GETDATE()) AS 'Dia no Ano',
		DATEPART(WEEK, GETDATE()) AS 'Semana no Ano',
		DATEPART(WEEKDAY, GETDATE()) AS 'Dia da Semana de Hoje', -- 1-Domingo, ... 7-Sábado
		DATEPART(WEEKDAY, '19990921') AS 'Dia da Semana de uma Data', -- 1-Domingo, ... 7-Sábado
		DATEPART(MILLISECOND, GETDATE()) AS 'Milisegundos' 

SELECT	DATEADD(YEAR, 1, GETDATE()) AS 'Data no próximo Ano',
		DATEADD(YEAR, -9, GETDATE()) AS 'Data a 9 anos atrás',
		DATEADD(DAY, 2, GETDATE()) AS 'Depois de Amanhã'

SELECT	DATEDIFF(YEAR, '20080519', '20100516') AS 'Diferença em Anos (+)',
		DATEDIFF(YEAR, '20100516', '20080519') AS 'Diferença em Anos (-)',
		DATEDIFF(DAY, '20080519', GETDATE()) AS 'Diferença em dias'
---------------------------------------------------------------------------





---------------------------------------------------------------------------
-- VARIÁVEIS
---------------------------------------------------------------------------

-- Declarando Variáveis I
Declare @contador int
Select @contador
go

Declare @qtd tinyint, @texto varchar(20)
Set @qtd = 5
Set @texto = 'Aula'
Select @qtd as Quantidade, @texto Aula, @texto 'Aula de BD'
Go

Declare @qtd tinyint, @texto varchar(20)
Select @qtd = 150, @texto = 'Aula 2'
Select @qtd, @texto
go


-- Declarando Variáveis II
Declare @contador int = 5
Set @contador = @contador + 2
Select @contador
go

Declare @contador1 smallint = 15, @contador2 tinyint = 100
Set @contador1 = @contador1 + 5
Set @contador2 = @contador2 - 50
Select @contador1, @contador2, @contador1 * @contador2
go

Declare @contador1 smallint = 15, @contador2 tinyint = 100
Select @contador1 = @contador1 + 5, @contador2 = @contador2 - 50
Select @contador1, @contador2, @contador1 * @contador2
go



-- Declarando Variáveis III
Declare @contador int = 5
Set @contador += 2
Select @contador
go

Declare @contador1 smallint = 15, @contador2 tinyint = 100
Set @contador1 += 5
Set @contador2 -= 50
Select @contador1 * @contador2
go

Declare @qtd tinyint = 2, @texto varchar(20) = 'Aula'
select @qtd *= 20, @texto += '2'
Select @qtd, @texto
go

---------------------------------------------------------------------------





---------------------------------------------------------------------------
-- DEMONSTRAÇÃO DE FUNÇÕES APLICADAS
---------------------------------------------------------------------------
declare @texto varchar(30) = 'Rogério Vieira'

-- Pegando caracteres a esquerda, direita e extraindo bloco caracteres
SELECT	LEFT(@texto, 4) Esquerda,
		RIGHT(@texto, 3) as Direita,
		SUBSTRING(@Texto, 5, 3) as 'Bloco de Caracteres',
		LEN(@texto) as [Tamanho do texto]



-- Com a posição do espaço podemos encontrar primeiro nome e último nome
-- Rogério Vieira
-- 12345678901234 
-- CHARINDEX mais performatico que o LIKE
-- 

DECLARE @texto VARCHAR(30) = 'Rogério Vieira'

-- Encontrando o caracter ESPAÇO no texto
SELECT	CHARINDEX(' ', @texto) as [Posição do ESPAÇO]


declare		@texto varchar(30) = 'Rogério Vieira', 
		    @posicaoEspaco tinyint
set			@posicaoEspaco = charindex(' ', @texto)
select		@texto as 'Nome', @posicaoEspaco as 'Posição do ESPAÇO'
			, left(@texto, @posicaoEspaco - 1) as 'Primeiro Nome'
			, right(@texto, len(@texto) - @posicaoEspaco) as 'Último Nome'

-- Gil Gomes
-- 123456789

declare		@texto varchar(30) = 'Gil Gomes'
declare		@posicaoEspaco tinyint = charindex(' ', @texto), @tamanhoTexto tinyint = len(@texto)
select		@posicaoEspaco [Posição do Espaço], @tamanhoTexto 'Tamanho do Texto'



declare		@texto varchar(30) = 'Gil Gomes'
declare		@posicaoEspaco tinyint = charindex(' ', @texto), @tamanhoTexto tinyint = len(@texto)
declare		@primeiroNome varchar(30), @ultimoNome varchar(30)

-- Ajustando e mostrando variáveis
select  @primeiroNome = left(@texto, @posicaoEspaco - 1)
		, @ultimoNome = right(@texto, @tamanhoTexto - @posicaoEspaco)

select	@primeiroNome as 'Primeiro Nome', @ultimoNome as 'Último Nome'


/*
Adalgiza Albuquerque
12345678901234567890
*/


/*
euqreuqublA azigladA
12345678901234567890
*/
select reverse('Adalgiza Albuquerque')

select		left('Adalgiza Albuquerque', charindex(' ', 'Adalgiza Albuquerque') - 1) as 'Primeiro Nome'
			, reverse(left(reverse('Adalgiza Albuquerque'), charindex(' ', reverse('Adalgiza Albuquerque')) - 1)) as 'Último Nome'



-- Retirando Caracteres
select		replace('XPT-1234', '-', '') as 'Placa Padronizada'

declare		@cpf varchar(14) = '009.545.978-88'
select		replace(@cpf, '.', '') as 'Resultado Parcial'
select		replace(replace(@cpf, '.', ''), '-', '') as 'CPF sem Formato'

-- Concatenando
select 'Teste' + ' ' + 'de ' + 'concatenação'
select concat('Teste ',  'de', ' concatenação')
---------------------------------------------------------------------------