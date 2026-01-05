#INSERINDO DADOS NA TABELA

insert into viagens_reservas (id_usuario, id_destino, dia_viagem, categoria)
values
(7,7,'2025-08-12','cancelado'),
(7,7,'2024-07-17', 'pendente');

#INNER JOIN, USADO PARA RELACIONAR DADOS DE DUAS OU MAIS TABELAS COM BASE EM CHAVE COMUM

select 
*from usuarios_dio as us
inner join viagens_reservas as re
on us.id = re.id_usuario;

#RIGHT JOIN, serve para trazer todos os registros da tabela da direita na junção, mesmo que não tenham correspondência na tabela da esquerda.

select* from viagens_reservas as res
right join viagens_destinos_dio as des
on des.id =res.ID_DESTINO;

# AQUI ESTOU ADD UM NOVA COLUNA VIAGENS_DESTINOS_DIO

alter table viagens_destinos_dio
add descricao_viagem varchar (50) after destino;

#EXCLUINDO COLUNA ANTIGA QUE NÃO FAZIA SENTIDO

alter table viagens_destinos_dio
drop column descricao;

#SUBCONSULTA  PARA ENCONTRAR OS DESTINOS MENOS POPULARES (COM MENOS RESERVAS)

select destino
from viagens_destinos_dio
where id not in (select id_destino from viagens_reservas)
order by id;



