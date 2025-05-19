-- 11.сотрудники, которые ведут хотя бы одно занятие
SELECT st.staff_id, CONCAT(st.surname,' ', st.firstname) AS name
FROM school.staff st
WHERE EXISTS (
	SELECT 1 FROM school.timetable t WHERE t.staff_id = st.staff_id
);