#A chave primária (PRIMARY KEY) no MySQL é um campo ou conjunto de campos usado para identificar de forma única cada registro em uma tabela.
#Características principais:
#Não pode ter valores duplicados.
#Não pode ser NULL .
#Garante a integridade dos dados.

#INSERINDO CHAVE PRIMARIA 

alter table usuarios_dio
modify column id int auto_increment,
add primary key (id);

alter table viagens_destinos_dio
modify column id int auto_increment,
add primary key (id);


#CODIGO RODADO PORQUE NO MEU BANDO DE DADOS HAVIA 3 IDS DIFERENTES, DEVIDO A TER INSERIDO DADOS EM DUPLICIDADE
SELECT id, COUNT(*) 
FROM viagens_destinos_dio 
GROUP BY id 
HAVING COUNT(*) > 1;

#CORRIGINDO O ERRO E APAGANDO AS DUPLICIDADES

SELECT * 
FROM viagens_destinos_dio 
WHERE id = 3;

#APAGANDO REGISTROS IGUAIS:
DELETE FROM viagens_destinos_dio 
WHERE id = 3 
LIMIT 3;  -- apaga dois e deixa só um

ALTER TABLE viagens_destinos_dio AUTO_INCREMENT = 1;

ALTER TABLE viagens_destinos_dio MODIFY COLUMN id INT;

#INSERINDO CHAVE PRIMARIA

alter table viagens_destinos_dio
modify column id int auto_increment,
add primary key (id);

#NÃO CONSEGUI INSERIR A CHAVE PRIMARIA, DROPEI A TABELA E REFIZ DE NOVO

CREATE TABLE viagens_destinos_dio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destino VARCHAR(100),
    data DATE
    );
#APAGUEI TABELA ANTERIOR E REFIZ JÁ COM A CHAVE PRIMARIA

CREATE TABLE VIAGENS_RESERVAS (
ID INT auto_increment PRIMARY KEY,
ID_USUARIO INT NOT NULL,
ID_DESTINO INT NOT NULL,
DIA_VIAGEM DATE NOT NULL,
CATEGORIA VARCHAR (50) COMMENT 'CANCELADO, REALIZADA, FEITA'
);

#INSERINDO DADOS NA TABELA
#COMO O CAMPO ID TEM AUTO INCREMENTO, VOCÊ PODE INSERIR AS INFORMAÇÕES DE ACORDO COM A ORDEM
#Com DEFAULT → só quando você inclui o ID na lista de valores.
#Sem  DEFAULT → basta não incluir o ID na lista de colunas, o banco gera sozinho.

insert into usuarios_dio
values (id,nome, email, data_nascimento, logradouro, numero, cidade, estado),
(default,'Jessica Reis', 'jessiquinha@gmail.com','1980-08-11',' Rua da Patria','311','Santos', 'Sao Paulo'),
(default, 'Paulo Barbosa', 'paulo256@uol.com','1980-06-25','Rua Celeiro','456','Osasco','Sao Paulo');

insert into viagens_destinos_dio (destino, descricao)
values
('Arrail do Cabo','2025-01-01');

insert into viagens_reservas (id_usuario, id_destino, dia_viagem, categoria)
values
(4,4,'2025-03-03','pendente'),
(5,5,'2025-04-30','cancelado'),
(6,6,'2025-09-13','realizada');

#CONFIRMANDO SE DADOS FORAM INSERIDOS:

select * from usuarios_dio;

select * from viagens_destinos_dio;

select*from viagens_reservas

#INSERINDO CHAVES ESTRANGEIRAS

#As chaves estrangeiras (FOREIGN KEY) no SQL servem para criar relações entre tabelas diferentes...
#garantindo que os dados fiquem consistentes e evitando informações inválidas.
#Ligação entre tabelas: Uma chave estrangeira conecta uma coluna de uma tabela à chave primária de outra.

#RESUMINDO:
#Integridade referencial: O banco de dados impede que você insira valores que não existam na tabela relacionada.
#Consistência dos dados: Evita erros como cadastrar uma venda para um cliente que não existe.
#Controle automático: Se você tentar apagar ou alterar um registro que está sendo usado em outra tabela,
#o banco pode bloquear ou atualizar automaticamente, dependendo das regras definidas.

#ADD CHAVE ESTRANGEIRA(FOREIGN KEY) NA TABELA "VIAGENS_RESERVAS" REFERENCIANDO A TABELA "USUARIOS_DIO"
#Em resumo: o ID da tabela USUARIOS_DIO  é a chave primária, 
#E o ID_USUARIO da tabela VIAGENS-RESERVAS é a chave estrangeira que cria a relação entre elas.

alter table viagens_reservas
add constraint fk_reservas_usuarios
foreign key (id_usuario) references usuarios_dio (id);

#ADD CHAVE ESTRANGEIRA NA TABELA 'VIAGENS_RESERVAS REFERENCIANDO A TABELA VIAGENS_DESTINOS_DIO

ALTER TABLE viagens_reservas
ADD CONSTRAINT fk_reservas_destinos
FOREIGN KEY (id_destino) REFERENCES viagens_destinos_dio(id);

#ALTERANDO A RESTRIÇÃO DA CHAVE ESTRANGEIRA "FK_RESERVAS_USUARIOS" NA TABELA RESERVA PARA ON, DELETE, CASCADE

alter table viagens_reservas
drop foreign key fk_reservas_usuarios;

alter table viagens_reservas
add constraint fk_reservas_usuarios
foreign key (id_usuario) references usuarios_dio (id)
on delete cascade;

#Esse código cria uma relação entre usuários e reservas, e garante que não fiquem reservas órfãs quando um usuário for excluído.
#É uma forma de manter a integridade referencial e automatizar a limpeza de dados relacionados.






