SELECT u_first.university_name 
FROM university u_first 
WHERE u_first.university_name <= ALL(
	SELECT u_second.university_name FROM university u_second
);

SELECT u_first.university_name 
FROM university u_first 
WHERE u_first.university_name = (
	SELECT MIN(u_second.university_name) FROM university u_second
);

-- SELECT u_first.university_name 
-- FROM university u_first 
-- WHERE NOT EXISTS (
--     SELECT u_second.university_name 
--     FROM university u_second 
--     WHERE u_second.university_name < u_first.university_name
-- );