-- SELECT d.direction_id, d.direction_name
-- FROM direction d
-- JOIN direction_exam de ON de.direction_id = d.direction_id
-- JOIN exam e ON e.exam_id = de.exam_id
-- WHERE e.subject = 'Физика'

-- EXCEPT

-- (SELECT d.direction_id, d.direction_name
-- FROM direction d
-- JOIN direction_exam de ON de.direction_id = d.direction_id
-- JOIN exam e ON e.exam_id = de.exam_id
-- WHERE e.subject = 'Математика')

-- SELECT d.direction_id, d.direction_name
-- FROM direction d
-- JOIN direction_exam de ON de.direction_id = d.direction_id
-- JOIN exam e ON e.exam_id = de.exam_id
-- WHERE e.subject = 'Физика'

-- AND d.direction_id NOT IN

-- (SELECT d.direction_id
-- FROM direction d
-- JOIN direction_exam de ON de.direction_id = d.direction_id
-- JOIN exam e ON e.exam_id = de.exam_id
-- WHERE e.subject = 'Математика')


SELECT d.direction_name
FROM direction d
JOIN direction_exam de ON de.direction_id = d.direction_id
JOIN exam e ON e.exam_id = de.exam_id
WHERE e.subject = 'Физика'

AND NOT EXISTS

(SELECT d2.direction_id
FROM direction d2
JOIN direction_exam de ON de.direction_id = d2.direction_id
JOIN exam e ON e.exam_id = de.exam_id
WHERE e.subject = 'Математика' AND d.direction_id = d2.direction_id)


SELECT d.direction_name
FROM direction d
JOIN direction_exam de ON de.direction_id = d.direction_id
JOIN exam e ON e.exam_id = de.exam_id

LEFT JOIN

(SELECT d.direction_id
FROM direction d
JOIN direction_exam de ON de.direction_id = d.direction_id
JOIN exam e ON e.exam_id = de.exam_id
WHERE e.subject = 'Математика') q ON d.direction_id = q.direction_id

WHERE e.subject = 'Физика'  AND q.direction_id IS NULL