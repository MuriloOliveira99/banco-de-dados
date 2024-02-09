-----------------------------------------------------------------------------------------------
-- SUBQUERIES
-----------------------------------------------------------------------------------------------

-- Subquerie de Valor único (query mais interna retorna apenas um valor, apenas uma linha e uma coluna)
Select	* 
from	Veiculo
Where	idModelo =	(
					select	idModelo from Modelo where descricao = 'GS'
					)

-- Subquerie Multivalorada (query mais interna retorna duas ou mais linhas e somente uma coluna)
select	* 
from	Veiculo
where	idFabricante in	(
						select	idFabricante 
						from	Fabricante 
						where	nome = 'Honda' or nome = 'Yamaha'
						)







-----------------------------------------------------------------------------------------------
-- SUBQUERIES CORRELACIONADAS
-----------------------------------------------------------------------------------------------
Select	* 
from	VendasAnuais V
Where	idAnoDaVenda  in	(
							select	idAnoFabricacao 
							from	Veiculo 
							where	idVeiculo = V.idVeiculo 
									and valor > 30000
							)





-----------------------------------------------------------------------------------------------
-- EXISTS
-----------------------------------------------------------------------------------------------
select * from Fabricante

select	* 
from	Veiculo V
Where	exists  (
				select	* 
				from	Fabricante 
				where	idFabricante = V.idFabricante and UF = 'PE'
				)


select	* 
from	Veiculo V
Where	not exists  (
					select	* 
					from	Fabricante 
					where	idFabricante = V.idFabricante and UF = 'SP'
					)
-----------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------------------------
-- TABELAS TEMPORÁRIAS
--------------------------------------------------------------------------------------------------------------------------------
-- Local
create table #veiculo1 (idVeiculo int, valor decimal(9,2))

insert	#veiculo1 
select	idVeiculo, valor 
from	Veiculo where valor > 45000

select * from #veiculo1
-- drop table #veiculo1

-- Global
select	idVeiculo, valor 
into	##Veiculo2
from	Veiculo 
where	valor > 45000

select * from ##Veiculo2
-- drop table ##Veiculo2
--------------------------------------------------------------------------------------------------------------------------------





