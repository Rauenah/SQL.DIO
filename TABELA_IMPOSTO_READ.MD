# 📘 README – Como preparar e importar uma planilha do Excel para o MySQL (passo a passo completo)

Este guia explica, de forma simples e prática, como transformar uma planilha do Excel em uma tabela limpa e correta no MySQL.  
Inclui erros comuns, como fórmulas, vírgulas, cifrão, tipos de dados incorretos e problemas de codificação.

---

## 📌 1. Objetivo

Ensinar como:

- preparar uma planilha do Excel para importação  
- evitar erros comuns (fórmulas, vírgulas, R$, formatação)  
- escolher os tipos corretos no MySQL  
- importar o arquivo com segurança  
- entender por que alguns tipos foram trocados  

Este guia serve para qualquer pessoa, mesmo sem experiência.

---

## 📌 2. Problemas encontrados inicialmente

Ao tentar subir a planilha diretamente para o MySQL, surgiram vários erros:

### ❌ Fórmulas do Excel  
O MySQL não entende nada como:

```
=SE()
=SOMA()
=A1+B1
```

Quando importado, isso vira texto inválido.

---

### ❌ Formatação condicional  
Cores, ícones, negrito, filtros… nada disso é importado.  
Mas às vezes atrapalha porque esconde dados ou cria confusão.

---

### ❌ Símbolo “R$”  
O MySQL não aceita valores como:

```
R$ 3.922,00
```

Isso vira texto e impede cálculos.

---

### ❌ Vírgula como separador decimal  
Excel brasileiro usa vírgula:

```
3770,35
```

MySQL usa ponto:

```
3770.35
```

Se não converter, o MySQL trata como texto.

---

### ❌ Tipos de dados errados  
- Dinheiro estava como **DOUBLE** → impreciso  
- Percentual estava como **DOUBLE** → também impreciso  
- Alguns valores poderiam virar **INT** → perderiam casas decimais  

---

## 📌 3. Como preparar a planilha no Excel

### ✔️ 3.1. Transformar fórmulas em valores

1. Selecione a coluna com fórmulas  
2. Copiar  
3. Colar especial → **Valores**

Assim, o MySQL recebe apenas o número final.

---

### ✔️ 3.2. Remover símbolos e formatação

- Apagar “R$”  
- Remover espaços extras  
- Garantir que não há células mescladas  
- Conferir se não há linhas ocultas  

---

### ✔️ 3.3. Trocar vírgula por ponto

No Excel:

1. CTRL+L (Localizar e substituir)  
2. Localizar: `,`  
3. Substituir por: `.`  

Agora os números ficam no padrão do MySQL.

---

### ✔️ 3.4. Salvar como CSV UTF‑8

Esse é o formato ideal porque:

- não leva fórmulas  
- não leva formatação  
- é leve  
- é compatível com MySQL  

---

## 📌 4. Criando a tabela no MySQL com tipos corretos

### ❗ Por que não usar INT para dinheiro?

Porque INT não aceita casas decimais.  
Você perderia valores como:

```
3770.35 → 3770
6.39 → 6
```

---

### ❗ Por que não usar DOUBLE?

DOUBLE é um tipo **aproximado**, não exato.  
Pode gerar valores como:

```
10.99 → 10.98999999997
```

Isso é péssimo para cálculos financeiros.

---

### ✔️ Tipo correto para dinheiro

```
DECIMAL(10,2)
```

Exato, seguro e ideal para valores monetários.

---

### ✔️ Tipo correto para percentuais

```
DECIMAL(5,2)
```

Perfeito para valores como:

```
10.99
22.77
6.03
```

---

### ✔️ Exemplo de criação da tabela

```sql
CREATE TABLE contribuintes (
    id INT PRIMARY KEY,
    renda_anual DECIMAL(10,2),
    categoria VARCHAR(20),
    percentual_imposto DECIMAL(5,2)
);
```

---

## 📌 5. Ajustando tipos depois de criar errado

Se você criou como DOUBLE e quer corrigir:

```sql
ALTER TABLE contribuintes
MODIFY renda_anual DECIMAL(10,2);

ALTER TABLE contribuintes
MODIFY percentual_imposto DECIMAL(5,2);
```

---

## 📌 6. Importando o CSV no MySQL

Você pode usar:

### ✔️ MySQL Workbench (import wizard)  
ou  
### ✔️ Comando SQL:

```sql
LOAD DATA INFILE 'caminho/arquivo.csv'
INTO TABLE contribuintes
FIELDS TERMINATED BY ','
ENCLOSED BY '\''
LINES TERMINATED BY '\n'
IGNORE 0 LINES
(id, renda_anual, categoria, percentual_imposto);
```

---

## 📌 7. Sobre valores sem “.00”

No CSV, você pode ter:

```
3922
3770.35
```

Isso **não é problema**.

Se a coluna for `DECIMAL(10,2)`, o MySQL automaticamente converte:

- `3922` → `3922.00`  
- `3770.35` → permanece igual  

---

## 📌 8. Fluxo final recomendado (resumo rápido)

### **No Excel**
1. Transformar fórmulas em valores  
2. Remover “R$”  
3. Trocar vírgula por ponto  
4. Conferir datas e números  
5. Salvar como CSV UTF‑8  

### **No MySQL**
1. Criar tabela com tipos corretos  
2. Importar CSV  
3. Validar com `SELECT * FROM tabela;`  

---

## 📌 9. Resultado final

Depois de seguir esse processo:

- os dados sobem limpos  
- sem erros de fórmula  
- sem problemas de vírgula  
- sem perda de casas decimais  
- com tipos corretos para cálculos  
- e prontos para análises SQL  


