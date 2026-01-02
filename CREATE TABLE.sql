create table usuarios_dio (
ID int,
nome varchar (30) not null comment 'Nome do usuario',
email varchar(30) not null unique comment 'E-mail do usuario',
endereco varchar (50) not null,
data_nascimento date not null
);

create table viagens_dio(
id int comment 'identificador unico da reserva',
id_usuario int comment 'indentificador unicos da reserva',
id_destino int  comment 'referencia ao id do destino reserva',
dia_viagem date,
status varchar (50) default 'pendente' comment 'status da reserva(confirmado, pendente, cancelado)'
);

create table viagens_destinos_dio (
id int,
nome varchar (50) not null comment 'nome destino',
descrição varchar (50) not null comment 'descrição'
);








 