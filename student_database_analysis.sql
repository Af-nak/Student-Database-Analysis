-- Creating tales in the database: tearches_tbl, classes, subject, student, enrollment, scores, attendance, fees
-- 1. teachers_tbl

CREATE TABLE teachers_tbl(
	teacher_id Int,
	last_name Varchar(20),
	first_name Varchar(20),
	gender varchar(8),
	specialization varchar(20),
	hire_date date,
	
	CONSTRAINT pk_teacher PRIMARY KEY (teacher_id)
)

SELECT * FROM teachers_tbl

SELECT COUNT(*) FROM teachers_tbl

-- 2. classes table
CREATE TABLE classes(
	class_id int,
	class_name varchar(20),
	level varchar(20),
	arm varchar(5),
	academic_year int,
	teacher_id int,

	CONSTRAINT pk_class PRIMARY KEY(class_id),
	CONSTRAINT fk_Teacher FOREIGN KEY(teacher_id) REFERENCES teachers_tbl(teacher_id)

)

-- 3. subject table

CREATE TABLE subject(
	subject_id int PRIMARY KEY,
	subject_name varchar(20),
	subject_type varchar(20),
	teacher_id int,
	
	CONSTRAINT fk_teacher FOREIGN KEY(teacher_id)
	REFERENCES teachers_tbl(teacher_id)
)

-- 4. stuudent table
CREATE TABLE student(
	student_id int PRIMARY KEY,
	first_name varchar(20),
	last_name Varchar(20),
	gender varchar(10),
	date_of_birth date,
	state varchar(20),
	admission_date date,
	class_id int,
	status varchar(20),

	CONSTRAINT fk_class FOREIGN KEY(class_id) REFERENCES classes(class_id)

)

-- 5. enrollment table

CREATE TABLE enrollment(
	enrollment_id int PRIMARY KEY,
	student_id int REFERENCES student(student_id),
	class_id int REFERENCES classes(class_id),
	term varchar(10),
	enrollment_date date

)

SELECT * FROM enrollment

-- 6. scores table

CREATE TABLE scores(
	score_id int PRIMARY KEY,
	student_id int REFERENCES student(student_id),
	subject_id int REFERENCES subject(subject_id),
	term varchar(10),
	ca_score int,
	exam_score int,
	total_score int
)

-- 7. attendance table

CREATE TABLE attendance(
	attendance_id int PRIMARY KEY,
	student_id int REFERENCES student(student_id),
	attendance_date date,
	status varchar(20)

)

-- 8. fees table
CREATE TABLE fees(
	fee_id int,
	student_id int,
	amount_due int,
	amount_paid int,
	payment_status varchar(20),
	payment_date date,

	CONSTRAINT  pk_fee PRIMARY KEY(fee_id),
	CONSTRAINT fk_student_id FOREIGN KEY(student_id) REFERENCES student(student_id)

)

-- Import relative data for each tables in the dataset using PGadmin GUI

-- ## 1. SELECT / WHERE / DISTINCT
-- 1. Display all students.
SELECT * FROM student

-- 2. Display only first_name, last_name and state.

SELECT first_name,last_name, state FROM student;

-- 3. Find students from Lagos.

SELECT first_name||' '||last_name AS Students FROM student
WHERE state = 'Lagos';

-- 4. Find students whose status is Active.
SELECT first_name,last_name, status FROM student
WHERE status = 'Active';

-- 5. Find students born after 2010-01-01.

SELECT first_name,last_name, date_of_birth FROM student
WHERE date_of_birth > '2010-01-01';

-- 6. Display the different states represented in the school.

SELECT DISTINCT state FROM student;

-- 7. Find students whose first name starts with 'A'.

SELECT first_name, last_name FROM student 
WHERE first_name LIKE 'A%';

-- 8. Find students from Lagos OR Kano.
SELECT first_name, last_name FROM student 
WHERE state = 'Lagos' OR state = 'Kano';

SELECT first_name, last_name, state FROM student
WHERE state IN('Lagos', 'Kano');

-- 9. Find students who are not from Lagos.

SELECT first_name, last_name FROM student 
WHERE state  <> 'Lagos'

SELECT first_name||' '||last_name As students, state FROM student 
WHERE state  <> 'Lagos'

-- 10. Find students whose names contain 'an'.

SELECT first_name, last_name FROM student
WHERE first_name LIKE '%an%' OR last_name LIKE '%an%';

-- ## 2. ORDER BY / LIMIT
-- 11. List students alphabetically by last name.
SELECT first_name, last_name FROM student
ORDER BY last_name;

-- 12. List students from youngest to oldest using date_of_birth.
SELECT first_name, last_name, date_of_birth FROM student
ORDER BY date_of_birth desc;

-- 13. Show the 5 most recently admitted students.
SELECT first_name, last_name FROM student
ORDER BY admission_date desc 
LIMIT 5;

-- 14. Show the 10 highest scores.
SELECT total_score FROM scores
ORDER BY total_score desc
LIMIT 10;

-- ## 3. Aggregate Functions
-- 15. Count all students.
SELECT COUNT(*) FROM student;

-- 16. Count active students.

SELECT COUNT(*) FROM student
WHERE status = 'Active';

-- 17. Find the average score.
SELECT AVG(total_score) FROM scores;

-- 18. Find the highest and lowest score.
SELECT MAX(total_score) as highest_score, 
	   MIN(total_score) as lowest_score 
FROM scores;

-- 19. Find the total amount paid in school fees.
SELECT SUM(amount_paid) as Total_amount_paid FROM fees;

-- 20. Count students by gender.
SELECT DISTINCT gender, COUNT(gender) FROM student
GROUP BY (gender);

## 4. GROUP BY / HAVING

SELECT * FROM classes;
-- 21. Count students in each class.
SELECT cl.class_name, COUNT(st.student_id) 
FROM student st
JOIN classes cl ON st.class_id = cl.class_id
GROUP BY cl.class_name;
-- 22. Find the average score for each subject.
SELECT sbj.subject_name, AVG(sc.total_score) average_score
FROM scores sc
JOIN student st ON sc.student_id = st.student_id
JOIN classes cl ON st.class_id = cl.class_id
JOIN subject sbj ON cl.teacher_id = sbj.teacher_id
GROUP BY sbj.subject_name;

-- 23. Find the highest score for each subject.

SELECT sbj.subject_name, MAX(sc.total_score) highest_score
FROM scores sc
JOIN subject sbj ON sc.subject_id = sbj.subject_id
GROUP BY sbj.subject_name;

-- 24. Count attendance records by status.
SELECT status, COUNT(status)
FROM attendance
GROUP BY status;

-- 25. Find classes with more than 3 students.
SELECT cl.class_name, COUNT(st.student_id)
FROM student st
JOIN classes cl ON st.class_id = cl.class_id
GROUP BY cl.class_name
HAVING COUNT(st.student_id) >3;

-- 26. Find subjects whose average score is at least 60.

SELECT sbj.subject_name, AVG(sc.total_score) AS Average_score
FROM scores sc
JOIN subject sbj ON sbj.subject_id = sc.subject_id
GROUP BY sbj.subject_name
HAVING AVG(sc.total_score) >= 60;

-- ## 5. Basic JOINs
-- 27. Join students to classes and display each student's class name.
SELECT first_name||' '||last_name AS student_name, cl.class_name
FROM student st
JOIN classes cl ON st.class_id = cl.class_id;

-- 28. Join classes to teachers and display the class teacher.
SELECT cl.class_name, tch.last_name||' '||tch.first_name AS class_teacher
FROM classes cl
JOIN teachers_tbl tch ON cl.teacher_id = tch.teacher_id;

-- 29. Join students, scores and subjects to show each student's subject and score.
SELECT st.first_name||' '||st.last_name AS student_name, sbj.subject_name, sc.total_score
FROM scores sc
JOIN student st ON sc.student_id = st.student_id
JOIN subject sbj ON sc.subject_id = sbj.subject_id;

-- 31. Join students, classes and teachers to show student, class and class teacher.

SELECT st.first_name||' '||st.last_name As student_name, cl.class_name, tch.last_name||' '||tch.first_name AS class_teacher
FROM student st
JOIN classes cl ON st.class_id = cl.class_id
JOIN teachers_tbl tch ON cl.teacher_id = tch.teacher_id;

-- 33. Join students to fees and show each student's amount due and amount paid.
SELECT st.first_name||' '||st.last_name As student_name, fs.amount_due, fs.amount_paid
FROM student st
JOIN fees fs ON st.student_id = fs.student_id;

-- ## 6. JOIN + Aggregation

-- 34. Calculate each student's average score.
SELECT st.first_name||' '||st.last_name As student_name, AVG(total_score)
FROM student st
JOIN scores sc ON st.student_id = sc.student_id
GROUP BY st.first_name||' '||st.last_name;

-- 35. Calculate the average score for each class.
SELECT cl.class_name, AVG(total_score)
FROM classes cl
JOIN student st ON cl.class_id = st.class_id
JOIN scores sc ON st.student_id = sc.student_id
GROUP BY cl.class_name;

-- 36. Calculate total fees paid by each class.
SELECT cl.class_name, SUM(fs.amount_paid)
FROM classes cl
JOIN student st ON cl.class_id = st.class_id
JOIN fees fs ON st.student_id = fs.student_id
GROUP BY cl.class_name;

-- 37. Count the number of absent attendance records for each student.
SELECT st.first_name||' '||st.last_name As student_name, COUNT(at.status)
FROM attendance at
JOIN student st ON at.student_id = st.student_id
WHERE at.status = 'Absent'
GROUP BY st.first_name||' '||st.last_name;

-- ## 7. LEFT JOIN / Missing Data
-- 40. Find students who have no fee payment record.
SELECT st.first_name||' '||st.last_name As student_name
FROM student st
LEFT JOIN fees fs ON fs.student_id = st.student_id
WHERE fs.amount_paid = 0;

SELECT * FROM scores
-- 41. Find students who have not received a score for a particular subject.
SELECT st.first_name||' '||st.last_name As student_name
FROM student st
JOIN scores sc ON st.student_id = sc.student_id
JOIN subject sbj ON sc.subject_id = sbj.subject_id
WHERE sc.total_score = 0;

-- 42. Show every student and their fee record, including students with NULL payment dates.
SELECT st.first_name|| ' '||st.last_name AS student_name, fs.amount_paid, fs.amount_due, fs.payment_status
FROM student st
JOIN fees fs ON st.student_id = fs.student_id;

-- 43. Show every subject and the number of students who have scores for it.

SELECT sbj.subject_name, COUNT(student_id)
FROM subject sbj
JOIN classes cl ON sbj.teacher_id =cl.teacher_id
JOIN student st ON cl.class_id = st.class_id
GROUP BY sbj.subject_name;

-- 44. Create a grade column: 70+ = A, 60–69 = B, 50–59 = C, 45–49 = D, below 45 = F
SELECT sc.student_id, sbj.subject_name, sc.total_score,
    CASE
        WHEN total_score >= 70 THEN 'A'
        WHEN total_score >= 60 THEN 'B'
        WHEN total_score >= 50 THEN 'C'
        WHEN total_score >= 45 THEN 'D'
        ELSE 'F'
    END AS grade
FROM scores sc
JOIN subject sbj ON sc.subject_id = sbj.subject_id;

-- 45. Create a fee balance column using amount_due - amount_paid.
SELECT student_id,
       amount_due,
       amount_paid,
       amount_due - amount_paid AS fee_balance
FROM fees;
-- 46. Categorize students as 'Fully Paid', 'Part Payment' or 'Unpaid'.
SELECT st.first_name||' '||st.last_name AS Student_name,
       fs.amount_due,
       fs.amount_paid,
       CASE
           WHEN fs.amount_paid = fs.amount_due THEN 'Fully Paid'
           WHEN fs.amount_paid > 0 THEN 'Part Payment'
           ELSE 'Unpaid'
       END AS payment_category
FROM fees fs
JOIN student st ON fs.student_id = st.student_id;

SELECT * FROM student;
-- 47. Extract the year from students' date_of_birth.
SELECT student_id,
       first_name,
       last_name,
       EXTRACT(YEAR FROM date_of_birth) AS birth_year
FROM student;

-- 48. Calculate each student's age approximately from date_of_birth.
SELECT student_id,
       first_name,
       last_name,
       date_of_birth,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) AS age
FROM students;

-- 49.Combine first_name and last_name into a full_name.
SELECT first_name||' '||last_name AS full_name FROM student;

-- 50. Find students admitted in January 2026.
SELECT CONCAT(st.first_name,st.last_name) AS full_name, en.enrollment_date
FROM enrollment en
JOIN student st ON en.student_id = st.student_id
WHERE enrollment_date >= '2026-01-01' 
AND enrollment_date <= '2026-01-31' ;

-- 51. Find teachers hired before 2020.
SELECT CONCAT(last_name, first_name) AS teacher_name, hire_date
FROM teachers_tbl
WHERE hire_date < '2020-01-01';

-- 52. Find students whose score is above the overall average score.
SELECT CONCAT(st.last_name, ' ', st.first_name) AS student_name, sc.total_score
FROM scores sc
JOIN student st ON sc.student_id = st.student_id
WHERE total_score >(
SELECT AVG(total_score) 
FROM scores
);

SELECT * FROM scores
-- 53. Find students whose fee balance is greater than the average fee balance.
SELECT st.student_id,
       st.first_name,
       st.last_name,
       f.amount_due - f.amount_paid AS fee_balance
FROM students st
JOIN fees f
    ON st.student_id = f.student_id
WHERE f.amount_due - f.amount_paid > (
    SELECT AVG(amount_due - amount_paid)
    FROM fees
);
-- 54. Find the student(s) with the highest score.
SELECT student_id, total_score
FROM scores 
WHERE total_score = (
SELECT MAX(total_score)
FROM scores);

-- 55. Find subjects whose average score is above the overall average subject score.

SELECT sbj.subject_id,
       sbj.subject_name,
       AVG(sc.total_score) AS average_score
FROM subject sbj
JOIN scores sc
    ON sbj.subject_id = sc.subject_id
GROUP BY sbj.subject_id, sbj.subject_name
HAVING AVG(sc.total_score) > (
    SELECT AVG(total_score)
    FROM scores);


