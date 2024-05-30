CREATE OR REPLACE PROCEDURE delete_exam_cascade(
    IN exam_subject VARCHAR(90)
)

AS $$
BEGIN
	DELETE FROM direction_exam WHERE exam_id IN 
		(SELECT exam_id FROM exam WHERE  subject = exam_subject);
	DELETE FROM exam WHERE exam_id IN 
		(SELECT exam_id FROM exam WHERE subject = exam_subject);
END; $$
LANGUAGE plpgsql;

call delete_exam_cascade('История')