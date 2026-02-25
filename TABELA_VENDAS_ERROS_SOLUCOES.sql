# Como contar colunas 
select count(*) as total_columns
from information_schema.columns
where table_schema ='excel_dio'
and table_name ='dataset_vendas_dio';

#Como ver os nomes das colunas

show columns from excel_dio.dataset_vendas_dio;

#Listar todas as tabelas do banco de dados

select excel_dio
from information_schema.tables
where table_schema ='excel_dio';

#Ver se tem chave primaria

select column_name
from information_schema.key_column_usage
where table_name ='dataset_vendas_dio'
and constraint_name = 'primary';

#Como inserir chave primaria, mas antes se certificar que não existem valores repetidos
#Nem existe NULL

SELECT pedido_id, COUNT(*) AS qtd
FROM dataset_vendas_dio
GROUP BY pedido_id
HAVING COUNT(*) > 1;   #Se esse SELECT não retornar nada, está tudo certo.


#Como verificar se existe NULL

select count(*) as nulls
from dataset_vendas_dio
where pedido_id is null;  #Se o resultado for 0, você pode seguir.

select *from dataset_vendas_dio

#Aqui add uma chave primaria unica já que o mesmo cliente fez compras de produtos diferentes

ALTER TABLE dataset_vendas_dio
add column ID_Vendas int not null auto_increment,
add primary key (ID_Vendas)

#Quando você adiciona uma coluna nova com , o MySQL coloca sempre no final da tabela, a menos que você diga explicitamente onde quer que ela fique.
#Como mover a coluna para a primeira posição

ALTER TABLE dataset_vendas_dio
MODIFY COLUMN ID_Vendas int not null auto_increment first;

#Se quiser colocar a coluna em outra posição (ex.: depois de outra coluna).Não foi o caso

ALTER TABLE dataset_vendas_dio
MODIFY COLUMN ID_Vendas INT NOT NULL AUTO_INCREMENT AFTER Cliente_Nome;


