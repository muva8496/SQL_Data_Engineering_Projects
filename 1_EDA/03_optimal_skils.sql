/*
- What are the most optimal skills for data engineers-balancing both demand and salary?
- Create a ranking column that combines demand count and  median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    * This approach highlights skills that balance market demand and financial reward.
    * Ii weights core skills appropriately, rather than letting rare,outlier skills distort the results.
*/

select
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),  0) as median_salary,
    COUNT(jpf.salary_year_avg) AS demand_count,
    MEDIAN(jpf.salary_year_avg) * COUNT(jpf.salary_year_avg) AS optimal_score
from job_postings_fact AS jpf
inner join skills_job_dim as sjd
    on jpf.job_id = sjd.job_id
inner join skills_dim as sd
on sjd.skill_id =sd.skill_id
where  jpf.job_title_short ='Data Engineer'
        and jpf.job_work_from_home = true 
group by sd.skills
having count(jpf.*) >100
order by optimal_score desc
limit 25;



select
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),  0) as median_salary,
    --COUNT(jpf.salary_year_avg) AS demand_count,
    ROUND(LN(COUNT(jpf.*)),2) AS log_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000, 3) AS optimal_score
from job_postings_fact AS jpf
inner join skills_job_dim as sjd
    on jpf.job_id = sjd.job_id
inner join skills_dim as sd
on sjd.skill_id =sd.skill_id
where  jpf.job_title_short ='Data Engineer'
        and jpf.job_work_from_home = true 
        and jpf.salary_year_avg is not null
group by sd.skills
having count(jpf.*) >100
order by optimal_score desc
limit 25;

/*

Here's a breakdown of the most optimal skills for data engineers, balancing both demand and salary.

Top Skills by Optimal Score:
- Top Skills by Optimal Score:

* Terraform leads the list with a $184K median salary and 193 postings, resulting in the highest overall "optimal score" (0.968) due to its massive salary premium balancing moderate volume.


* Python and SQL dominate demand (over 1100 postings each), with strong median salaries of $135K and $130K, respectively, securing the #2 (0.949) and #4 (0.914) ranks in optimal score.


* AWS (783 postings, $137K median), Spark (503 postings, $140K median), and Airflow (386 postings, $150K median) form the high-value core, all achieving optimal scores between 0.871 and 0.915.


* Kafka offers high compensation ($145K median) and solid demand (292 postings), earning a 0.823 score and highlighting the premium placed on real-time streaming.


* Tools like Snowflake, Azure, and Databricks each have 250–475 postings and median salaries between $128–$137K, maintaining steady optimal scores ranging from 0.741 to 0.824.


* Kubernetes commands an elevated $150.5K median salary but lower relative demand (147 postings), producing an optimal score of 0.751 alongside specialized developer tools like Git (0.747).


* Long-tail tools such as Docker, MongoDB, Go, R, GitHub, and BigQuery converge toward baseline scores between 0.650 and 0.671, characterized by demand counts under 170 postings and salaries near the $135K–$140K bracket.

            limit 25;
┌────────────┬───────────────┬──────────────────┬───────────────┐
│   skills   │ median_salary │ log_demand_count │ optimal_score │
│  varchar   │    double     │      double      │    double     │
├────────────┼───────────────┼──────────────────┼───────────────┤
│ terraform  │      184000.0 │             5.26 │         0.968 │
│ python     │      135000.0 │             7.03 │         0.949 │
│ aws        │      137320.0 │             6.66 │         0.915 │
│ sql        │      130000.0 │             7.03 │         0.914 │
│ airflow    │      150000.0 │             5.96 │         0.893 │
│ spark      │      140000.0 │             6.22 │         0.871 │
│ snowflake  │      135500.0 │             6.08 │         0.824 │
│ kafka      │      145000.0 │             5.68 │         0.823 │
│ azure      │      128000.0 │             6.16 │         0.789 │
│ java       │      135000.0 │             5.71 │         0.771 │
│ scala      │      137290.0 │             5.51 │         0.756 │
│ kubernetes │      150500.0 │             4.99 │         0.751 │
│ git        │      140000.0 │             5.34 │         0.747 │
│ databricks │      132750.0 │             5.58 │         0.741 │
│ redshift   │      130000.0 │             5.61 │          0.73 │
│ gcp        │      136000.0 │             5.28 │         0.718 │
│ hadoop     │      135000.0 │             5.29 │         0.714 │
│ nosql      │      134415.0 │             5.26 │         0.707 │
│ pyspark    │      140000.0 │             5.02 │         0.703 │
│ docker     │      135000.0 │             4.97 │         0.671 │
│ mongodb    │      135750.0 │             4.91 │         0.667 │
│ go         │      140000.0 │             4.73 │         0.662 │
│ r          │      134775.0 │             4.89 │         0.659 │
│ github     │      135000.0 │             4.84 │         0.654 │
│ bigquery   │      135000.0 │             4.81 │          0.65 │
└────────────┴───────────────┴──────────────────┴───────────────┘
*/



