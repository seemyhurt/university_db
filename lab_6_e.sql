CREATE OR REPLACE PROCEDURE admission_statistics(start_date DATE, end_date DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    CREATE TEMP TABLE IF NOT EXISTS admission_stats (
        direction_name VARCHAR(90),
        total_applications INT
    );

    INSERT INTO admission_stats (direction_name, total_applications)
    SELECT dir.direction_name, COUNT(dir.direction_name) AS total_applications
    FROM direction dir
    JOIN specialization s ON s.direction_id = dir.direction_id
    JOIN department dep ON dep.department_id = s.department_id
	JOIN faculty f ON f.faculty_id = dep.faculty_id
	JOIN university u ON u.university_id = f.university_id
    WHERE (u.compaign_date_begin <= start_date AND u.compaign_date_end >= end_date) 
	OR (u.compaign_date_begin >= start_date AND u.compaign_date_end <= end_date)
    GROUP BY dir.direction_name;

END $$;

-- DROP TABLE admission_stats
CALL admission_statistics('20.06.2024', '21.06.2024');
SELECT * FROM admission_stats;