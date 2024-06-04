CREATE OR REPLACE PROCEDURE delete_department_with_cleanup(
    IN name_of_department VARCHAR(90)
)

AS $$
DECLARE faculty_id_to_remove INT DEFAULT NULL;
BEGIN
	SELECT dep.faculty_id INTO faculty_id_to_remove FROM department dep WHERE dep.department_name = name_of_department;
	DELETE FROM department WHERE department_name = name_of_department;
	
	IF NOT EXISTS (SELECT * FROM department WHERE faculty_id = faculty_id_to_remove) THEN
		DELETE FROM faculty
		WHERE faculty_id = faculty_id_to_remove;
	END IF;
END;$$
LANGUAGE plpgsql;