-- PROCEDURE


-----------------------------------------------------------------------------------------------------
-- Descri��o: Para ambiente de testes, cria uma tabela tempor�ria baseada nos ve�culos que tiveram 
--			  compra dentro da faixa de datas fornecidas	
-- Par�metros: @dataCompraInicial - Obrigat�rio, representa in�cio da faixa de datas para a compra
--			   @dataCompraFinal - Opcional, representa o final do per�odo de compra	
-- Criador:		Sand Onofre						Data: 20150308
-- Altera��es:	Sand Onofre						Data: 20200509

-- Exemplo de uso: exec TesteTemporaria '20130101', NULL
-----------------------------------------------------------------------------------------------------
create procedure dbo.TesteTemporaria @dataCompraInicial date, @dataCompraFinal date 
as
begin
	-- Se Data final n�o fornecida, usar data atual
	if  @dataCompraFinal is null
		set @dataCompraFinal = getdate()

	-- Criando Tabela tempor�ria GLOBAL para testes
	create table ##VeiculoGlobal 
	(idVeiculo tinyint primary key, Veiculo varchar(20), Fabricante varchar(20), Modelo varchar(20), Compra date)

	--Inserir na tabela tempor�ria com Informa��es necess�rias para teste
	insert	##VeiculoGlobal (idVeiculo, Veiculo, Fabricante, Modelo, Compra)
	select	V.idVeiculo, V.descricao, F.nome, M.descricao, v.dataCompra  
	from	Veiculo as V inner join Fabricante as F on V.idFabricante = F.idFabricante
						 inner join Modelo as M on V.idModelo = M.idModelo
	where	V.datacompra between @dataCompraInicial and @dataCompraFinal
	
	print 'Tabela ##VeiculoGlobal pronta para testes (select * from ##VeiculoGlobal) !'
end
go

select * from Veiculo

select * from sys.procedures
sp_helptext 'TesteTemporaria'

exec dbo.TesteTemporaria '20130101', '20200101'

select * from ##VeiculoGlobal
drop table ##VeiculoGlobal
---------------------------------------------------------------------------------------------------------------




----------------------------------------------------------------------------------------------------------------
-- TRIGGER
----------------------------------------------------------------------------------------------------------------
-- drop trigger trg_D_VendasAnuais
create trigger trg_D_VendasAnuais
on VendasAnuais
after delete
as
begin
	print 'Registros de Vendas Anuais n�o podem ser eliminados !'
	rollback transaction
end
go

sp_helptrigger VendasAnuais

sp_helptext trg_D_VendasAnuais

select * from VendasAnuais

select * from  VendasAnuais where idVendas > 1300
delete VendasAnuais where idVendas > 1300

----------------------------------------------------------------------------------------------------------------
