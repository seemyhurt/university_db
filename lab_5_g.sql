SELECT u.university_name, COUNT(DISTINCT dir.direction_name)
FROM university u
LEFT JOIN faculty f on f.university_id = u.university_id
LEFT JOIN department d on d.faculty_id = f.faculty_id
LEFT JOIN specialization s on s.department_id = d.department_id
LEFT JOIN direction dir on dir.direction_id = s.direction_id
GROUP BY u.university_id
HAVING COUNT(DISTINCT dir.direction_name) < (SELECT AVG(dir_count) FROM (
	SELECT COUNT(DISTINCT dir.direction_name) AS dir_count
	FROM university u
	LEFT JOIN faculty f on f.university_id = u.university_id
	LEFT JOIN department d on d.faculty_id = f.faculty_id
	LEFT JOIN specialization s on s.department_id = d.department_id
	LEFT JOIN direction dir on dir.direction_id = s.direction_id
	GROUP BY u.university_id) AS avg_direction_count)

-- общая таблица выражений CTE
WITH direction_counts AS (
	SELECT u.university_id, COUNT(DISTINCT dir.direction_name) AS direction_count
	FROM university u
	LEFT JOIN faculty f on f.university_id = u.university_id
	LEFT JOIN department d on d.faculty_id = f.faculty_id
	LEFT JOIN specialization s on s.department_id = d.department_id
	LEFT JOIN direction dir on dir.direction_id = s.direction_id
	GROUP BY u.university_id
)
SELECT u.university_name, direction_count
FROM university u
LEFT JOIN direction_counts dc ON u.university_id = dc.university_id
WHERE dc.direction_count < (SELECT AVG(direction_count) FROM direction_counts);