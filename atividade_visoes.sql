-- 1)Crie visões para armazenar as seguintes consultas:

/* a) Visão DadosCons: Selecionar o nome do paciente, problema, nome do médico, especialidade, data, hora e valor da consulta*/
CREATE VIEW DadosCons As
SELECT p.nomep as nome_paciente, p.problema, m.nomem nome_medico, m.especialidade, c.dt_consulta, c.hora_consulta, c.valor_consulta
FROM consulta c
INNER JOIN paciente p ON c.codp = p.codp
INNER JOIN medico m ON c.codm = m.codm
ORDER BY p.nomep;

SELECT * FROM DadosCons;

/* b) Visão GanhosMed: Selecionar o nome do medico, ano e total obtido com consultas em cada ano.*/
CREATE VIEW GanhosMed As
SELECT m.nomem AS nome_medico, YEAR(c.dt_consulta) AS dt_consulta, SUM(c.valor_consulta) AS valor_consulta
FROM consulta c
INNER JOIN medico m ON c.codm = m.codm
GROUP BY m.nomem, YEAR(c.dt_consulta)
ORDER BY YEAR(c.dt_consulta);

SELECT * FROM GanhosMed;

/* c) Visão ConsultasCardio: Listar o nome do paciente, data e hora das consultas de
todos os pacientes que são cardíacos ou hipertensos e que foram atendidos por cardiologistas.*/
CREATE VIEW ConsultasCardio As
SELECT p.nomep as nome_paciente, c.dt_consulta, c.hora_consulta
FROM consulta c
INNER JOIN paciente p ON c.codp = p.codp
INNER JOIN medico m ON c.codm = m.codm
WHERE (p.problema = 'Cardiaco' OR p.problema = 'Hipertensao')
AND m.especialidade = 'Cardiologista';

SELECT * FROM ConsultasCardio;

/* d) Visão ReceitaporProblema: Listar o problema do paciente e total pago em consultas para cada 
tipo de problema ordenado em ordem decrescente pelo total pago (agrupar por problema).*/
CREATE VIEW ReceitaporProblema As
SELECT p.problema, SUM(c.valor_consulta) as total_pago_consultas
FROM consulta c
INNER JOIN paciente p ON c.codp = p.codp
GROUP BY p.problema
ORDER BY total_pago_consultas DESC; 

SELECT * FROM ReceitaporProblema;

/* e) Visão ReceitaporSexo: Listar o sexo do paciente e total pago em consultas agrupados pelo sexo .*/
CREATE VIEW ReceitaporSexo As
SELECT p.sexo, SUM(c.valor_consulta) as total_pago_consultas
FROM consulta c
INNER JOIN paciente p ON c.codp = p.codp
GROUP BY p.sexo
ORDER BY total_pago_consultas DESC; 

SELECT * FROM ReceitaporSexo;