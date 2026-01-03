#A instrução SQL UPDATE é usada para modificar registros existentes em uma tabela de banco de dados.

update usuarios_dio set endereco = 'Rua Elis Regina' where email = 'joao@yahoo.com';

select* from usuarios_dio where id = '1';  #CONSULTANDO PARA SABER SE MODIFICAÇÃO FOI FEITA.

#A instrução DELETE é um comando da Linguagem de Manipulação de Dados (DML) usado para remover linhas existentes de uma tabela.

delete from viagens_reservas where status = 'cancelado';

#VOU TER QUE RENOMEAR O NOME DA COLUNA STATUS:
alter table viagens_reservas rename column status to categoria;

#DELETANDO 
delete from viagens_reservas where categoria = 'cancelada';

select * from viagens_reservas;

#ADICIONANDO NOVAS COLUNAS NA TABELA USUARIOS:
alter table usuarios_dio
add Locadario varchar (10),
add Numero varchar (6),
add Cidade varchar (20),
add Estado varchar (50);

#CONSULTANDO ALTERAÇÃO:
select* from usuarios_dio;

#ALTERANDO COLUNA LOCADARIO QUE FOI ESCRITA ERRADA:
alter table  usuarios_dio rename column Locadario to Logradouro;

#SEPARANDO DADOS DA TABELA ORIGINAL PARA NOVAS COLUNAS ADICIONADAS COM O USO DA FUNÇÃO "SUBSTRING_INDEX"
#ISSO FUNCIONA PORQUE O ENDEREÇO ESTÁ SEPARADO POR VIRGULA
#SÓ FUNCIONA BEM SE TODOS OS REGISTROS SEGUEM O MESMO PADRÃO.
#SE ALGUNS ENDEREÇOS  ESTIVESSEM DIFERENTES (SEM NÚMERO, OU COM BAIRRO EXTRA), VOCÊ TERÁ QUE AJUSTAR MANUALMENTE OU CRIAR REGRAS EXTRAS.

update usuarios_dio
SET Logradouro = SUBSTRING_INDEX(endereco, ',', 1),
    Numero     = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 2), ',', -1),
    Cidade     = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 3), ',', -1),
    Estado     = SUBSTRING_INDEX(endereco, ',', -1);
    
#AUMENTAR TAMANHO DA COLUNA:
ALTER TABLE usuarios_dio MODIFY Logradouro VARCHAR(100);
ALTER TABLE usuarios_dio modify Numero varchar (30);

describe usuarios_dio;

#EXCLUSÃO COLUNA ENDEREÇO:
alter table usuarios_dio
drop column endereco;


insert into usuarios_dio 
values
(1, 'Joao Silva Santos', 'joao@gmail.com','1995-02-14',  'Rua do amor', '55', 'Paraiso','São Paulo');

delete from usuarios_dio
where email = 'joao@yahoo.com';