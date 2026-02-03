
### README.md — Limpeza e Padronização do Dataset de Vendas (MySQL)

```markdown
# Dataset de Vendas – Limpeza e Padronização em MySQL

## 📌 Visão geral

Este repositório documenta o processo de limpeza, padronização e transformação de um dataset de vendas originalmente importado de um arquivo CSV para o MySQL.

O objetivo foi transformar uma planilha “crua” (com encoding quebrado, tipos errados e formatação inconsistente) em uma tabela pronta para análise, dashboards e estudos de SQL.

---

## 🗂 Estrutura da tabela final

Tabela principal: `dataset_vendas_dio`

| Coluna             | Tipo final       | Descrição                              |
|--------------------|------------------|----------------------------------------|
| `Pedido_ID`        | INT              | Identificador do pedido                |
| `Cliente_Nome`     | VARCHAR(100)     | Nome do cliente                        |
| `Produto`          | VARCHAR(150)     | Nome do produto                        |
| `Marca`            | VARCHAR(100)     | Marca do produto                       |
| `Preco`            | DECIMAL(10,2)    | Preço unitário do produto              |
| `Desconto(%)`      | INT              | Percentual de desconto                 |
| `Quantidade`       | INT              | Quantidade vendida                     |
| `Total de vendas`  | DECIMAL(10,2)    | Valor total da venda                   |
| `Marketplace`      | VARCHAR(100)     | Plataforma de venda                    |
| `Forma_Pagamento`  | VARCHAR(100)     | Forma de pagamento                     |
| `Status_Pedido`    | VARCHAR(100)     | Status do pedido                       |
| `Data_Compra`      | DATE             | Data da compra                         |
| `CEP_Entrega`      | VARCHAR(20)      | CEP de entrega                         |
| `Avaliacao_Cliente`| INT              | Avaliação do cliente (nota)            |
| `Comentario`       | TEXT             | Comentário do cliente                  |

---

## ⚠️ Problemas encontrados no CSV original

- **Encoding quebrado**:  
  - Exemplos: `MecÃ¢nico`, `CartÃ£o`, `CrÃ©dito`, `Ã“tima`
- **Tipos incorretos**:
  - Campos numéricos armazenados como `TEXT` (ex.: `Preco`, `Total de vendas`)
  - Datas como texto no formato brasileiro (`27/01/2025`)
- **Formatação monetária**:
  - Valores como: `R$ 1.046,68`
- **Campos vazios em colunas numéricas**:
  - `Avaliacao_Cliente` com `''` (string vazia)
- **Nomes de colunas com acentos, espaços e símbolos**:
  - Ex.: `Avaliação_Cliente`, `Desconto(%)`, `Total de vendas`

---

## 🧹 Passo a passo da limpeza e transformação

### 1. Ajuste de avaliações vazias

Transformar valores vazios em `NULL` antes de mudar o tipo:

```sql
UPDATE dataset_vendas_dio
SET Avaliacao_Cliente = NULL
WHERE Avaliacao_Cliente = '';
```

### 2. Limpeza de valores monetários

Remover `R$`, pontos de milhar e ajustar vírgula para ponto:

```sql
UPDATE dataset_vendas_dio
SET Preco = REPLACE(REPLACE(REPLACE(Preco, 'R$', ''), '.', ''), ',', '.'),
    `Total de vendas` = REPLACE(REPLACE(REPLACE(`Total de vendas`, 'R$', ''), '.', ''), ',', '.');
```

### 3. Conversão de datas

Converter datas do formato `DD/MM/YYYY` para `DATE`:

```sql
UPDATE dataset_vendas_dio
SET Data_Compra = STR_TO_DATE(Data_Compra, '%d/%m/%Y')
WHERE Data_Compra LIKE '%/%/%';
```

### 4. Padronização de CEP

Remover hífen do CEP:

```sql
UPDATE dataset_vendas_dio
SET CEP_Entrega = REPLACE(CEP_Entrega, '-', '');
```

### 5. Ajuste de tipos das colunas

Após a limpeza dos dados, os tipos foram ajustados em um único `ALTER TABLE`:

```sql
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
```

> Obs.: Em alguns casos, foi necessário ajustar nomes de colunas (ex.: `Avaliação_Cliente` → `Avaliacao_Cliente`) usando `RENAME COLUMN`.

---

## 🔁 Como reproduzir o processo

1. **Importar o CSV** para uma tabela bruta no MySQL (`dataset_vendas_dio`).

2. **Rodar os comandos de limpeza**:
   - Ajuste de avaliações vazias  
   - Limpeza de valores monetários  
   - Conversão de datas  
   - Padronização de CEP

3. **Rodar o `ALTER TABLE`** para ajustar os tipos das colunas.

4. (Opcional) **Padronizar nomes de colunas** removendo acentos e espaços.

---

## 🧰 Tecnologias utilizadas

- **Banco de dados:** MySQL
- **Fonte dos dados:** CSV
- **Linguagem:** SQL
- **Uso previsto:** Análises exploratórias, dashboards, estudos de SQL e modelagem de dados

---

## ✅ Status do dataset

- Dados limpos e padronizados  
- Tipos de colunas adequados para análise  
- Datas e valores monetários em formato correto  
- Estrutura pronta para consultas, relatórios e visualizações
