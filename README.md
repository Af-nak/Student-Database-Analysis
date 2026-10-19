# Student Database Analysis Using SQL

## Project Overview

This project focuses on exploring and analyzing a school database using SQL. The goal is to retrieve meaningful information about students, classes, teachers, subjects, academic performance, attendance, and school fee payments.

The project demonstrates how SQL can be used to query relational databases, summarize records, combine information from multiple tables, identify missing data, and answer practical questions about school operations.

![Student Database Analysis Screenshot](Screenshot%202026-10-19%20131611.png)

## Project Objectives

- Retrieve and filter student records based on specific conditions.
- Sort and limit query results to identify relevant records.
- Calculate key statistics using aggregate functions.
- Analyze student distribution and academic performance.
- Combine related information across multiple database tables.
- Identify missing records and incomplete payment information.
- Apply conditional logic to grades and school fee balances.
- Extract useful insights from date and text fields.
- Use subqueries to answer advanced analytical questions.

## Database Structure

The project uses a relational school database containing the following tables:

| Table | Description |
|---|---|
| student | Contains student information, including names, gender, state, date of birth, admission date, status, and class assignment. |
| classes| Contains class information and class teacher assignments. |
| teachers_tbl | Contains teacher information, including names and employment dates. |
| subject | Contains subject details. |
| scores | Stores student scores for different subjects. |
| attendance | Stores student attendance records and attendance status. |
| fees | Contains school fee amounts due, amounts paid, and payment dates. |

## Analysis Questions and SQL Techniques

### 1. Basic Queries and Filtering

- Display all student records.
- Select specific columns, including first name, last name, and state.
- Find students from Lagos.
- Find students with an active status.
- Identify students born after January 1, 2010.
- Display the distinct states represented in the school.
- Find students whose first names start with 'A'.
- Find students from Lagos or Kano.
- Find students who are not from Lagos.
- Find students whose names contain 'an'.

**SQL Concepts:** `SELECT`, `WHERE`, `DISTINCT`, `LIKE`, `AND`, `OR`, `NOT`, comparison operators.

### 2. Sorting and Limiting Results

- List students alphabetically by last name.
- Sort students from oldest to youngest using date of birth.
- Retrieve the five most recently admitted students.
- Display the ten highest scores.

**SQL Concepts:** `ORDER BY`, `ASC`, `DESC`, `LIMIT`.

### 3. Aggregate Functions

- Count all students.
- Count active students.
- Calculate the average score.
- Find the highest and lowest scores.
- Calculate the total amount paid in school fees.
- Count students by gender.

**SQL Concepts:** `COUNT()`, `AVG()`, `MAX()`, `MIN()`, `SUM()`.

### 4. GROUP BY and HAVING

- Count students in each class.
- Calculate the average score for each subject.
- Find the highest score for each subject.
- Count attendance records by status.
- Identify classes with more than three students.
- Find subjects with an average score of at least 60.

**SQL Concepts:** `GROUP BY`, `HAVING`, aggregate functions.

### 5. Basic JOINs

- Join students with classes to display each student's class name.
- Join classes with teachers to identify class teachers.
- Join scores with students to display student names and scores.
- Join scores with subjects to display subject names and scores.
- Combine students, classes, and teachers to display students, their classes, and class teachers.
- Join students, scores, and subjects to display each student's subject and score.
- Join students with fees to display amounts due and amounts paid.

**SQL Concepts:** `INNER JOIN`, table aliases, primary keys, foreign keys, relational data retrieval.

### 6. JOINs and Aggregation

- Calculate each student's average score.
- Calculate the average score for each class.
- Calculate total fees paid by each class.
- Count absent attendance records for each student.
- Identify students whose average score is above 60.
- Find subjects with more than ten recorded scores.

**SQL Concepts:** `JOIN`, `GROUP BY`, `HAVING`, `AVG()`, `SUM()`, `COUNT()`.

### 7. LEFT JOIN and Missing Data

- Find students without fee payment records.
- Identify students without scores for a particular subject.
- Display every student and their fee records, including records with missing payment dates.
- List every subject and count the students who have recorded scores for it.

**SQL Concepts:** `LEFT JOIN`, `IS NULL`, `COALESCE()`, missing-data analysis.

### 8. Conditional Logic Using CASE

Create a grade column based on student scores:

| Score Range | Grade |
|---|---|
| 70 and above | A |
| 60–69 | B |
| 50–59 | C |
| 45–49 | D |
| Below 45 | F |

Additional analysis:

- Calculate fee balances using `amount_due - amount_paid`.
- Categorize students as `Fully Paid`, `Part Payment`, or `Unpaid`.

**SQL Concepts:** `CASE`, `WHEN`, `THEN`, `ELSE`, `END`, arithmetic expressions.

### 9. Date and String Functions

- Extract the year from each student's date of birth.
- Calculate each student's approximate age from their date of birth.
- Combine first and last names into a full name.
- Find students admitted in January 2026.
- Identify teachers hired before 2020.

**SQL Concepts:** Date functions, string concatenation, date filtering, text manipulation.

### 10. Subqueries

- Find students whose scores are above the overall average score.
- Identify students whose fee balances are greater than the average fee balance.
- Find the student or students with the highest score.

**SQL Concepts:** Scalar subqueries, aggregate subqueries, nested `SELECT` statements.

## Tools and Technologies

- **PostgreSQL:** Relational database management and SQL querying.
- **SQL:** Data retrieval, filtering, aggregation, joins, conditional logic, and subqueries.
- **GitHub:** Project documentation, version control, and portfolio presentation.

## Skills Demonstrated

- Writing structured SQL queries to answer practical questions.
- Filtering and sorting records based on specified conditions.
- Summarizing data using aggregate functions.
- Understanding relationships between database tables.
- Analyzing student demographics and academic performance.
- Evaluating attendance records and school fee payments.
- Identifying missing information using outer joins.
- Applying conditional logic to categorize records.
- Using date, string, and subquery techniques to solve analytical problems.

## Project Outcome

This project demonstrates the application of SQL to a school database, transforming stored records into structured answers to practical questions about student demographics, academic performance, attendance, teaching assignments, and fee payments.

It also provides a foundation for more advanced projects involving data cleaning, database optimization, reporting, and dashboard development.

## How to Use This Project

1. Clone or download this repository.
2. Open the SQL script in PostgreSQL or a compatible SQL environment.
3. Ensure the school database and its tables have been created and populated.
4. Review the queries and execute them against the database.
5. Examine the returned results for each analysis question.

## Repository Contents

- `student_database_analysis.sql` — Contains the SQL queries used to answer the analysis questions.
- `README.md` — Provides the project documentation.


## Author

**LinkedIn: Naheemat Akinyemi**

Aspiring Data Analyst passionate about using data to solve problems, uncover insights, and communicate findings effectively.
