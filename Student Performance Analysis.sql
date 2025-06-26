CREATE DATABASE student_performance_record;

SHOW TABLES;

DESCRIBE studentsperformance;

SELECT * FROM studentsperformance;

-- count students
SELECT
    COUNT(*)
FROM studentsperformance;

SELECT
	gender,
    COUNT(*)
FROM studentsperformance
GROUP BY gender;

-- rank students
CREATE TEMPORARY TABLE student_performance AS
SELECT
	gender,
	`race/ethnicity`,
	`parental level of education`,
	lunch,
	`test preparation course`,
	`math score`,
	`reading score`,
	`writing score`,
	ROUND(((`math score`+`reading score`+`writing score`)/3),2) AS `average score`,
	DENSE_RANK() OVER (ORDER BY (`math score`+`reading score`+`writing score`)/3 DESC) AS ranking
FROM
	studentsperformance;

SELECT * FROM student_performance;

-- average score based one race/ethnicity
SELECT
	`race/ethnicity`,
    AVG(`average score`) AS `average score`
FROM
	student_performance
GROUP BY `race/ethnicity`
ORDER BY `average score` DESC;

-- average score based on lunch
SELECT
	lunch,
    AVG(`average score`) AS `average score`
FROM
	student_performance
GROUP BY lunch
ORDER BY `average score` DESC;

-- average score based on test preparation test
SELECT
	`test preparation course`,
    AVG(`average score`) AS `average score`
FROM
	student_performance
GROUP BY `test preparation course`
ORDER BY `average score` DESC;

-- average score based on parental level of education
SELECT
	`parental level of education`,
    AVG(`average score`) AS `average score`
FROM
	student_performance
GROUP BY `parental level of education`
ORDER BY `average score` DESC;

-- top 20 students
SELECT * FROM student_performance
ORDER BY `average score` DESC
LIMIT 20;

-- analysis on top 20 students
CREATE TEMPORARY TABLE top20 AS
SELECT * FROM student_performance
ORDER BY `average score` DESC
LIMIT 20;

SELECT 
	`race/ethnicity`,
    COUNT(*)
FROM top20
GROUP BY `race/ethnicity`;

SELECT 
	`parental level of education`,
    COUNT(*)
FROM top20
GROUP BY `parental level of education`;

SELECT 
	lunch,
    COUNT(*)
FROM top20
GROUP BY lunch;

SELECT 
	`test preparation course`,
    COUNT(*)
FROM top20
GROUP BY `test preparation course`;

-- 20 students with lowest average score
SELECT * FROM student_performance
ORDER BY `average score` ASC
LIMIT 20;

-- analysis on top bottom 20 students
CREATE TEMPORARY TABLE topbottom20 AS
SELECT * FROM student_performance
ORDER BY `average score` ASC
LIMIT 20;

SELECT 
	`race/ethnicity`,
    COUNT(*)
FROM topbottom20
GROUP BY `race/ethnicity`;

SELECT 
	`parental level of education`,
    COUNT(*)
FROM topbottom20
GROUP BY `parental level of education`;

SELECT 
	lunch,
    COUNT(*)
FROM topbottom20
GROUP BY lunch;

SELECT 
	`test preparation course`,
    COUNT(*)
FROM topbottom20
GROUP BY `test preparation course`;

/* Conclusion
Based on the analysis of student performance data:
1. Group E has the highest average scores among all race/ethnicity groups, followed by Group D, C, B, and A. All students ranked first are from Group E, and 9 out of the top 20 students also belong to this group.
2. Students with standard lunch have a significantly higher average score than those with free/reduced lunch. In fact, 17 of the top 20 students receive standard lunch, while 17 of the bottom 20 students are on free/reduced lunch.
3. Students whose parents hold higher education degrees tend to achieve better average scores, with the highest average scores found among students whose parents have a Master's degree. The top 20 students are mostly from families with a college degree, while the bottom 20 are dominated by those whose parents only completed high school.
4. Students who completed a test preparation course have higher average scores compared to those who did not. Among the top 20 students, 13 completed the course, while 18 of the bottom 20 students did not.

Overall insight:
Higher academic performance tends to be associated with higher parental education, better lunch status, completing a test preparation course, and belonging to Group E in this dataset.
*/
