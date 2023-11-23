USE usinagem_meteor;

-- Consultas
-- 1. Selecione todas as peças produzidas na última semana.
SELECT * FROM peca;
SELECT * FROM ordem_producao;

SELECT 
		P.descricao_peca
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
        m.nome_maq,
        p.descricao_peca
FROM historico_producao h
JOIN ordem_producao o ON o.pk_id_ordem = h.fk_id_ordem
JOIN maquina m ON h.fk_id_maq = m.pk_id_maq
JOIN peca p ON p.pk_id_peca = h.fk_id_peca
GROUP BY m.nome_maq;

-- 3. Liste todas as manutenções programadas para este mês.
-- 4. Encontre os operadores que estiveram envolvidos na produção de uma peça específica.
-- 5. Classifique as peças por peso em ordem decrescente.
SELECT 
		P.descricao_peca,
		P.peso
FROM peca P
ORDER BY P.peso DESC;

-- 6. Encontre a quantidade total de peças rejeitadas em um determinado período.
SELECT * FROM rejeicao;
 
SELECT COUNT(r.pk_id_rejeicao) 'Quantidade Rejeicao'
FROM rejeicao r 
WHERE data_rej >= CURRENT_DATE - INTERVAL 9 month;

-- 7. Liste os fornecedores de matérias-primas em ordem alfabética.
SELECT * FROM fornecedor;
SELECT * FROM materia_prima;

SELECT 
		F.nome_forn
FROM fornecedor F
JOIN materia_prima M ON M.fk_id_forn = F.pk_id_forn
ORDER BY F.nome_forn ASC;
		
-- 8. Encontre o número total de peças produzidas por tipo de material.
SELECT * FROM peca;
SELECT * FROM materia_prima;
SELECT * FROM ordem_producao;

SELECT 
		SUM(M.quantidade_estoque) 'Número total de peças produzidas',
        M.descricao_mp
FROM materia_prima M
JOIN peca P ON M.pk_id_mp = P.fk_id_mp
GROUP BY  M.descricao_mp;

-- 9. Selecione as peças que estão abaixo do nível mínimo de estoque.
-- 10.Liste as máquinas que não passaram por manutenção nos últimos três meses.
-- 11.Encontre a média de tempo de produção por tipo de peça.
-- 12.Identifique as peças que passaram por inspeção nos últimos sete dias.
-- 13.Encontre os operadores mais produtivos com base na quantidade de peças produzidas.
-- 14.Liste as peças produzidas em um determinado período com detalhes de data e quantidade.
-- 15.Identifique os fornecedores com as entregas mais frequentes de matérias-primas.
-- 16.Encontre o número total de peças produzidas por cada operador
-- 17.Liste as peças que passaram por inspeção e foram aceitas.
SELECT * FROM inspecao;
SELECT * from aceitacao;

SELECT 
		P.descricao_peca
FROM peca P
JOIN inspecao I ON P.pk_id_peca = I.fk_id_peca
JOIN aceitacao A ON P.pk_id_peca = A.fk_id_peca;

-- 18.Encontre as manutenções programadas para as máquinas no próximo mês.
-- 19.Calcule o custo total das manutenções realizadas no último trimestre.
-- 20.Identifique as peças produzidas com mais de 10% de rejeições nos últimos dois meses