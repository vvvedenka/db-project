--13. рейтинг студентов по желаемым баллам
SELECT student_id, firstname, surname, purpose,
	RANK() OVER (ORDER BY purpose DESC)
FROM school.students
WHERE purpose IS NOT NULL;