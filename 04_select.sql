-- 4.ближайшие занятия
SELECT 
    t.timetable_id,
    g.group_name,
    t.lesson_date,
    t.theme,
    s.subject_name
FROM 
    school.timetable t
JOIN 
    school.groups g ON t.group_id = g.group_id
JOIN 
    school.courses c ON g.course_id = c.course_id
JOIN 
    school.subjects s ON c.subject_id = s.subject_id
WHERE 
    t.lesson_date BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '7 days')
ORDER BY 
    t.lesson_date;