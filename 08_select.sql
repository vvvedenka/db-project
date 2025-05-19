-- 8.преподаватели, ведущие более одной группы
SELECT
	st.staff_id,
	CONCAT(st.surname, ' ', st.firstname) as coach_name,
	COUNT(cg.group_id) as group_count
FROM
	school.staff st
JOIN
	school.coach_groups cg ON st.staff_id = cg.staff_id
WHERE
	st.post = 'Наставник'
GROUP BY
	st.staff_id, coach_name
HAVING
	COUNT(cg.group_id) > 1
ORDER BY
	group_count DESC;