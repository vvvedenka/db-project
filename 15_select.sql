--15. показ пяти самых старших студентов после первых пяти
SELECT student_id, firstname, surname, date_of_birth
FROM school.students
ORDER BY date_of_birth
OFFSET 5 LIMIT 5;