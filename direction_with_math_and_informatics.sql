-- with required
SELECT d.direction_name
FROM direction d
JOIN direction_exam de_first ON de_first.direction_id = d.direction_id
JOIN exam e_first ON e_first.exam_id = de_first.exam_id

JOIN direction_exam de_second ON de_second.direction_id = d.direction_id
JOIN exam e_second ON e_second.exam_id = de_second.exam_id
WHERE (e_second.subject = 'Математика' AND de_second.is_required = true)  
AND (e_first.subject = 'Информатика' AND de_first.is_required = true)

SELECT d.direction_name
FROM direction d
JOIN direction_exam de_first ON de_first.direction_id = d.direction_id
JOIN exam e_first ON e_first.exam_id = de_first.exam_id

JOIN direction_exam de_second ON de_second.direction_id = d.direction_id
JOIN exam e_second ON e_second.exam_id = de_second.exam_id
WHERE e_second.subject = 'Математика' AND e_first.subject = 'Информатика'