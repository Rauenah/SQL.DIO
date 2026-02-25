# README – Organização da tabela `dataset_vendas_dio` no MySQL

Este documento resume, passo a passo, tudo FEITO até aqui:  
os comandos, os erros, o que significam e o que APRENDI  
A ideia é que **EU** (ou qualquer pessoa leiga) consiga reler e entender.

---

## 1. Consultando metadados com `INFORMATION_SCHEMA`

### 1.1. O que é `INFORMATION_SCHEMA`?

- **Banco interno do MySQL** que guarda informações sobre:
  - **Tabelas**
  - **Colunas**
  - **Chaves**
  - **Bancos de dados**

Você não consulta “dados de vendas” nele, e sim **informações sobre as tabelas**.

### 1.2. Listar tabelas de um banco

Primeira tentativa (com erro):

```sql
SELECT excel_dio
FROM information_schema.tables
WHERE table_schme = 'excel_dio';
```

**Erros aqui:**

- **`table_schme`** → o correto é `table_schema`
- `excel_dio` não é uma coluna, então não pode ir no `SELECT`

Versão correta:

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'excel_dio';
```

**O que aprendemos:**

- `table_schema` = nome do banco de dados.
- `table_name` = nome das tabelas dentro desse banco.

---

## 2. Verificando duplicados e valores nulos

Você queria saber se podia usar `Pedido_ID` como chave primária.  
Para isso, precisava verificar:

- se havia **valores repetidos**
- se havia **valores nulos**

### 2.1. Verificar valores repetidos

Consulta:

```sql
SELECT pedido_id, COUNT(*) AS qtd
FROM dataset_vendas_dio
GROUP BY pedido_id
HAVING COUNT(*) > 1;
```

**Erros que apareceram no caminho:**

- Coluna escrita com nome diferente (`Pedido_ID` vs `pedido_id`).
- Solução: conferir o nome exato da coluna:

```sql
SHOW COLUMNS FROM dataset_vendas_dio;
```

**O que aprendemos:**

- Se o erro for `Unknown column 'Pedido_ID'`, quase sempre é:
  - nome diferente
  - maiúsculas/minúsculas
  - acentos ou underlines

### 2.2. Verificar valores nulos

Consulta:

```sql
SELECT COUNT(*) AS nulls
FROM dataset_vendas_dio
WHERE pedido_id IS NULL;
```

**Detalhe importante:**

- Alguns editores marcaram erro quando você escreveu `COUNT (*)` com espaço.
- Forma mais segura:

```sql
SELECT COUNT(*) AS nulls
FROM dataset_vendas_dio
WHERE pedido_id IS NULL;
```

**O que aprendemos:**

- O X vermelho no editor nem sempre significa que o SQL está errado.
- Mas é boa prática escrever funções assim: `COUNT(*)`, sem espaço.

---

## 3. Decidindo sobre a chave primária

### 3.1. Por que não usar `Pedido_ID` como chave primária?

Você percebeu que:

- Existem **nomes de clientes repetidos**.
- Existem **produtos repetidos**.
- Em vendas, é normal ter repetições.

Se `Pedido_ID` também tiver repetições ou não for confiável, **não é uma boa chave primária**.

**O que aprendemos:**

- Chave primária precisa ser:
  - **Única**
  - **Não nula**
  - Estável (não deve mudar)

### 3.2. Melhor solução: criar uma coluna de ID artificial

Você decidiu criar uma coluna só para ser chave primária, algo como `ID_Vendas`.

Comando:

```sql
ALTER TABLE dataset_vendas_dio
ADD COLUMN ID_Vendas INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (ID_Vendas);
```

**O que isso faz:**

- Cria a coluna `ID_Vendas`.
- Garante que ela nunca será nula.
- Faz o valor ser gerado automaticamente (1, 2, 3, 4…).
- Define como chave primária.

---

## 4. Movendo a coluna de chave primária de posição

Depois de criar `ID_Vendas`, ela ficou **na última posição**.  
Você quis colocá-la em outra posição.

### 4.1. Erro por causa de comentário

Você tentou:

```sql
#ALTER TABLE dataset_vendas_dio
MODIFY COLUMN ID_Venda INT NOT NULL AUTO_INCREMENT AFTER Cliente_Nome;
```

**Problema:**

- O `#` transforma a linha em **comentário**.
- O MySQL ignorou o `ALTER TABLE` e tentou executar só:

  ```sql
  MODIFY COLUMN ID_Venda INT NOT NULL AUTO_INCREMENT AFTER Cliente_Nome;
  ```

- Isso gera erro de sintaxe.

### 4.2. Erro por nome de coluna errado

Depois, você tentou:

```sql
ALTER TABLE dataset_vendas_dio
MODIFY COLUMN ID_Venda INT NOT NULL AUTO_INCREMENT AFTER Cliente_Nome;
```

Erro:

```text
Unknown column 'ID_Venda' in 'dataset_vendas_dio'
```

**Motivo:**

- A coluna se chama `ID_Vendas` (com S), não `ID_Venda`.

Você conferiu com:

```sql
SHOW COLUMNS FROM dataset_vendas_dio;
```

E viu:

- `ID_Vendas int AI PK`
- `Pedido_ID int`
- `Cliente_Nome varchar(100)`
- etc.

### 4.3. Comando correto para mover a coluna

Para colocar `ID_Vendas` depois de `Cliente_Nome`:

```sql
ALTER TABLE dataset_vendas_dio
MODIFY COLUMN ID_Vendas INT NOT NULL AUTO_INCREMENT AFTER Cliente_Nome;
```

Para colocar `ID_Vendas` como **primeira coluna**:

```sql
ALTER TABLE dataset_vendas_dio
MODIFY COLUMN ID_Vendas INT NOT NULL AUTO_INCREMENT FIRST;
```

**O que aprendemos:**

- `AFTER Nome_Coluna` → coloca a coluna depois de outra.
- `FIRST` → coloca a coluna como primeira.
- O nome da coluna precisa estar **idêntico** ao que está na tabela.

---

## 5. Chave primária simples vs composta (conceito)

Você perguntou quando usar:

- **Uma chave primária simples** (uma coluna só).
- **Uma chave primária composta** (duas colunas juntas).

### 5.1. Chave primária simples

Usada quando:

- Você tem uma coluna que identifica cada linha de forma única.
- Exemplo: `ID_Vendas`, `id_pedido`, `id_cliente`.

No seu caso:

- `ID_Vendas` é uma chave primária simples, artificial, perfeita para tabela de vendas.

### 5.2. Chave primária composta

Usada quando:

- A tabela representa uma **relação entre duas coisas**.
- Nenhuma coluna sozinha é única, mas a combinação é.

Exemplo em e-commerce:

- Tabela de **itens do pedido**:

  | pedido_id | produto_id | quantidade |
  |-----------|------------|------------|
  | 1001      | 10         | 1          |
  | 1001      | 20         | 2          |
  | 1002      | 10         | 1          |

  Aqui, a chave primária pode ser:

  ```text
  (pedido_id, produto_id)
  ```

Porque:

- Um pedido pode ter vários produtos.
- Um produto pode aparecer em vários pedidos.
- Mas o **mesmo produto não aparece duas vezes no mesmo pedido**.

### 5.3. No seu caso específico

Sua tabela `dataset_vendas_dio` é uma tabela de **vendas** (cada linha é uma venda).

- Não é uma tabela de relacionamento.
- Não tem combinação natural única.
- Faz todo sentido usar **uma chave primária simples** (`ID_Vendas`).

---

## 6. Resumo do que você aprendeu

- **Consultar metadados** com `INFORMATION_SCHEMA` para entender estrutura de tabelas.
- **Verificar duplicados** com `GROUP BY` + `HAVING COUNT(*) > 1`.
- **Verificar nulos** com `WHERE coluna IS NULL`.
- **Entender chave primária**:
  - precisa ser única e não nula.
  - não é boa ideia usar colunas que se repetem (como nomes, produtos, etc.).
- **Criar uma coluna de ID artificial** com `AUTO_INCREMENT` para ser chave primária.
- **Mover coluna de posição** com `MODIFY COLUMN ... FIRST/AFTER`.
- **Ler mensagens de erro** como:
  - `Unknown column` → nome errado.
  - `syntax error near` → comando incompleto ou linha comentada.



