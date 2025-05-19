-- 1.все преподаватели с их предметами
SELECT 
    st.staff_id,
    CONCAT(st.surname, ' ', st.firstname) AS teacher_name,
    s.subject_name,
    st.post
FROM 
    school.staff st
JOIN 
    school.subjects s ON st.subject_id = s.subject_id
WHERE 
    st.post = 'Преподаватель'
ORDER BY 
    s.subject_name;