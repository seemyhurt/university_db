CREATE OR REPLACE PROCEDURE gather_university_statistics()
AS $$
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS university_statistics (
    	university_id INT,
    	university_name VARCHAR(90),
    	faculty_count INT,
    	department_count INT,
    	specialization_count INT
	);

    TRUNCATE TABLE university_statistics;

    INSERT INTO university_statistics (university_id, university_name, faculty_count, department_count, specialization_count)
    SELECT
        u.university_id,
        u.university_name,
        COALESCE(faculty_count, 0) AS faculty_count,
        COALESCE(department_count, 0) AS department_count,
        COALESCE(specialization_count, 0) AS specialization_count
    FROM
        university u
    LEFT JOIN
        (SELECT university_id, COUNT(*) AS faculty_count FROM faculty GROUP BY university_id) f
        ON u.university_id = f.university_id
    LEFT JOIN
        (SELECT f.university_id, COUNT(*) AS department_count
         FROM faculty f
         JOIN department d ON f.faculty_id = d.faculty_id
         GROUP BY f.university_id) d
        ON u.university_id = d.university_id
    LEFT JOIN
        (SELECT f.university_id, COUNT(*) AS specialization_count
         FROM faculty f
         JOIN department d ON f.faculty_id = d.faculty_id
         JOIN specialization s ON d.department_id = s.department_id
         GROUP BY f.university_id) s
        ON u.university_id = s.university_id;
END;$$
LANGUAGE plpgsql;

CALL gather_university_statistics();
SELECT * FROM university_statistics;