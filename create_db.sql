DROP TABLE IF EXISTS school.coach_groups CASCADE;
DROP TABLE IF EXISTS school.homework CASCADE;
DROP TABLE IF EXISTS school.timetable CASCADE;
DROP TABLE IF EXISTS school.groups CASCADE;
DROP TABLE IF EXISTS school.students CASCADE;
DROP TABLE IF EXISTS school.courses CASCADE;
DROP TABLE IF EXISTS school.staff CASCADE;
DROP TABLE IF EXISTS school.subjects CASCADE;

CREATE SCHEMA IF NOT EXISTS school;

--предметы
CREATE TABLE IF NOT EXISTS school.subjects
(
    subject_id SERIAL,
    subject_name VARCHAR(50) NOT NULL,

    CONSTRAINT subjects_pkey PRIMARY KEY (subject_id),
    CONSTRAINT subject_name_not_empty CHECK (subject_name != '')
);

--сотрудники
CREATE TABLE IF NOT EXISTS school.staff
(
    staff_id SERIAL,
    surname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50),
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    post VARCHAR(50) NOT NULL,

    CONSTRAINT staff_pkey PRIMARY KEY (staff_id),
    CONSTRAINT staff_name_isvalid CHECK (
        surname ~ '^[а-яА-Яa-zA-Z-]+$' AND 
        firstname ~ '^[а-яА-Яa-zA-Z-]+$' AND 
        (lastname IS NULL OR lastname ~ '^[а-яА-Яa-zA-Z-]+$')
    ),
    CONSTRAINT staff_email_isvalid CHECK (email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    CONSTRAINT staff_post_not_empty CHECK (post != ''),
    CONSTRAINT staff_email_unique UNIQUE (email),
    CONSTRAINT staff_birth_date_valid CHECK (date_of_birth <= CURRENT_DATE - INTERVAL '18 years')
);

-- курс
CREATE TABLE IF NOT EXISTS school.courses
(
    course_id SERIAL,
    flow VARCHAR(100) NOT NULL,
    subject_id INTEGER NOT NULL,

    CONSTRAINT courses_pkey PRIMARY KEY (course_id),
    CONSTRAINT courses_subject_id_fkey FOREIGN KEY (subject_id)
        REFERENCES school.subjects (subject_id),
    CONSTRAINT flow CHECK (flow != '')
);

--студенты
CREATE TABLE IF NOT EXISTS school.students
(
    student_id SERIAL,
    surname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50),
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    purpose INTEGER NOT NULL,
    mark INTEGER,

    CONSTRAINT students_pkey PRIMARY KEY (student_id),
    CONSTRAINT students_name_isvalid CHECK (
        surname ~ '^[а-яА-Яa-zA-Z-]+$' AND 
        firstname ~ '^[а-яА-Яa-zA-Z-]+$' AND 
        (lastname IS NULL OR lastname ~ '^[а-яА-Яa-zA-Z-]+$')
    ),
    CONSTRAINT students_email_isvalid CHECK (email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    CONSTRAINT students_email_unique UNIQUE (email),
    CONSTRAINT students_purpose_valid CHECK (purpose BETWEEN 0 AND 100),
    CONSTRAINT students_mark_valid CHECK (mark IS NULL OR mark BETWEEN 0 AND 100),
    CONSTRAINT students_birth_date_valid CHECK (date_of_birth <= CURRENT_DATE - INTERVAL '14 years')
);

--группы
CREATE TABLE IF NOT EXISTS school.groups
(
    group_id SERIAL,
    group_name VARCHAR(50) NOT NULL,
    course_id INTEGER NOT NULL,
	
    CONSTRAINT groups_pkey PRIMARY KEY (group_id),
    CONSTRAINT groups_course_id_fkey FOREIGN KEY (course_id)
        REFERENCES school.courses (course_id),
    CONSTRAINT group_name_not_empty CHECK (group_name != '')
);

--какие группы ведет наставник
CREATE TABLE IF NOT EXISTS school.coach_groups
(
    coach_group_id SERIAL,
    staff_id INTEGER NOT NULL,
    group_id INTEGER NOT NULL,

    CONSTRAINT coach_groups_pkey PRIMARY KEY (coach_group_id),
    CONSTRAINT coach_groups_staff_id_fkey FOREIGN KEY (staff_id)
        REFERENCES school.staff (staff_id) ON DELETE CASCADE,
    CONSTRAINT coach_groups_group_id_fkey FOREIGN KEY (group_id)
        REFERENCES school.groups (group_id) ON DELETE CASCADE,
    CONSTRAINT coach_groups_unique UNIQUE (staff_id, group_id)
);

--дз
CREATE TABLE IF NOT EXISTS school.homework
(
    homework_id SERIAL,
    theme VARCHAR(100) NOT NULL,
    max_score INTEGER NOT NULL,
    start_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deadline TIMESTAMP NOT NULL,

    CONSTRAINT homework_pkey PRIMARY KEY (homework_id),
    CONSTRAINT homework_max_score_positive CHECK (max_score > 0),
    CONSTRAINT homework_dates_valid CHECK (deadline > start_date),
    CONSTRAINT homework_theme_not_empty CHECK (theme != '')
);

--расписание
CREATE TABLE IF NOT EXISTS school.timetable
(
    timetable_id SERIAL,
    group_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    lesson_date TIMESTAMP NOT NULL,
    duration_minutes INTEGER NOT NULL,
    theme VARCHAR(100) NOT NULL,

    CONSTRAINT timetable_pkey PRIMARY KEY (timetable_id),
    CONSTRAINT timetable_group_id_fkey FOREIGN KEY (group_id)
        REFERENCES school.groups (group_id) ON DELETE CASCADE,
    CONSTRAINT timetable_staff_id_fkey FOREIGN KEY (staff_id)
        REFERENCES school.staff (staff_id),
    CONSTRAINT timetable_theme_not_empty CHECK (theme != '')
);
