CREATE OR REPLACE PROCEDURE
insert_university_with_lookup ( 
	IN name_of_city VARCHAR(60), 
	IN name_of_university VARCHAR(90),
	IN date_begin DATE DEFAULT NULL,
	IN date_end DATE DEFAULT NULL
)

AS $$

DECLARE 
parent_city_id INT DEFAULT NULL;

BEGIN
	IF EXISTS (SELECT * FROM city WHERE city_name = name_of_city)
 		THEN SELECT city_id INTO parent_city_id FROM city WHERE city_name = name_of_city;
	ELSE 
		BEGIN
			INSERT INTO city(city_name) VALUES (name_of_city) RETURNING city_id INTO parent_city_id;
		END;
	END IF;
	
	INSERT INTO university(university_name, city_id) VALUES (name_of_university, parent_city_id);
END;$$
LANGUAGE plpgsql;

CALL insert_university_with_lookup('Караганда', 'Тест');