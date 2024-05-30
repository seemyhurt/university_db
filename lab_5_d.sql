SELECT city.city_name
FROM city
LEFT JOIN university u ON u.city_id = city.city_id
LEFT JOIN faculty f ON f.university_id = u.university_id
LEFT JOIN department dep ON dep.faculty_id = f.faculty_id
LEFT JOIN specialization s ON s.department_id = dep.department_id
LEFT JOIN direction dir ON dir.direction_id = s.direction_id
GROUP BY city.city_name
HAVING COUNT(DISTINCT LEFT(dir.direction_code, 2)) = (
	SELECT COUNT(DISTINCT LEFT(d.direction_code, 2)) FROM  direction d
);

SELECT city.city_name
FROM city
WHERE NOT EXISTS (
        SELECT DISTINCT LEFT(d.direction_code, 2) AS code
		FROM direction d
	WHERE NOT EXISTS (
		SELECT * FROM university u
		LEFT JOIN faculty f ON f.university_id = u.university_id
		LEFT JOIN department dep ON dep.faculty_id = f.faculty_id
		LEFT JOIN specialization s ON s.department_id = dep.department_id
		LEFT JOIN direction dir ON dir.direction_id = s.direction_id
		WHERE u.city_id = city.city_id
		AND LEFT(dir.direction_code, 2) = LEFT(d.direction_code, 2))
)