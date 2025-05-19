-- 5.количество групп по предметам
SELECT 
    s.subject_name,
    COUNT(g.group_id) AS group_count
FROM 
    school.subjects s
JOIN 
    school.courses c ON s.subject_id = c.subject_id
JOIN 
    school.groups g ON c.course_id = g.course_id
GROUP BY 
    s.subject_name
ORDER BY 
    group_count DESC;