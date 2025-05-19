-- 9.занятия для конкретной группы
SELECT 
    t.lesson_date,
    t.theme,
    CONCAT(st.surname, ' ', st.firstname) AS teacher
FROM 
    school.timetable t
JOIN 
    school.groups g ON t.group_id = g.group_id
JOIN 
    school.staff st ON t.staff_id = st.staff_id
WHERE 
    g.group_name = 'Группа 11'
ORDER BY 
    t.lesson_date;