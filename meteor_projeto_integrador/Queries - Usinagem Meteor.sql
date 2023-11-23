USE usinagem_meteor;

-- Consultas
-- 1. Selecione todas as peças produzidas na última semana.
SELECT * FROM peca;
SELECT * FROM ordem_producao;

SELECT 
		P.descricao_peca 'Peça'
FROM peca P
JOIN ordem_producao O ON P.pk_id_peca = O.fk_id_peca
-- WHERE YEARWEEK(data_conclusao, 1) = YEARWEEK(NOW(), 1);
WHERE data_conclusao >= CURRENT_DATE - INTERVAL 7 DAY;

-- 2. Encontre a quantidade total de peças produzidas por cada máquina.
SELECT * FROM historico_producao;
SELECT * FROM ordem_producao;
SELECT * FROM maquina;
SELECT * FROM peca;

SELECT 
		SUM(o.quantidade_ordem) 'Quantidade Total',
        m.nome_maq 'Máquina',
        p.descricao_peca 'Peça'
FROM ordem_producao o 
JOIN historico_producao h ON o.pk_id_ordem = h.fk_id_ordem
JOIN maquina m ON h.fk_id_maq = m.pk_id_maq
JOIN peca p ON p.pk_id_peca = h.fk_id_peca
GROUP BY m.nome_maq, p.descricao_peca;

-- 3. Liste todas as manutenções programadas para este mês.
SELECT * FROM manutencao_programada;
 
SELECT 	
		pk_id_man 'Manutenção Programada'
FROM manutencao_programada m
WHERE data_programada >= CURRENT_DATE - INTERVAL 1 month;

-- 4. Encontre os operadores que estiveram envolvidos na produção de uma peça específica.
SELECT * FROM historico_producao;
SELECT * FROM operador;
SELECT * FROM peca;

SELECT
		o.nome_op 'Operador',
        p.descricao_peca 'Peça'
FROM peca p
JOIN historico_producao h ON p.pk_id_peca = h.fk_id_peca
JOIN operador o ON o.pk_id_op = h.fk_id_op;

-- 5. Classifique as peças por peso em ordem decrescente.
SELECT 
		P.descricao_peca 'Peça',
		P.peso 'Peso'
FROM peca P
ORDER BY P.peso DESC;

-- 6. Encontre a quantidade total de peças rejeitadas em um determinado período.
SELECT * FROM rejeicao;
 
SELECT 
		COUNT(r.pk_id_rej) 'Quantidade Rejeicao'
FROM rejeicao r 
WHERE data_rej >= CURRENT_DATE - INTERVAL 9 month;

-- 7. Liste os fornecedores de matérias-primas em ordem alfabética.
SELECT * FROM fornecedor;
SELECT * FROM materia_prima;

SELECT 
		F.nome_forn 'Nome Fornecedor'
FROM fornecedor F
JOIN materia_prima M ON M.fk_id_forn = F.pk_id_forn
ORDER BY F.nome_forn ASC;
		
-- 8. Encontre o número total de peças produzidas por tipo de material.
SELECT * FROM peca;
SELECT * FROM materia_prima;
SELECT * FROM ordem_producao;

SELECT 
		SUM(M.quantidade_estoque) 'Número total de peças produzidas',
        M.descricao_mp 'Tipo de Material'
FROM materia_prima M
JOIN peca P ON M.pk_id_mp = P.fk_id_mp
GROUP BY  M.descricao_mp;

-- 9. Selecione as peças que estão abaixo do nível mínimo de estoque.
SELECT * FROM peca;
SELECT * FROM ordem_producao;

SELECT 
		P.descricao_peca 'Peça',
        O.quantidade_ordem 'Estoque'
FROM peca P
JOIN ordem_producao O ON P.pk_id_peca = O.fk_id_peca
WHERE O.quantidade_ordem <= 100;

-- 10.Liste as máquinas que não passaram por manutenção nos últimos três meses.
SELECT * FROM maquina;
SELECT * FROM manutencao_programada;

SELECT 
		m.nome_maq 'Máquina'
FROM maquina m 
WHERE m.pk_id_maq NOT IN(
							SELECT mp.fk_id_maq
                            FROM manutencao_programada mp
                            WHERE mp.data_programada >= CURRENT_DATE - INTERVAL 3 MONTH);

-- 11.Encontre a média de tempo de produção por tipo de peça.
SELECT
		P.descricao_peca 'Peça',
        AVG(TIMESTAMPDIFF(MINUTE, O.data_conclusao, O.data_inicio)) 'Média de Tempo de Produção'
FROM peca P
JOIN ordem_producao O ON P.pk_id_peca = O.fk_id_peca
GROUP BY P.pk_id_peca, P.descricao_peca;

-- 12.Identifique as peças que passaram por inspeção nos últimos sete dias.
SELECT * FROM peca;
SELECT * FROM inspecao;

SELECT 
		P.descricao_peca 'Peça'
FROM peca P
JOIN inspecao I ON P.pk_id_peca = I.fk_id_peca
WHERE I.data_insp >= CURRENT_DATE - INTERVAL 7 DAY;

-- 13.Encontre os operadores mais produtivos com base na quantidade de peças produzidas.
SELECT
		o.nome_op 'Operador',
        p.descricao_peca 'Peça',
        SUM(op.quantidade_ordem) 'Quantidade'
FROM peca p
JOIN historico_producao h ON p.pk_id_peca = h.fk_id_peca
JOIN operador o ON o.pk_id_op = h.fk_id_op
JOIN ordem_producao op ON h.fk_id_ordem = op.pk_id_ordem
GROUP BY o.nome_op, p.descricao_peca
HAVING SUM(op.quantidade_ordem) > 30000
ORDER BY SUM(op.quantidade_ordem) DESC;

-- 14.Liste as peças produzidas em um determinado período com detalhes de data e quantidade.
SELECT * FROM peca;
SELECT * FROM ordem_producao;

SELECT
		P.descricao_peca 'Peça',
        O.quantidade_ordem 'Estoque',
        O.data_conclusao 'Data'
FROM peca P
JOIN ordem_producao O ON P.pk_id_peca = O.fk_id_peca
WHERE data_conclusao >= CURRENT_DATE - INTERVAL 3 MONTH
ORDER BY data_conclusao DESC;

-- 15.Identifique os fornecedores com as entregas mais frequentes de matérias-primas.
SELECT * FROM materia_prima;
SELECT * FROM fornecedor;

SELECT 
		COUNT(mp.data_ultima_compra) 'Quantidade Compras',
        f.nome_forn 'Nome Forncedor'
FROM materia_prima mp
JOIN fornecedor f ON f.pk_id_forn = mp.fk_id_forn
GROUP BY f.nome_forn
HAVING COUNT(mp.data_ultima_compra)>25
ORDER BY COUNT(mp.data_ultima_compra) DESC;

-- 16.Encontre o número total de peças produzidas por cada operador
SELECT * FROM historico_producao;
SELECT * FROM ordem_producao;
SELECT * FROM operador;
SELECT * FROM peca;

SELECT
		o.nome_op 'Operador',
        p.descricao_peca 'Peça',
        SUM(op.quantidade_ordem) 'Quantidade'
FROM peca p
JOIN historico_producao h ON p.pk_id_peca = h.fk_id_peca
JOIN operador o ON o.pk_id_op = h.fk_id_op
JOIN ordem_producao op ON h.fk_id_ordem = op.pk_id_ordem
GROUP BY o.nome_op, p.descricao_peca;

-- 17.Liste as peças que passaram por inspeção e foram aceitas.
SELECT * FROM inspecao;
SELECT * from aceitacao;

SELECT 
		P.descricao_peca 'Peça'
FROM peca P
JOIN inspecao I ON P.pk_id_peca = I.fk_id_peca
JOIN aceitacao A ON P.pk_id_peca = A.fk_id_peca;

-- 18.Encontre as manutenções programadas para as máquinas no próximo mês.
SELECT * FROM maquina;
SELECT * FROM manutencao_programada;
SELECT 
		mp.data_programada 'Data Programada',
        mq.nome_maq 'Máquina'
FROM manutencao_programada mp
JOIN maquina mq ON mp.fk_id_maq = mq.pk_id_maq
WHERE mp.data_programada >= CURRENT_DATE - INTERVAL 1 month;

-- 19.Calcule o custo total das manutenções realizadas no último trimestre.
SELECT * FROM historico_manutencao;

SELECT 
		SUM(h.custo_man) 'Custo Total Das Manutenções'
FROM historico_manutencao h
WHERE data_man >= CURRENT_DATE - INTERVAL 3 MONTH;

-- 20.Identifique as peças produzidas com mais de 10% de rejeições nos últimos dois meses
SELECT * FROM peca;
SELECT * FROM rejeicao;

SELECT
		p.descricao_peca 'Peça',
        (COUNT(r.pk_id_rej)/ COUNT(pk_id_peca)) * 100 'Percentual de Rejeição'
FROM peca p
JOIN rejeicao r ON p.pk_id_peca = r.fk_id_peca AND r.data_rej >= CURRENT_DATE - INTERVAL 2 MONTH
GROUP BY pk_id_peca
HAVING (COUNT(r.pk_id_rej)/ COUNT(pk_id_peca)) * 100 > 10;
