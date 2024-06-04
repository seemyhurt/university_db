-- left join
SELECT d.department_name
FROM department d
LEFT JOIN specialization s ON s.department_id = d.department_id
WHERE s.department_id IS NULL;

--right join
SELECT d.department_name
FROM specialization s
RIGHT JOIN department d ON s.department_id = d.department_id
WHERE s.department_id IS NULL;