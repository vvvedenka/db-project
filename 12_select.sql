-- 12. наставники с одинаковыми предметами
SELECT
	s1.staff_id AS staff_1_id,
	s1.firstname || ' ' || s1.surname AS staff_1_name,
	s2.staff_id As staff_2_id,
	s2.firstname || ' ' || s2.surname AS staff_2_name,
	subj.subject_name
FROM
	school.staff s1
JOIN
	school.staff s2
	ON s1.subject_id = s2.subject_id
	AND s1.staff_id < s2.staff_id
JOIN
	school.subjects subj ON s1.subject_id = subj.subject_id
WHERE
	s1.post = 'Наставник' AND s2.post = 'Наставник';