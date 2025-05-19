-- 7.курсы по длительности
SELECT 
    c.flow,
    COUNT(g.group_id) AS group_count
FROM 
    school.courses c
LEFT JOIN 
    school.groups g ON c.course_id = g.course_id
GROUP BY 
    c.flow
ORDER BY 
    group_count DESC;