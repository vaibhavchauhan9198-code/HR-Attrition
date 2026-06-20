/* ==========================================
   HR EMPLOYEE ATTRITION ANALYSIS PROJECT
   Author: Vaibhav Chauhan
   Tools Used: MySQL, Power BI
========================================== */

/* Creating Database */

CREATE DATABASE hr_attrition_db;
USE hr_attrition_db;

/* Renaming Imported Table */

ALTER TABLE `wa_fn-usec_-hr-employee-attrition`
RENAME TO hr_attrition;

/* ==========================================
   DATA OVERVIEW
========================================== */

/* Query1: Total Number of Employees */

SELECT COUNT(*) AS total_employees
FROM hr_attrition;

/* Insight:
   The dataset contains records of 1,470 employees.*/
   
/* ------------------------------------------------------------
   Query 2: Employees Left vs Stayed

   Business Question:
   How many employees left the company and how many stayed?
------------------------------------------------------------ */

SELECT
    attrition,
    COUNT(*) AS employee_count
FROM hr_attrition
GROUP BY attrition;

/* Insight:
   Out of 1,470 employees, 237 employees left the company
   while 1,233 employees remained with the organization.
   This indicates that employee attrition exists and should
   be analyzed further to identify the key reasons behind it.
*/

/* ------------------------------------------------------------
   Query 3: Attrition Rate (%)

   Business Question:
   What percentage of employees have left the company?
------------------------------------------------------------ */

SELECT
    ROUND(
        (SUM(CASE
                WHEN attrition = 'Yes' THEN 1
                ELSE 0
             END) * 100.0) / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_attrition;

/* Insight:
   The employee attrition rate is 16.12%.
   This means approximately 16 out of every 100 employees
   have left the organization.
*/
/* ------------------------------------------------------------
   Query 4: Department-wise Employee Count

   Business Question:
   Which department has the highest number of employees?
------------------------------------------------------------ */

SELECT
    department,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY department
ORDER BY total_employees DESC;

/* Insight:
   Research & Development has 961 the highest number of employees,
   followed by Sales 446 and Human Resources 63.
*/
/* ------------------------------------------------------------
   Query 5: Department-wise Attrition Count

   Business Question:
   Which department has lost the most employees?
------------------------------------------------------------ */

SELECT
    department,
    COUNT(*) AS employees_left
FROM hr_attrition
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY employees_left DESC;

/* Insight:
   This query identifies the Research & Development departments with the highest 133 employees
   employee turnover.Research & Development with high attrition may
   require improvements in employee engagement, work culture,
   compensation, or career growth opportunities.
*/
/* ------------------------------------------------------------
   Query 6: Department-wise Attrition Rate (%)

   Business Question:
   Which department has the highest attrition rate?
------------------------------------------------------------ */

SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_attrition
GROUP BY department
ORDER BY attrition_rate DESC;

/* Insight:
   This analysis reveals sales followed by Human Resources department is losing the
   highest percentage of employees relative to its size.

   A high attrition rate may indicate issues related to:
   - Workload
   - Management
   - Compensation
   - Career growth
   - Employee satisfaction
*/
/* ------------------------------------------------------------
   Query 7: Job Role-wise Employee Count

   Business Question:
   How many employees are working in each job role?
------------------------------------------------------------ */

SELECT
    jobrole,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY jobrole
ORDER BY total_employees DESC;

/* Insight:
   Sales Executive is the most common job role with 326 employees,
   followed by Research Scientist (292 employees) and Laboratory
   Technician (259 employees).
   These roles represent a significant portion of the workforce and
   may have a greater impact on overall attrition trends.
*/
/* ------------------------------------------------------------
   Query 8: Average Salary by Job Role

   Business Question:
   Which job roles have the highest average monthly salary?
------------------------------------------------------------ */

SELECT
    jobrole,
    ROUND(AVG(monthlyincome), 2) AS avg_salary
FROM hr_attrition
GROUP BY jobrole
ORDER BY avg_salary DESC;

/* Insight:
   Managers receive the highest average monthly salary
   (₹17,181.68), followed by Research Directors
   (₹16,033.55).

   Healthcare Representatives and Manufacturing Directors
   also earn above-average salaries, indicating that
   leadership and specialized roles receive higher
   compensation within the organization.
*/
/* ------------------------------------------------------------
   Query 9: Employee Count by Gender

   Business Question:
   What is the gender distribution of employees?
------------------------------------------------------------ */

SELECT
    gender,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY gender
ORDER BY total_employees DESC;

/* Insight:
   The organization has 882 male employees and
   588 female employees.
   Male employees represent a larger share of the
   workforce, accounting for approximately 60% of
   total employees, while female employees account
   for around 40%.
*/
/* ------------------------------------------------------------
   Query 10: Employee Count by Education Field

   Business Question:
   Which education fields have the most employees?
------------------------------------------------------------ */

SELECT
    educationfield,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY educationfield
ORDER BY total_employees DESC;

/* Insight:
   Life Sciences is the most common education field with
   606 employees, followed by Medical with 464 employees.
   Together, these two fields account for the majority of
   the workforce, indicating that the organization has a
   strong presence of employees from science and healthcare
   related backgrounds.
   Human Resources has the lowest representation with only
   27 employees.
*/
/* ------------------------------------------------------------
   Query 11: Employee Count by Marital Status

   Business Question:
   What is the marital status distribution of employees?
------------------------------------------------------------ */

SELECT
    maritalstatus,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY maritalstatus
ORDER BY total_employees DESC;

/* Insight:
   Married employees form the largest group with
   673 employees, followed by Single employees (470)
   and Divorced employees (327).
   This indicates that nearly half of the workforce
   is married, making it the dominant marital status
   category within the organization.
*/
/* ------------------------------------------------------------
   Query 12: Employee Distribution by Business Travel

   Business Question:
   How frequently do employees travel for business?
------------------------------------------------------------ */

SELECT
    businesstravel,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY businesstravel
ORDER BY total_employees DESC;

/* Insight:
   Most employees travel occasionally for work, with
   1,043 employees classified as Travel_Rarely.
   277 employees travel frequently, while only 150
   employees do not travel at all.
   This indicates that business travel is a common
   requirement for a large portion of the workforce.
*/
/* ------------------------------------------------------------
   Query 13: Average Years at Company by Department

   Business Question:
   How long do employees stay in each department on average?
------------------------------------------------------------ */

SELECT
    department,
    ROUND(AVG(yearsatcompany), 2) AS avg_years_at_company
FROM hr_attrition
GROUP BY department
ORDER BY avg_years_at_company DESC;

/* Insight:
   Employees in the Sales department have the highest
   average tenure at 7.28 years, followed closely by
   Human Resources (7.24 years).
   Research & Development employees have an average
   tenure of 6.86 years.
   Overall, employees tend to stay with the company
   for approximately 7 years, indicating moderate
   workforce stability.
*/
/* ------------------------------------------------------------
   Query 14: Youngest and Oldest Employee

   Business Question:
   What is the minimum and maximum employee age?
------------------------------------------------------------ */

SELECT
    MIN(age) AS youngest_employee,
    MAX(age) AS oldest_employee
FROM hr_attrition;

/* Insight:
   The youngest employee in the organization is 18 years old,
   while the oldest employee is 60 years old.
   This indicates that the workforce consists of employees
   from a wide range of age groups, providing a mix of
   young talent and experienced professionals.
*/
/* ------------------------------------------------------------
   Query 15: Average Salary by Gender

   Business Question:
   What is the average monthly salary by gender?
------------------------------------------------------------ */

SELECT
    gender,
    ROUND(AVG(monthlyincome), 2) AS avg_salary
FROM hr_attrition
GROUP BY gender
ORDER BY avg_salary DESC;

/* Insight:
   Female employees have a slightly higher average
   monthly salary (₹6,686.57) compared to male
   employees (₹6,380.51).
   The salary difference is relatively small,
   indicating a fairly balanced compensation
   structure across genders.
*/
/* ------------------------------------------------------------
   Query 16: Employee Distribution by Job Satisfaction

   Business Question:
   How are employees distributed across job satisfaction levels?
------------------------------------------------------------ */

SELECT
    jobsatisfaction,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY jobsatisfaction
ORDER BY jobsatisfaction;

/* Insight:
   Most employees report high levels of job satisfaction.
   459 employees have a job satisfaction rating of 4,
   while 442 employees have a rating of 3.
   Only 289 employees reported the lowest satisfaction
   level (1), suggesting that the overall workforce is
   generally satisfied with their jobs.
*/
/* ------------------------------------------------------------
   Query 17: Employee Distribution by Environment Satisfaction

   Business Question:
   How satisfied are employees with their work environment?
------------------------------------------------------------ */

SELECT
    environmentsatisfaction,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY environmentsatisfaction
ORDER BY environmentsatisfaction;

/* Insight:
   Most employees are satisfied with their work environment.
   453 employees have an environment satisfaction rating of 3,
   while 446 employees have a rating of 4.
   Only 284 employees reported the lowest satisfaction level,
   indicating that the organization generally provides a
   positive working environment.
*/
/* ------------------------------------------------------------
   Query 18: Employee Distribution by Work-Life Balance

   Business Question:
   How do employees rate their work-life balance?
------------------------------------------------------------ */

SELECT
    worklifebalance,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY worklifebalance
ORDER BY worklifebalance;

/* Insight:
   Most employees rate their work-life balance positively.
   893 employees have a work-life balance rating of 3,
   making it the most common rating.
   Only 80 employees reported the lowest rating,
   suggesting that the majority of employees are
   reasonably satisfied with their work-life balance.
*/

/* ------------------------------------------------------------
   Query 19: Employee Distribution by Performance Rating

   Business Question:
   How are employees distributed across performance ratings?
------------------------------------------------------------ */

SELECT
    performancerating,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY performancerating
ORDER BY performancerating;

/* Insight:
   Most employees have a performance rating of 3,
   with 1,244 employees falling into this category.
   Only 226 employees have a performance rating of 4.
   This indicates that the majority of employees are
   performing at a standard level, while a smaller
   group are recognized as high performers.
*/
/* ------------------------------------------------------------
   Query 20: Employee Distribution by Education Level

   Business Question:
   How are employees distributed across education levels?
------------------------------------------------------------ */

SELECT
    education,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY education
ORDER BY education;

/* Insight:
   Employees with a Bachelor's degree form the
   largest group in the organization with 572 employees,
   followed by Master's degree holders with 398 employees.
   Only 48 employees hold a Doctorate degree,
   making it the least common education level.
   This indicates that the workforce is primarily
   composed of employees with undergraduate and
   postgraduate qualifications.
*/
/* ------------------------------------------------------------
   Query 21: Employee Distribution by Training Frequency

   Business Question:
   How many training programs did employees attend last year?
------------------------------------------------------------ */

SELECT
    trainingtimeslastyear,
    COUNT(*) AS total_employees
FROM hr_attrition
GROUP BY trainingtimeslastyear
ORDER BY trainingtimeslastyear;

/* Insight:
   Most employees attended 2 or 3 training programs
   during the last year.
   547 employees participated in 2 training sessions,
   while 491 employees attended 3 training sessions.
   Only 54 employees did not attend any training,
   indicating that the organization actively invests
   in employee learning and development.
*/
/* ------------------------------------------------------------
   Query 22: Rank Departments by Average Salary

   Business Question:
   Which department offers the highest average salary?
------------------------------------------------------------ */

SELECT
    department,
    ROUND(AVG(monthlyincome), 2) AS avg_salary,
    RANK() OVER (
        ORDER BY AVG(monthlyincome) DESC
    ) AS salary_rank
FROM hr_attrition
GROUP BY department;

/* Insight:
   Most employees attended 2 or 3 training programs
   during the last year, with 547 employees attending
   2 sessions and 491 employees attending 3 sessions.
   Only 54 employees received no training, suggesting
   that the organization actively invests in employee
   learning and skill development.
*/
/* ------------------------------------------------------------
   Query 23: Employees Earning Above Average Salary

   Business Question:
   How many employees earn more than the company average salary?
------------------------------------------------------------ */

SELECT
    COUNT(*) AS employees_above_average
FROM hr_attrition
WHERE monthlyincome >
(
    SELECT AVG(monthlyincome)
    FROM hr_attrition
);

/* Insight:
   This query identifies the 493 employees
   whose salary is higher than the overall company
   average salary.
*/
/* ------------------------------------------------------------
   Query 24: Highest Paid Employee in Each Department

   Business Question:
   Who is the highest paid employee in each department?
------------------------------------------------------------ */

SELECT
    department,
    employeenumber,
    jobrole,
    monthlyincome
FROM
(
    SELECT
        department,
        employeenumber,
        jobrole,
        monthlyincome,
        ROW_NUMBER() OVER(
            PARTITION BY department
            ORDER BY monthlyincome DESC
        ) AS salary_rank
    FROM hr_attrition
) ranked_employees
WHERE salary_rank = 1;

/* Insight:
   Managers are the highest-paid employees in all
   three departments.
   The highest salary in the company belongs to a
   Manager in the Research & Development department
   earning ₹19,999 per month.
   This suggests that managerial roles receive
   the highest compensation regardless of department.
*/


/* ## Final Insights

1. The overall employee attrition rate is 16.12%, indicating that employee retention is a significant business concern.
2. The Sales department experiences the highest attrition rate, suggesting potential challenges related to workload, job satisfaction, or career growth opportunities.
3. Research & Development has the largest workforce and contributes the highest number of employee exits due to its size.
4. Employees with lower job satisfaction and environment satisfaction levels are more likely to leave the organization.
5. Most employees have a moderate work-life balance rating, but a smaller group reports dissatisfaction, which may contribute to attrition.
6. Managers and Research Directors receive the highest salaries, while several operational roles receive comparatively lower compensation.
7. Business travel is common among employees, and frequent travel may influence employee retention and job satisfaction.
8. The workforce is primarily composed of employees from Life Sciences and Medical backgrounds, indicating a strong technical and research-oriented employee base.

---

## Recommendations

1. Conduct employee feedback surveys in the Sales department to identify the primary reasons for employee turnover.
2. Improve career development programs, mentoring, and promotion opportunities to enhance employee retention.
3. Review compensation structures for critical job roles and ensure salaries remain competitive with industry standards.
4. Strengthen employee engagement initiatives and recognition programs to improve job satisfaction.
5. Enhance work-life balance policies through flexible work arrangements and employee wellness programs.
6. Monitor employees with low satisfaction scores and provide timely support through HR interventions.
7. Analyze the impact of business travel on employee performance and satisfaction to reduce potential burnout.
8. Develop a predictive attrition model using machine learning to proactively identify employees at risk of leaving the organization.

## Conclusion
The analysis reveals that employee attrition is influenced by multiple factors, including department, job satisfaction, compensation, work-life balance, and career growth opportunities. By implementing targeted retention strategies and continuously monitoring employee engagement, the organization can reduce attrition, improve workforce stability, and enhance overall business performance.
/*












