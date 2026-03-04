# 📘 **README — Projeto SQL: Criação, Limpeza e Correção de Dados da Tabela `vendas_dio`**

Este documento descreve todas as etapas realizadas para criar a tabela `vendas_dio`, importar dados, identificar problemas de codificação (encoding), corrigir textos quebrados e validar a integridade dos dados.  
O objetivo foi construir uma base limpa e consistente para análises posteriores.

---

# 🧱 **1. Criação da Tabela**

A tabela foi criada do zero após remover versões anteriores:

```sql
DROP TABLE vendas_dio;

CREATE TABLE vendas_dio(
    Pedido_Id INT,
    Cliente_Nome VARCHAR(255),
    Produto VARCHAR(255),
    Marca VARCHAR(100),
    Preco DECIMAL(10,2),
    Desconto INT,
    Quantidade INT,
    Marketplace VARCHAR(100),
    Forma_Pagamento VARCHAR(100),
    Status_Pedido VARCHAR(100),
    CEP_Entrega VARCHAR(9),
    Avaliacao_Cliente TINYINT,
    Comentario TEXT
);
```

---

# 📊 **2. Consultas Básicas**

Visualização dos dados:

```sql
SELECT * FROM vendas_dio;
```

Contagem de registros:

```sql
SELECT COUNT(*) FROM vendas_dio;
```

Limpeza da tabela sem apagar estrutura:

```sql
TRUNCATE TABLE vendas_dio;
```

---

# 🌐 **3. Configuração de Encoding da Conexão**

Para garantir que novos dados fossem interpretados corretamente:

```sql
SET NAMES utf8mb4;
```

Verificação do charset da tabela:

```sql
SHOW TABLE STATUS LIKE "vendas_dio";
```

---

# 🐛 **4. Identificação de Problemas de Encoding**

Alguns textos foram importados com acentos quebrados (ex.: `Ã£`, `Ã©`, `Ã´`).  
Para localizar esses registros:

```sql
SELECT DISTINCT Produto
FROM vendas_dio
WHERE Produto LIKE '%Ã%';
```

---

# 🛠️ **5. Correção de Textos Quebrados (colunas específicas)**

### **Produto**
```sql
UPDATE vendas_dio
SET Produto = REPLACE(Produto, 'Teclado MecÃ¢nico', 'Teclado Mecânico');
```

### **Forma de Pagamento**
```sql
UPDATE vendas_dio
SET Forma_Pagamento = REPLACE(Forma_Pagamento, 'CartÃ£o de CrÃ©dito', 'Cartão de Credito');
```

### **Tentativa de corrigir Avaliação (não havia erro nessa coluna)**
```sql
UPDATE vendas_dio
SET Avaliacao_Cliente = REPLACE(Avaliacao_Cliente, 'Produto incrÃ­vel!', 'Produto incrivel!');
```

Essa tentativa não alterou nada porque o texto quebrado estava na coluna **Comentario**, não em **Avaliacao_Cliente**.

---

# 💬 **6. Identificação de Comentários com Encoding Quebrado**

```sql
SELECT DISTINCT Comentario
FROM vendas_dio
WHERE Comentario LIKE '%Ã%';
```

Foram encontrados textos como:

- `Ã“tima qualidade!`
- `Produto incrÃ­vel!`
- `NÃ£o recomendo.`

---

# 🔧 **7. Correção Definitiva dos Comentários**

Para corrigir encoding quebrado (latin1 → utf8mb4):

```sql
UPDATE vendas_dio
SET Comentario = CONVERT(
        CAST(CONVERT(Comentario USING latin1) AS BINARY)
    USING utf8mb4
)
WHERE Comentario LIKE '%Ã%';
```

Esse comando reconverte corretamente todos os acentos.

---

# 🎯 **8. Resultado Final**

Após todas as correções:

- A tabela está limpa  
- Todos os acentos foram restaurados  
- O encoding está padronizado  
- Os dados estão prontos para análise  


