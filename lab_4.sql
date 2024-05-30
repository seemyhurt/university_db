-- а
SELECT DISTINCT s.specialization_name
FROM specialization s
WHERE s.specialization_name LIKE '%интеллект_%';

-- б
SELECT d.department_name
FROM department d
LEFT JOIN specialization s ON s.department_id = d.department_id
WHERE s.department_id IS NULL;

SELECT d.department_name
FROM specialization s
RIGHT JOIN department d ON s.department_id = d.department_id
WHERE s.department_id IS NULL;

-- в
SELECT d.direction_name
FROM direction d
JOIN direction_exam de_first ON de_first.direction_id = d.direction_id
JOIN exam e_first ON e_first.exam_id = de_first.exam_id

JOIN direction_exam de_second ON de_second.direction_id = d.direction_id
JOIN exam e_second ON e_second.exam_id = de_second.exam_id
WHERE (e_second.subject = 'Математика' AND de_second.isRequired = true)  
AND (e_first.subject = 'Информатика' AND de_first.isRequired = true)

SELECT d.direction_name
FROM direction d
JOIN direction_exam de_first ON de_first.direction_id = d.direction_id
JOIN exam e_first ON e_first.exam_id = de_first.exam_id

JOIN direction_exam de_second ON de_second.direction_id = d.direction_id
JOIN exam e_second ON e_second.exam_id = de_second.exam_id
WHERE e_second.subject = 'Математика' AND e_first.subject = 'Информатика'