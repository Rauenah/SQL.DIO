create database excel_dio;

select * from dataset_vendas_dio;

drop table dataset_vendas_dio;

#RENOMEANDO COLUNA

ALTER TABLE dataset_vendas_dio
RENAME COLUMN `ï»¿Pedido_ID` TO `Pedido_ID`,
RENAME COLUMN `AvaliaÃ§Ã£o_Cliente` TO `Avaliação_Cliente`,
RENAME COLUMN `ComentÃ¡rio` TO `Comentario`;

#Quando a gente importa CSV com encoding errado para o MySQL.
#O banco não “entende” os acentos e transforma tudo em caractere - MecÃ¢nico → Mecânico
#Isso pode ser mudado atráves de linha de comando ou baixando de novo e mudando o UTF-8 corretamente
#Nesse caso vou usar linha de comando

UPDATE dataset_vendas_dio
SET 
    Produto = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Produto,
        'Ã¡','a'),'Ã ','a'),'Ã£','a'),'Ã¢','a'),
        'Ã©','e'),'Ãª','e'),
        'Ã­','i'),
        'Ã³','o'),'Ã´','o'),'Ãµ','o'),

    Forma_Pagamento = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Forma_Pagamento,
        'Ã¡','a'),'Ã ','a'),'Ã£','a'),'Ã¢','a'),
        'Ã©','e'),'Ãª','e'),
        'Ã­','i'),
        'Ã³','o'),'Ã´','o'),'Ãµ','o'),

    Comentario = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Comentario,
        'Ã¡','a'),'Ã ','a'),'Ã£','a'),'Ã¢','a'),
        'Ã©','e'),'Ãª','e'),
        'Ã­','i'),
        'Ã³','o'),'Ã´','o'),'Ãµ','o');
        
        
 #Antes de alterar tipos de coluna que vierem como texto, é necessário que os dados estão no formato correto
 #Por exemplo, preço sem “R$”, datas no formato YYYY‑MM‑DD etc.
 
 #Primeiro: padronize os dados que estão como texto, Preco, Total de vendas 'R$ 1.046,68'

UPDATE dataset_vendas_dio
SET Preco = REPLACE(REPLACE(Preco, 'R$', ''), ',', '.'),
    `Total de vendas` = REPLACE(REPLACE(`Total de vendas`, 'R$', ''), ',', '.');
 
 #Alterando Data_Compra que estava assim 27/01/2025, para o formato em ingles 2025-01-27:
 
 UPDATE dataset_vendas_dio
SET Data_Compra = STR_TO_DATE(Data_Compra, '%d/%m/%Y');

#Removendo hífen do cep para numero
 
UPDATE dataset_vendas_dio
SET CEP_Entrega = REPLACE(CEP_Entrega, '-', '');

#Agora que os dados estão limpos podemos alterar os tipos de colunas em um unico comando:

ALTER TABLE dataset_vendas_dio
    MODIFY COLUMN Pedido_ID INT,
    MODIFY COLUMN Cliente_Nome VARCHAR(100),
    MODIFY COLUMN Produto VARCHAR(150),
    MODIFY COLUMN Marca VARCHAR(100),
    MODIFY COLUMN Preco DECIMAL(10,2),
    MODIFY COLUMN `Desconto(%)` INT,
    MODIFY COLUMN Quantidade INT,
    MODIFY COLUMN `Total de vendas` DECIMAL(10,2),
    MODIFY COLUMN Marketplace VARCHAR(100),
    MODIFY COLUMN Forma_Pagamento VARCHAR(100),
    MODIFY COLUMN Status_Pedido VARCHAR(100),
    MODIFY COLUMN Data_Compra DATE,
    MODIFY COLUMN CEP_Entrega VARCHAR(20),
    MODIFY COLUMN Avaliacao_Cliente INT,
    MODIFY COLUMN Comentario TEXT;
    
 #Quando rodei o comando acima deu erro porque alguns campos estão sem avaliação, ou seja Null
 #O SQL não consegue modificar para INT, precisamos verificar quantos campos estão vazios:
 
 SELECT *
FROM dataset_vendas_dio
WHERE Avaliacao_Cliente = '';

#Como corrigir os valores vazios antes do ALTER TABLE
# OPÇÃO A — Transformar vazios em NULL (recomendado)
#NULL significa “sem avaliação”, que é exatamente o caso.

UPDATE dataset_vendas_dio
SET Avaliacao_Cliente = NULL
WHERE Avaliacao_Cliente = '';

#Depois disso, o  funciona sem erro

ALTER TABLE dataset_vendas_dio
    MODIFY COLUMN Pedido_ID INT,
    MODIFY COLUMN Cliente_Nome VARCHAR(100),
    MODIFY COLUMN Produto VARCHAR(150),
    MODIFY COLUMN Marca VARCHAR(100),
    MODIFY COLUMN Preco DECIMAL(10,2),
    MODIFY COLUMN `Desconto(%)` INT,
    MODIFY COLUMN Quantidade INT,
    MODIFY COLUMN `Total de vendas` DECIMAL(10,2),
    MODIFY COLUMN Marketplace VARCHAR(100),
    MODIFY COLUMN Forma_Pagamento VARCHAR(100),
    MODIFY COLUMN Status_Pedido VARCHAR(100),
    MODIFY COLUMN Data_Compra DATE,
    MODIFY COLUMN CEP_Entrega VARCHAR(20),
    MODIFY COLUMN Comentario TEXT;
    
    #Não funcionou devido ao fato de eu ter renomeado a coluna e o sql entende como se ela não existisse
    #Como descobrir o nome REAL da coluna
    
    SHOW COLUMNS FROM dataset_vendas_dio;
    
#Se o nome correto for:

ALTER TABLE dataset_vendas_dio
MODIFY COLUMN Avaliacao_Cliente INT;
