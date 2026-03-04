-- Remove completamente a tabela anterior, permitindo recriar do zero.

drop table vendas_dio;

-- Cria a estrutura da tabela com todas as colunas necessárias para armazenar pedidos, produtos, avaliações e comentários.

create table vendas_dio(
Pedido_Id int,
Cliente_Nome varchar (255),
Produto varchar (255),
Marca varchar (100),
Preco decimal(10,2),
Desconto int,
Quantidade int,
Marketplace varchar (100),
Forma_Pagamento varchar (100),
Status_Pedido varchar (100),
CEP_Entrega varchar (9),
Avaliacao_Cliente tinyint,
Comentario text
);

-- Visualizar dados

select *from vendas_dio;

-- Contar registros

SELECT COUNT(*) FROM vendas_dio;

-- Limpar a tabela sem apagar a estrutura

truncate table vendas_dio;

-- Garantir que a conexão usa UTF‑8
-- Isso evita que novos dados sejam importados com acentos quebrados.

set NAMES utf8mb4;

-- Aqui você confirmou que a tabela está em , o que é correto.

show table status like "vendas_dio";

/* Identificação de textos quebrados (problemas de encoding)
Buscar produtos com acentos quebrados */

select distinct Produto
from vendas_dio
where Produto like '%Ã%';

/* Correção de textos quebrados (colunas específicas)
Corrigir produto*/

update vendas_dio
set Produto = replace(Produto,  'Teclado MecÃ¢nico', 'Teclado Mecânico');

update vendas_dio
set Forma_Pagamento = replace(Forma_Pagamento, 'CartÃ£o de CrÃ©dito', 'Cartão de Credito');

update vendas_dio
set Avaliacao_Cliente = replace(Avaliacao_Cliente, 'Produto incrÃ­vel!', 'Produto incrivel!');

select distinct Comentario
from vendas_dio
where Comentario like '%Ã%';


/*Correção de comentários com reconversão de encoding
Correção definitiva */

update vendas_dio
set Comentario = convert(
        cast(convert(Comentario using latin1) as binary)
        using utf8mb4
        )
where Comentario like '%Ã%';     

