-- 1. Consultar a estrutura da tabela (dicionário interno do MySQL)
/*Esses comandos servem para ver como a tabela foi criada, quais colunas existem, tipos, tamanhos, se aceitam NULL, etc.*/
dataset_vendas_dio
SELECT *
FROM information_schema.columns
WHERE table_schema = 'excel_dio'
AND table_name = 'dataset_vendas_dio';

/*Entender a estrutura da tabela antes de inserir, alterar ou analisar dados*/

show columns from dataset_vendas_dio;


-- 2. Criar seu próprio dicionário de dados
/*O dicionário interno do MySQL mostra estrutura técnica, mas não mostra o significado das colunas.
Por isso criamos um dicionário manual.*/

create table dicionario_dataset_vendas(
coluna varchar(100),
tipo varchar (50),
descricao varchar (255)
);    #Documentar o que cada coluna significa, para evitar erros e facilitar análises futuras.


-- 3. Preencher o dicionário com as colunas da tabela
/*Aqui você descreve cada coluna com palavras humanas, não técnicas.*/

INSERT INTO dicionario_dataset_vendas (coluna, tipo, descricao) VALUES
('ID_Vendas', 'int', 'Identificador único da venda'),
('Pedido_ID', 'int', 'Código do pedido original'),
('Cliente_Nome', 'varchar(100)', 'Nome do cliente que realizou a compra'),
('Produto', 'varchar(150)', 'Nome do produto vendido'),
('Marca', 'varchar(100)', 'Marca do produto'),
('Preco', 'decimal(10,2)', 'Preço unitário do produto'),
('Desconto(%)', 'int', 'Percentual de desconto aplicado'),
('Quantidade', 'int', 'Quantidade comprada'),
('Total de vendas', 'decimal(10,2)', 'Valor total da venda após desconto'),
('Marketplace', 'varchar(100)', 'Plataforma onde a venda foi realizada'),
('Forma_Pagamento', 'varchar(100)', 'Método de pagamento utilizado'),
('Status_Pedido', 'varchar(100)', 'Status atual do pedido'),
('Data_Compra', 'date', 'Data em que a compra foi realizada'),
('CEP_Entrega', 'varchar(20)', 'CEP de entrega do pedido'),
('Avaliacao_Cliente', 'int', 'Nota dada pelo cliente'),
('Comentario', 'text', 'Comentário deixado pelo cliente');

-- 📌 Objetivo:
/* uma tabela de referência para você consultar sempre que tiver dúvida sobre:
• 	tamanho máximo permitido
• 	tipo de dado
• 	significado da coluna
• 	como usar cada campo corretamente*/
