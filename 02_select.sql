-- 2.группы с их наставниками
SELECT 
    g.group_id,
    g.group_name,
    s.subject_name,
    CONCAT(st.surname, ' ', st.firstname) AS coach_name
FROM 
    school.groups g
JOIN 
    school.courses c ON g.course_id = c.course_id
JOIN 
    school.subjects s ON c.subject_id = s.subject_id
JOIN 
    school.coach_groups cg ON g.group_id = cg.group_id
JOIN 
    school.staff st ON cg.staff_id = st.staff_id
ORDER BY 
    g.group_name;