/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

Select 

   sd.skills,
   round(median(jpf.salary_Year_Avg),0) As median_salary,
    COUNT(jpf.*) AS demand_count

From   job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
Where jpf.job_title='Data Engineer' 
    AND jpf.job_work_from_home = True 
--    AND salary_Year_Avg > '190000'
Group by sd.skills  
HAVING demand_count > 10 
Order BY median(jpf.salary_Year_Avg) DESC , demand_count Desc
Limit 10;