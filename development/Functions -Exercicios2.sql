-- drop function dbo.RegresoDeLosMeses

create function dbo.RegresoDeLosMeses (@mes tinyint)
returns varchar(20)
as
begin
	declare @RegresoDeLosMeses varchar(20)

	-- Preencher variável somente se o dia estiver correto
	if @mes between 1 and 12
		set @RegresoDeLosMeses = choose(@mes, 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio'
											, 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre')

	return @RegresoDeLosMeses
end
go

	
select 	dbo.RegresoDeLosMeses(month(getdate()))

select 	dbo.RegresoDeLosMeses(1), dbo.RegresoDeLosMeses(12)
---------------------------------------------------------------------------------------------------------------







----------------------------------------------------------------------------------------------------------------
-- Demonstração de Função Multitabular
----------------------------------------------------------------------------------------------------------------

--------------------------------------------
-- INLINE TABLE-VALUED FUNCTION
--------------------------------------------
-- Drop function dbo.RetornarInfoPedido
create function dbo.RetornarInfoPedido (@orderId as smallint)
returns table
as
return
(
	select	O.orderid as 'Número do Pedido'
			, O.orderdate as 'Data'
			, C.contactname as 'Cliente'
			, P.productname as 'Produto'
			, OD.qty as 'Quantidade'
			, OD.unitprice as 'Valor do Produto'
			, (OD.qty * OD.unitprice) as 'Valor do Total do Item do Pedido'
	from	Sales.Orders as O 	inner join Sales.OrderDetails as OD on O.orderid = OD.orderid
								inner join Production.Products as P on OD.productid = P.productid
								inner join Sales.Customers as C on O.custid = C.custid
	where	O.orderId = @orderId
)
go

select top 10 orderid from Sales.Orders

select * from dbo.RetornarInfoPedido(10255)
--------------------------------------------




--------------------------------------------
-- MULTI-STATEMENT TABLE-VALUED FUNCTION
--------------------------------------------
-- Drop function dbo.RetornarInfoPedidoTotal
create function dbo.RetornarInfoPedidoTotal (@orderId as smallint)
returns @RetornarInfoPedidoTotal table	([Número do Pedido] smallint
										, [Data] date
										, Cliente varchar(30)
										, Produto varchar(50) 
										, Quantidade smallint
										, [Valor do Produto] decimal(9, 2)
										, [Valor do Total do Item do Pedido] decimal(9, 2)
										, [Valor do Total do Pedido] decimal(9, 2)
										)
as
begin

	-- Preencher informações iniciais
	insert @RetornarInfoPedidoTotal ([Número do Pedido], [Data], Cliente, Produto, Quantidade
									, [Valor do Produto], [Valor do Total do Item do Pedido])
	select * from dbo.RetornarInfoPedido(@orderId)

	-- Calculando Valor do Pedido 
	declare @totalPedido decimal(9, 2) = (select sum([Valor do Total do Item do Pedido]) from @RetornarInfoPedidoTotal)

	-- Atualizando registro
	update	@RetornarInfoPedidoTotal 
	set		[Valor do Total do Pedido] = @totalPedido

	return
end
go


--------------------------------------------
select top 10 orderid from Sales.Orders
select * from dbo.RetornarInfoPedidoTotal(10255)


----------------------------------------------------------------------------------------------------------------

