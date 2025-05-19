-- 6.наставники и количество групп
SELECT 
    st.staff_id,
    CONCAT(st.surname, ' ', st.firstname) AS coach_name,
    COUNT(cg.group_id) AS group_count
FROM 
    school.staff st
JOIN 
    school.coach_groups cg ON st.staff_id = cg.staff_id
WHERE 
    st.post = 'Наставник'
GROUP BY 
    st.staff_id, coach_name
ORDER BY 
    group_count DESC;