/*
Com o modelo adicionado de Cliente, Vendas2013, Vendas2014 e Vendas2015:
*/
/*
1. Crie uma fun��o onde possamos passar qualquer data e nos retorne o 
dia da semana (2a.feira, 3a.feira, ...).
*/
-- drop function dbo.RetornarDiaDaSemana
create function dbo.RetornarDiaDaSemana (@data date)
returns varchar(20)
as
begin
	declare @RetornarDiaDaSemana varchar(20)
	select @RetornarDiaDaSemana = case DATEPART(weekday, @data)
									when 1 then 'Domingo'
									when 2 then '2a. feira'
									when 3 then '3a. feira'
									when 4 then '4a. feira'
									when 5 then '5a. feira'
									when 6 then '6a. feira'
									when 7 then 'S�bado'
								end
	return @RetornarDiaDaSemana
end
go

select dbo.RetornarDiaDaSemana(GETDATE())



/*
2. Com a fun��o criada, fa�a um SELECT em Cliente, 
mostrando o dia da semana em que cada cliente nasceu.
*/
select top 10 * from Cliente

select dbo.RetornarDiaDaSemana(dtNascimento) from Cliente


/*
3. Com a mesma fun��o, agrupe pelo dia da semana e veja 
quantos clientes nasceram em cada dia. Ordene pela quantidade de 
forma descendente.
*/
select	dbo.RetornarDiaDaSemana(dtNascimento) as DiadaSemana
		, COUNT(*) as qtd
from	Cliente
group by dbo.RetornarDiaDaSemana(dtNascimento)
order by qtd desc

/*
4. Usando a fun��o, retorne somente os clientes que nasceram 
no s�bado ou domingo.
*/
select	*, dbo.RetornarDiaDaSemana(dtNascimento) as DiadaSemana
from	Cliente 
where	dbo.RetornarDiaDaSemana(dtNascimento) in ('S�bado', 'Domingo')


/*
5. Crie a fun��o fcVeiculo que traga distintamente todas as descri��es 
dos ve�culos, com seus respectivos modelos e nomes dos fabricantes.
*/
-- drop function fcVeiculo 
create function fcVeiculo()
returns table
as
return
	(
	select	distinct 
			V.descricao as Veiculo, M.Descricao as Modelo, F.Nome as Fabricante
	from	Veiculo V	inner join Modelo M on V.idModelo = M.idModelo
						inner join Fabricante F on F.idFabricante = V.idFabricante
	)
go

select * from fcVeiculo()

/*
6. Crie uma fun��o onde passando o sexo, retorne todas as 
informa��es dos clientes respectivos.
*/
select * from cliente
-- drop function fcGenero
create function fcGenero(@sexo bit)
returns table
as 
return
	(
	select * from Cliente where sexo = @sexo
	)
go

select * from fcGenero(1)



/*
7. Crie uma fun��o onde passando o n�mero do cliente, 
retorne todas as informa��es do cliente, as respectivas 
vendas feitas entre 2013 e 2015 (usar tabelas Vendas2013, ...), 
nomes do ve�culo, nome do modelo, nome do Fabricante, 
data da venda e valor do ve�culo.
*/
select top 1 * from Cliente
select top 1 * from Vendas2014

-- drop function fcInfoVendasCliente
create function fcInfoVendasCliente(@idCliente tinyint)
returns table
as
return
	( 
	select	C.*, Vd.dataVenda, V.idVeiculo 
			,V.descricao as Veiculo, M.Descricao as Modelo, F.Nome as Fabricante
	from	Cliente C	inner join	(
									select idVeiculo, idCliente, dataVenda from Vendas2013 where idCliente = @idCliente
									union all 
									select idVeiculo, idCliente, dataVenda from Vendas2014 where idCliente = @idCliente
									union all 
									select idVeiculo, idCliente, dataVenda from Vendas2015 where idCliente = @idCliente
									) as Vd on C.idCliente = Vd.idCliente
						inner join Veiculo V on V.idVeiculo = Vd.idVeiculo	
						inner join Modelo M on V.idModelo = M.idModelo
						inner join Fabricante F on F.idFabricante = V.idFabricante
	where	C.idCliente = @idCliente
	)
go

select * from Cliente

select	idCliente, nome, sexo, dtNascimento, dataVenda, Veiculo
		, Modelo, Fabricante, idVeiculo 
from	fcInfoVendasCliente(8)

/*
8. Crie uma fun��o multi-statment que al�m de fazer o que a fun��o anterior, 
adicione os campos TotalVendasVeiculo2013, TotalVendasVeiculo2014 e 
TotalVendasVeiculo2015 e os preencha com o total de vendas para o 
determinado ve�culo, independente do cliente passado.
*/
-- drop function TotalVendasVeiculo
create function TotalVendasVeiculo (@idVeiculo int)
returns int
as
begin
	declare @qtd int

	select @qtd = (select COUNT(*) from Vendas2013 where idVeiculo = @idVeiculo)
				+ (select COUNT(*) from Vendas2014 where idVeiculo = @idVeiculo)
				+ (select COUNT(*) from Vendas2015 where idVeiculo = @idVeiculo)
				
	return @qtd
end
go

select dbo.TotalVendasVeiculo(47)
select * from Vendas2013 order by idVeiculo

-- drop function fcInfoVendasClienteTotal
create function fcInfoVendasClienteTotal(@idCliente tinyint)
returns @Info table (idCliente tinyint, nome varchar(100), sexo bit
					, dtNascimento date, dataVenda date, Veiculo varchar(20)
					, Modelo varchar(20), Fabricante varchar(20), idVeiculo int
					, TotalVendasVeiculo2013 int
					, TotalVendasVeiculo2014 int
					, TotalVendasVeiculo2015 int)
as
begin 
	-- Preenchendo valores iniciais
	insert @Info (	idCliente, nome, sexo, dtNascimento, dataVenda, Veiculo
					, Modelo, Fabricante, idVeiculo)
	select	idCliente, nome, sexo, dtNascimento, dataVenda, Veiculo
			, Modelo, Fabricante, idVeiculo 
	from	fcInfoVendasCliente(@idCliente)

	-- Complementando informa��es de Vendas
	declare @idVeiculoCount int = 0
	while exists(select * from @Info where idVeiculo > @idVeiculoCount)
	begin
		select @idVeiculoCount = min(idVeiculo) from @Info where idVeiculo > @idVeiculoCount
		update @Info set	TotalVendasVeiculo2013 = (select count(*) from Vendas2013 where idVeiculo = @idVeiculoCount)
							, TotalVendasVeiculo2014 = (select count(*) from Vendas2014 where idVeiculo = @idVeiculoCount)
							, TotalVendasVeiculo2015 = (select count(*) from Vendas2015 where idVeiculo = @idVeiculoCount)
		where idVeiculo = @idVeiculoCount
	end

	return
end
go

select * from Cliente


declare @idcliente tinyint = 1

select * from Vendas2013 where idCliente = @idcliente
select * from Vendas2014 where idCliente = @idcliente
select * from Vendas2015 where idCliente = @idcliente
select * from fcInfoVendasClienteTotal(@idcliente)
