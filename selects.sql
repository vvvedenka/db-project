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

-- 3.расписание занятий
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
ORDER BY 
    t.lesson_date;

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

-- 8.преподаватели и их предметы
SELECT DISTINCT
    st.staff_id,
    CONCAT(st.surname, ' ', st.firstname) AS teacher_name,
    s.subject_name
FROM 
    school.staff st
JOIN 
    school.subjects s ON st.subject_id = s.subject_id
WHERE 
    st.post = 'Преподаватель'
ORDER BY 
    s.subject_name;

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

-- 10.все дз
SELECT 
    h.homework_id,
    h.theme,
    h.max_score,
    h.deadline
FROM 
    school.homework h
ORDER BY 
    h.deadline;
