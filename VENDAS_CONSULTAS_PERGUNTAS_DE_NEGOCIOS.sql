-- Adicionando coluna data

alter table vendas_dio
add column Data_Venda date
after Status_Pedido;

-- Criando datas aleatorias para estudo

update vendas_dio
set Data_Venda = date(
    '2025-01-01' + interval floor(rand() * 60) day
    );
    

    -- Total de vendas por mes

select
  date_format(Data_Venda, '%Y-%m') as Mes,
  sum(Preco * Quantidade) as Total_mensal
  from vendas_dio
  group by Mes
  order by Mes;
  
--   Produtos mais vendidos

select Produto, sum(Quantidade) as Total_Qtd
from vendas_dio
group by Produto
order by Total_Qtd desc; 

-- Ticket médio por marketplace

/*O que essa consulta faz?
• 	SUM(Preco * Quantidade) → soma o valor total vendido por marketplace
• 	COUNT(*) → conta quantos pedidos aquele marketplace teve
• 	divide um pelo outro → ticket médio
• 	GROUP BY Marketplace → calcula por marketplace
• 	ORDER BY → coloca do maior para o menor */

select 
    Marketplace,
    round(sum(Preco * Quantidade) / count(*), 2) as Ticket_Medio
from vendas_dio
group by Marketplace
order by Ticket_Medio desc; 
   
-- Impacto do desconto nas vendas

select
'Desconto',
 round(sum(Preco * Quantidade),2) as Total
from vendas_dio
group by 'Desconto'
order by 'Desconto';

-- Avaliação média por marca

select Marca, 
round(avg(Avaliacao_Cliente),2) as Avaliacao_Media
from vendas_dio
group by Marca
order by Avaliacao_Media desc;

-- Status dos pedidos (taxa de cancelamento)

select Status_Pedido, count(*) as Total
from vendas_dio
group by Status_Pedido;

-- Clientes que mais compram

select Cliente_Nome, round(sum(Preco * Quantidade),2) as Total
from vendas_dio
group by Cliente_Nome
order by Total desc;
