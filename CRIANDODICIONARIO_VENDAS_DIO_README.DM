Este repositório documenta a criação de um **dicionário de dados** para a tabela `dataset_vendas_dio` em MySQL.  
A ideia é ter um material simples, didático e fácil de consultar sempre que eu precisar lembrar:

- o que cada coluna significa  
- qual o tipo de dado  
- qual o tamanho máximo  
- como usar cada campo corretamente  

---

## 🎯 Objetivo

Criar um **dicionário de dados próprio** (em forma de tabela) para a base `dataset_vendas_dio`, usando:

- o dicionário interno do MySQL (`information_schema`)
- a estrutura da tabela (`SHOW COLUMNS`)
- uma tabela de documentação (`dicionario_dataset_vendas`)

---

## 1. Consultando a estrutura da tabela no MySQL

Antes de documentar, eu preciso **entender como a tabela foi criada**.

### 1.1. Consultar metadados no `information_schema`

```sql
SELECT *
FROM information_schema.columns
WHERE table_schema = 'excel_dio'
  AND table_name = 'dataset_vendas_dio';
```

**Para que serve?**

- Ver todas as colunas da tabela
- Ver tipos de dados, se aceitam `NULL`, tamanho, etc.
- Entender a estrutura técnica da tabela

---

### 1.2. Ver a estrutura com `SHOW COLUMNS`

```sql
SHOW COLUMNS FROM dataset_vendas_dio;
```

**Para que serve?**

- Visualizar rapidamente:
  - nome da coluna
  - tipo
  - se aceita `NULL`
  - se é chave primária
  - se é `auto_increment`

Exemplo de saída (resumida):

| Field            | Type           | Null | Key | Default | Extra          |
|------------------|----------------|------|-----|---------|----------------|
| ID_Vendas        | int            | NO   | PRI | NULL    | auto_increment |
| Pedido_ID        | int            | YES  |     | NULL    |                |
| Cliente_Nome     | varchar(100)   | YES  |     | NULL    |                |
| Produto          | varchar(150)   | YES  |     | NULL    |                |
| Marca            | varchar(100)   | YES  |     | NULL    |                |
| Preco            | decimal(10,2)  | YES  |     | NULL    |                |
| Desconto(%)      | int            | YES  |     | NULL    |                |
| Quantidade       | int            | YES  |     | NULL    |                |
| Total de vendas  | decimal(10,2)  | YES  |     | NULL    |                |
| Marketplace      | varchar(100)   | YES  |     | NULL    |                |
| Forma_Pagamento  | varchar(100)   | YES  |     | NULL    |                |
| Status_Pedido    | varchar(100)   | YES  |     | NULL    |                |
| Data_Compra      | date           | YES  |     | NULL    |                |
| CEP_Entrega      | varchar(20)    | YES  |     | NULL    |                |
| Avaliacao_Cliente| int            | YES  |     | NULL    |                |
| Comentario       | text           | YES  |     | NULL    |                |

---

## 2. Criando a tabela de dicionário de dados

Agora que eu sei a estrutura técnica, eu crio uma tabela só para **documentar o significado** das colunas.

```sql
CREATE TABLE dicionario_dataset_vendas (
    coluna    VARCHAR(100),
    tipo      VARCHAR(50),
    descricao VARCHAR(255)
);
```

**Ideia:**

- `coluna`: nome da coluna na tabela original  
- `tipo`: tipo de dado (igual ao da tabela)  
- `descricao`: explicação em linguagem humana, clara e objetiva  

---

## 3. Preenchendo o dicionário com as colunas da tabela

Aqui eu insiro, manualmente, a descrição de cada campo da tabela `dataset_vendas_dio`.

```sql
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
```

---

## 4. Como usar esse dicionário na prática

Sempre que eu tiver dúvida sobre a tabela `dataset_vendas_dio`, posso consultar:

```sql
SELECT *
FROM dicionario_dataset_vendas;
```

Esse dicionário me ajuda a:

- lembrar o que cada coluna significa  
- saber o tipo e o tamanho dos campos  
- evitar erros ao inserir ou transformar dados  
- entender melhor a base antes de criar análises, relatórios ou dashboards  

Exemplos de uso prático:

- Ver se um campo de texto suporta nomes longos (`varchar(100)`, `varchar(150)`, etc.)
- Entender se um campo é valor unitário ou total (`Preco` x `Total de vendas`)
- Saber se um campo é avaliação do cliente ou status do pedido
- Ter uma visão clara da base sem precisar abrir os dados o tempo todo




