-- 10.дз, у которых тема совпадает с темами занятий
SELECT *
FROM school.homework h
WHERE h.theme IN (
	SELECT DISTINCT theme
	FROM school.timetable
);