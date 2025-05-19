--14. разница между желаемыми баллами текущего и предыдущего студента
SELECT student_id, firstname, purpose,
	purpose - LAG(purpose) OVER (ORDER BY purpose DESC) AS diff
FROM school.students
WHERE purpose IS NOT NULL;