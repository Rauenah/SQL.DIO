#CRIANDO TABELA NOVA

create table usuarios_nova(
id int,
nome varchar (255) not null comment 'Nome do usúario',
email varchar (255) not null unique comment 'Endereço de email do usuario',
data_nascimento date not null,
logradouro varchar (255),
numero varchar (50),
cidade varchar (50),
estado varchar (50)
);

#Migrando dados da primeira tabela feita

insert into usuarios_nova
select* from usuarios_dio;

# VERIFICANDO SE DADOS FORAM TRANSFERIDOS
select * from usuarios_nova;

#APAGANDO TABELA ANTERIOR

drop table usuarios_dio;

#RENOMEANDO TABELA NOVA:
alter table usuarios_nova rename usuarios_dio;

#ALTERAR TAMANHO COLUNA LOGRADOURO:
alter table usuarios_dio modify column logradouro varchar (100);