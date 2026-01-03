#As operações CRUD em SQL são as quatro ações fundamentais para manipulação de dados em um banco
#Create (criar), Read (ler/consultar), Update (atualizar) e Delete (excluir)


insert into usuarios_dio 
values
(1, 'Joao Silva', 'joao@yahoo.com','Rua do amor, 55, Paraiso, São Paulo','1990-05-15'),
(2,' Maria Silva', 'mariazinha@gmail.com','Av São Sebastião, 256, Salvador Bahia', '1989-03-30'),
(3, 'Pedro Souza', 'pedro@example.com', 'Avenida C, 789, Cidade X, Estado Y','1998-02-10');

insert into viagens_destinos_dio (id, nome, descrição) values
(1, 'Praia Tartarugas', 'Uma bela praia com area branco e mar cristalino'),
(2, 'Cachoeira do Vale Verde', 'Uma cachoeira exuberante cercada por natureza'),
(3, 'Cidade Histórica de Pedra Alta', 'Uma cidade rica em história e arquitetura');

insert into viagens_reservas 
values
(1, 1, 2, '2023-07-10', 'confirmada'),
(2, 2, 1, '2023-08-05', 'pendente'),
(3, 3, 3, '2023-09-20', 'cancelada');

#COMANDO DE COMO SELECIONAR OS REGISTROS DE ESTÃO NAS TABELAS:

select * from usuarios_dio;

select * from viagens_destinos_dio;

select* from viagens_reservas;

# USANDO WHERE PARA FILTRAR APENAS PARA PROCURAR A INFORMAÇÃO PRECISA QUE VOCE QUER:

select * from usuarios_dio  where nome = 'Pedro Souza';

select * from usuarios_dio where data_nascimento = '1990-05-15';

#USANDO OPERADORES OU WILD CARD:

# LIKE = BUSCA POR PADRÃO NO TEXTO
# % VÁRIOS CARACTERES (OU NENHUM)
# - EXATAMENTE UM CARACTER

# Vai encontrar Joao Silva, mas também serviria para "Jorge", "Josiane", etc.
select * from usuarios_dio where nome like 'Jo%';

#Vai retornar joao@yahoo.com.
select * from usuarios_dio where email like '%yahoo.com';

# Vai retornar o endereço Rua do amor, 55, Paraiso, São Paulo.
select * from usuarios_dio where endereco like '%para%';




