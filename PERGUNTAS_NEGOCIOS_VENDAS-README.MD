# 📄 **README — Análises SQL do Dataset de Vendas**

Este projeto contém uma série de consultas SQL aplicadas a um dataset fictício de vendas, simulando o cenário de um e‑commerce (como Amazon, Mercado Livre, Magalu, etc.).  
O objetivo é **praticar SQL**, **responder perguntas de negócio** e **gerar dados para visualizações no Power BI**.

As consultas abaixo representam análises reais usadas por equipes de:

- Business Intelligence  
- Data Analytics  
- Marketing  
- Comercial  
- Logística  

---

# 📌 **1. Adicionando coluna de data**

```sql
ALTER TABLE vendas_dio
ADD COLUMN Data_Venda DATE
AFTER Status_Pedido;
```

### **Por que fiz isso?**
Para permitir análises temporais, como:

- vendas por mês  
- sazonalidade  
- comportamento de compra ao longo do tempo  

Datas são essenciais em qualquer análise de negócio.

---

# 📌 **2. Criando datas aleatórias para estudo**

```sql
UPDATE vendas_dio
SET Data_Venda = DATE(
    '2025-01-01' + INTERVAL FLOOR(RAND() * 60) DAY
);
```

### **Por que fiz isso?**
Como o dataset não tinha datas reais, gerei datas aleatórias entre janeiro e fevereiro de 2025 para:

- simular vendas reais  
- permitir análises mensais  
- treinar gráficos no Power BI  

---

# 📌 **3. Total de vendas por mês**

```sql
SELECT
  DATE_FORMAT(Data_Venda, '%Y-%m') AS Mes,
  SUM(Preco * Quantidade) AS Total_mensal
FROM vendas_dio
GROUP BY Mes
ORDER BY Mes;
```

### **Pergunta de negócio**
**Quanto vendemos por mês?**

### **Por que isso importa?**
- entender sazonalidade  
- prever demanda  
- planejar campanhas  
- ajustar estoque e logística  

---

# 📌 **4. Produtos mais vendidos**

```sql
SELECT Produto, SUM(Quantidade) AS Total_Qtd
FROM vendas_dio
GROUP BY Produto
ORDER BY Total_Qtd DESC;
```

### **Pergunta de negócio**
**Quais produtos têm maior saída?**

### **Por que isso importa?**
- reposição de estoque  
- destaque no site  
- campanhas de marketing  
- negociação com fornecedores  

---

# 📌 **5. Ticket médio por marketplace**

```sql
SELECT 
    Marketplace,
    ROUND(SUM(Preco * Quantidade) / COUNT(*), 2) AS Ticket_Medio
FROM vendas_dio
GROUP BY Marketplace
ORDER BY Ticket_Medio DESC;
```

### **Pergunta de negócio**
**Qual marketplace traz clientes que gastam mais?**

### **Por que isso importa?**
- definir onde investir em anúncios  
- entender comportamento do cliente  
- negociar taxas com marketplaces  
- identificar canais mais rentáveis  

---

# 📌 **6. Impacto do desconto nas vendas**

```sql
SELECT
  'Desconto',
  ROUND(SUM(Preco * Quantidade),2) AS Total
FROM vendas_dio
GROUP BY 'Desconto'
ORDER BY 'Desconto';
```

### **Pergunta de negócio**
**Descontos aumentam o volume vendido?**

### **Por que isso importa?**
- planejar promoções  
- entender elasticidade de preço  
- avaliar impacto no faturamento  

*(Obs.: essa consulta pode ser melhorada depois — mas está aqui como parte do estudo.)*

---

# 📌 **7. Avaliação média por marca**

```sql
SELECT Marca, 
ROUND(AVG(Avaliacao_Cliente),2) AS Avaliacao_Media
FROM vendas_dio
GROUP BY Marca
ORDER BY Avaliacao_Media DESC;
```

### **Pergunta de negócio**
**Quais marcas têm melhor reputação?**

### **Por que isso importa?**
- identificar marcas problemáticas  
- melhorar catálogo  
- negociar qualidade com fornecedores  
- entender satisfação do cliente  

---

# 📌 **8. Status dos pedidos (taxa de cancelamento)**

```sql
SELECT Status_Pedido, COUNT(*) AS Total
FROM vendas_dio
GROUP BY Status_Pedido;
```

### **Pergunta de negócio**
**Quantos pedidos são entregues, cancelados ou devolvidos?**

### **Por que isso importa?**
- medir eficiência logística  
- identificar problemas de entrega  
- reduzir cancelamentos  
- melhorar experiência do cliente  

---

# 📌 **9. Clientes que mais compram**

```sql
SELECT Cliente_Nome, ROUND(SUM(Preco * Quantidade),2) AS Total
FROM vendas_dio
GROUP BY Cliente_Nome
ORDER BY Total DESC;
```

### **Pergunta de negócio**
**Quem são nossos melhores clientes?**

### **Por que isso importa?**
- campanhas de fidelização  
- programas de pontos  
- segmentação de marketing  
- análise de comportamento  

---

# 🎯 **Resumo do Projeto**

Este repositório demonstra:

- domínio de SQL  
- capacidade de responder perguntas de negócio  
- preparação de dados para Power BI  
- análises reais usadas em empresas  
- organização profissional de consultas  



